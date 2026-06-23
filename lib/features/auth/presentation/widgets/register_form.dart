import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sky_cord/core/di/dependency_injection.dart';
import 'package:sky_cord/core/theme/app_colors.dart';
import 'package:sky_cord/core/utils/result.dart';
import 'package:sky_cord/core/utils/validators.dart';
import 'package:sky_cord/core/widgets/custom_primary_button.dart';
import 'package:sky_cord/core/widgets/custom_text_form_field.dart';
import 'package:sky_cord/features/auth/presentation/provider/app_auth_provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _registerFormKey,
        child: Column(children: [
          CustomTextFormField(
              controller: _usernameController,
              hintText: "Username",
              validator: (value) => Validators.username(context, value)),
          SizedBox(height: 16),
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
          CustomTextFormField(
            controller: _confirmPasswordController,
            hintText: "Confirm Password",
            obscureText: true,
            validator: (value) => Validators.confirmPassword(
                context, value, _passwordController.text),
          ),
          SizedBox(height: 16),
          CustomPrimaryButton(
            buttonText: "Sign Up",
            onPressed: () async {
              if (_registerFormKey.currentState!.validate()) {
                Result<User?> authState =
                    await getIt<AppAuthProvider>().register(
                  _usernameController.text,
                  _emailController.text,
                  _passwordController.text,
                );
                if (!context.mounted) return;
                if (authState.success) {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => ),
                  // );
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
