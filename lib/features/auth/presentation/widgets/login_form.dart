import 'package:flutter/material.dart';
import 'package:sky_cord/core/utils/validators.dart';
import 'package:sky_cord/core/widgets/custom_primary_button.dart';
import 'package:sky_cord/core/widgets/custom_text_form_field.dart';

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
            onPressed: () {
              if (_loginFormKey.currentState!.validate()) {}
            },
          )
        ]));
  }
}
