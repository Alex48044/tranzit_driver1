import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/feature_service.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final featureService = FeatureService();
  await featureService.init();
  runApp(const TranzitApp());
}

class TranzitApp extends StatelessWidget {
  const TranzitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Транзит Водитель',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
