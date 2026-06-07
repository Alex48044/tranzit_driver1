import 'package:firebase_remote_config/firebase_remote_config.dart';

class FeatureService {
  final FirebaseRemoteConfig _config = FirebaseRemoteConfig.instance;

  Future<void> init() async {
    await _config.setDefaults({
      'show_technical_tab': true,
      'show_chat_tab': true,
      'enable_order_notifications': true,
      'enable_chat_notifications': true,
    });
    await _config.fetchAndActivate();
  }

  Future<List<Feature>> loadFeaturesFromServer() async {
    return [
      Feature(id: 'show_technical_tab', enabled: _config.getBool('show_technical_tab')),
      Feature(id: 'show_chat_tab', enabled: _config.getBool('show_chat_tab')),
      Feature(id: 'enable_order_notifications', enabled: _config.getBool('enable_order_notifications')),
      Feature(id: 'enable_chat_notifications', enabled: _config.getBool('enable_chat_notifications')),
    ];
  }
}

class Feature {
  final String id;
  final bool enabled;
  Feature({required this.id, required this.enabled});
}
