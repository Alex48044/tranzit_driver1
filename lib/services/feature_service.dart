import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/feature_model.dart';

class FeatureService {
  static const String _featuresCacheKey = 'cached_features';
  static const String _serverUrlKey = 'server_url';
  
  String? _serverUrl;
  List<FeatureModel> _cachedFeatures = [];

  // СМС всегда активна
  static const Map<String, bool> defaultFeatures = {
    'sms': true,
    'gps': false,
    'maps': false,
    'calls': false,
    'chat': false,
    'push': false,
    'history': false,
    'finance': false,
    'support': false,
    'rating': false,
  };

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _serverUrl = prefs.getString(_serverUrlKey);
  }

  Future<void> setServerUrl(String url) async {
    _serverUrl = url;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_serverUrlKey, url);
  }

  Future<bool> isFeatureEnabled(String featureId) async {
    if (featureId == 'sms') return true;
    
    if (_cachedFeatures.isNotEmpty) {
      final feature = _cachedFeatures.firstWhere(
        (f) => f.id == featureId,
        orElse: () => FeatureModel(id: featureId, name: featureId, enabled: false),
      );
      return feature.enabled;
    }
    
    await loadFeaturesFromServer();
    return isFeatureEnabled(featureId);
  }

  Future<List<FeatureModel>> loadFeaturesFromServer() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/features.json');
      final Map<String, dynamic> data = json.decode(jsonString);
      final List<dynamic> featuresJson = data['features'];
      
      _cachedFeatures = featuresJson.map((json) => FeatureModel.fromJson(json)).toList();
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_featuresCacheKey, json.encode(_cachedFeatures.map((f) => f.toJson()).toList()));
      
      return _cachedFeatures;
    } catch (e) {
      return await _loadFeaturesFromCache();
    }
  }

  Future<List<FeatureModel>> _loadFeaturesFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(_featuresCacheKey);
    
    if (cached != null) {
      final List<dynamic> data = json.decode(cached);
      _cachedFeatures = data.map((json) => FeatureModel.fromJson(json)).toList();
      return _cachedFeatures;
    }
    
    return _getDefaultFeatures();
  }

  List<FeatureModel> _getDefaultFeatures() {
    return defaultFeatures.entries.map((entry) {
      return FeatureModel(
        id: entry.key,
        name: _getFeatureName(entry.key),
        enabled: entry.value,
      );
    }).toList();
  }

  String _getFeatureName(String id) {
    const names = {
      'gps': 'GPS трекинг',
      'maps': 'Карты и маршруты',
      'calls': 'Звонок диспетчеру',
      'chat': 'Чат с диспетчером',
      'push': 'Пуш-уведомления',
      'history': 'История поездок',
      'finance': 'Финансы',
      'sms': 'СМС уведомления',
      'support': 'Поддержка',
      'rating': 'Рейтинг',
    };
    return names[id] ?? id;
  }
}
