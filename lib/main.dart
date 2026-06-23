import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sky_cord/app/firebase_options.dart';
import 'package:sky_cord/app/skycord_app.dart';
import 'package:sky_cord/core/di/dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupDependencies();

  runApp(const SkyCordApp());
}
