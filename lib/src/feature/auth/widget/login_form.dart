import 'package:flutter/material.dart';
import 'package:lanars/src/feature/auth/widget/email_text_field.dart';
import 'package:lanars/src/feature/auth/widget/password_text_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    this.readOnly = false,
    this.enable = true,
    this.onChanged,
    this.onTap,
    this.errorText,
  });

  final GlobalKey formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool readOnly;
  final bool enable;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: AutofillGroup(
        child: Column(
          children: [
            EmailTextField(
              controller: emailController,
              readOnly: readOnly,
              enable: enable,
              onTap: onTap,
              errorText: errorText,
            ),
            PasswordTextField(
              controller: passwordController,
              readOnly: readOnly,
              enable: enable,
              onTap: onTap,
              errorText: errorText,
            ),
          ],
        ),
      ),
    );
  }
}
