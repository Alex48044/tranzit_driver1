import 'package:flutter/material.dart';
import '../services/feature_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FeatureService _featureService = FeatureService();
  Map<String, bool> _features = {};
  bool _isLoading = true;
  bool _isOnline = false;

  @override
  void initState() {
    super.initState();
    _loadFeatures();
  }

  Future<void> _loadFeatures() async {
    await _featureService.init();
    final features = await _featureService.loadFeaturesFromServer();
    
    setState(() {
      for (var f in features) {
        _features[f.id] = f.enabled;
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Транзит', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isOnline ? Colors.green : Colors.grey,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  _isOnline ? 'Онлайн' : 'Оффлайн',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuItem(
            icon: Icons.list_alt,
            title: 'Заказы',
            subtitle: 'Новые и активные заказы',
            onTap: () => _navigateTo('orders'),
          ),
          const Divider(),
          
          if (_features['chat'] == true) ...[
            _buildMenuItem(
              icon: Icons.chat_bubble_outline,
              title: 'Чат с диспетчером',
              subtitle: 'Текстовые сообщения',
              onTap: () => _navigateTo('chat'),
            ),
            const Divider(),
          ],
          
          if (_features['maps'] == true) ...[
            _buildMenuItem(
              icon: Icons.map_outlined,
              title: 'Карта и маршрут',
              subtitle: 'Прокладка маршрута до пассажира',
              onTap: () => _navigateTo('map'),
            ),
            const Divider(),
          ],
          
          if (_features['calls'] == true) ...[
            _buildMenuItem(
              icon: Icons.phone_outlined,
              title: 'Звонок диспетчеру',
              subtitle: 'Связаться с диспетчерской',
              onTap: () => _navigateTo('call'),
            ),
            const Divider(),
          ],
          
          if (_features['history'] == true) ...[
            _buildMenuItem(
              icon: Icons.history,
              title: 'История поездок',
              subtitle: 'Завершённые заказы',
              onTap: () => _navigateTo('history'),
            ),
            const Divider(),
          ],
          
          if (_features['finance'] == true) ...[
            _buildMenuItem(
              icon: Icons.account_balance_wallet_outlined,
              title: 'Финансы',
              subtitle: 'Заработок и выплаты',
              onTap: () => _navigateTo('finance'),
            ),
            const Divider(),
          ],
          
          if (_features['rating'] == true) ...[
            _buildMenuItem(
              icon: Icons.star_outline,
              title: 'Мой рейтинг',
              subtitle: 'Оценки пассажиров',
              onTap: () => _navigateTo('rating'),
            ),
            const Divider(),
          ],
          
          if (_features['support'] == true) ...[
            _buildMenuItem(
              icon: Icons.support_agent,
              title: 'Поддержка',
              subtitle: 'Помощь и вопросы',
              onTap: () => _navigateTo('support'),
            ),
            const Divider(),
          ],
          
          _buildMenuItem(
            icon: Icons.person_outline,
            title: 'Профиль',
            subtitle: 'Мои данные и настройки',
            onTap: () => _navigateTo('profile'),
          ),
          const Divider(),
          
          _buildMenuItem(
            icon: Icons.sms_outlined,
            title: 'СМС уведомления',
            subtitle: 'Уведомления о заказах через SMS',
            onTap: () => _navigateTo('sms_settings'),
            showBadge: true,
            badgeText: 'Активно',
          ),
          const Divider(),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool showBadge = false,
    String badgeText = '',
  }) {
    return ListTile(
      leading: Icon(icon, size: 28, color: Colors.green),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: showBadge
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badgeText,
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            )
          : const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  void _navigateTo(String screen) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Экран $screen в разработке')),
    );
  }
}
