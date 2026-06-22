import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sky_cord/core/theme/app_icons.dart';
import 'package:sky_cord/core/theme/app_text_styles.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppIcons.logo, width: 200),
            Text("SkyCord Chat App", style: AppTextStyles.bold20Grey),
          ],
        ),
      ),
    );
  }

  void _init() {
    Timer(Duration(seconds: 3), () {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => ),
      // );
    });
  }
}
