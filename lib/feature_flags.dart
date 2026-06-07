import 'package:firebase_remote_config/firebase_remote_config.dart';

class FeatureFlags {
  static final FeatureFlags _instance = FeatureFlags._internal();
  factory FeatureFlags() => _instance;
  FeatureFlags._internal();

  late final FirebaseRemoteConfig _config;

  Future<void> init() async {
    _config = FirebaseRemoteConfig.instance;
    
    // Значения по умолчанию (если нет интернета или настройки в Firebase)
    await _config.setDefaults({
      'show_technical_tab': true,
      'show_chat_tab': true,
      'enable_order_notifications': true,
      'enable_chat_notifications': true,
      'server_ip': '192.168.1.100', // запасной IP
    });
    
    // Загружаем настройки из Firebase
    await _config.fetchAndActivate();
  }

  // Геттеры для проверки статуса функций
  bool get showTechnicalTab => _config.getBool('show_technical_tab');
  bool get showChatTab => _config.getBool('show_chat_tab');
  bool get enableOrderNotifications => _config.getBool('enable_order_notifications');
  bool get enableChatNotifications => _config.getBool('enable_chat_notifications');
  String get serverIp => _config.getString('server_ip');
}
