import 'package:flutter/material.dart';
import 'package:sky_cord/core/theme/app_theme.dart';
import 'package:sky_cord/features/splash/splash_view.dart';

class SkyCordApp extends StatelessWidget {
  const SkyCordApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "SkyCord",
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: const SplashView());
  }
}
