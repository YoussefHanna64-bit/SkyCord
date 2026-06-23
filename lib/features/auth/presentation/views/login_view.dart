import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sky_cord/core/theme/app_icons.dart';
import 'package:sky_cord/core/widgets/custom_rich_text.dart';
import 'package:sky_cord/features/auth/presentation/widgets/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppIcons.logo, width: 150),
                SizedBox(height: 16),
                LoginForm(),
                SizedBox(height: 32),
                CustomRichText(
                  normalText: "Don't have an account? ",
                  styledText: "Sign Up",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
