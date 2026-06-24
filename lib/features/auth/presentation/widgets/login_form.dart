import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sky_cord/core/di/dependency_injection.dart';
import 'package:sky_cord/core/theme/app_colors.dart';
import 'package:sky_cord/core/utils/result.dart';
import 'package:sky_cord/core/utils/validators.dart';
import 'package:sky_cord/core/widgets/custom_primary_button.dart';
import 'package:sky_cord/core/widgets/custom_text_form_field.dart';
import 'package:sky_cord/features/auth/presentation/provider/app_auth_provider.dart';
import 'package:sky_cord/features/main_layout/presentation/views/main_layout_view.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _loginFormKey,
        child: Column(children: [
          CustomTextFormField(
              controller: _emailController,
              hintText: "Email",
              validator: (value) => Validators.email(context, value)),
          SizedBox(height: 16),
          CustomTextFormField(
            controller: _passwordController,
            hintText: "Password",
            obscureText: true,
            validator: (value) => Validators.password(context, value),
          ),
          SizedBox(height: 16),
          CustomPrimaryButton(
            buttonText: "Login",
            onPressed: () async {
              if (_loginFormKey.currentState!.validate()) {
                Result<User?> authState = await getIt<AppAuthProvider>().login(
                  _emailController.text,
                  _passwordController.text,
                );
                if (!context.mounted) return;
                if (authState.success) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MainLayoutView()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(authState.message ??
                          "Something went wrong, Try again"),
                      backgroundColor: AppColors.redColor,
                    ),
                  );
                }
              }
            },
          )
        ]));
  }
}
