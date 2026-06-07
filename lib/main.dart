import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'feature_flags.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FeatureFlags().init();
  runApp(const TranzitApp());
}
