import 'package:flutter/material.dart';
import 'package:lanars/src/feature/auth/widget/email_text_field.dart';
import 'package:lanars/src/feature/auth/widget/password_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    this.readOnly = false,
    this.enable = true,
    this.onChanged,
    this.onTap,
  });

  final GlobalKey formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool readOnly;
  final bool enable;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: AutofillGroup(
        child: Column(
          children: [
            EmailTextField(
              controller: widget.emailController,
              readOnly: widget.readOnly,
              enable: widget.enable,

            ),
            PasswordTextField(
              controller: widget.passwordController,
              readOnly: widget.readOnly,
              enable: widget.enable,
              onTap: widget.onTap,
            ),
          ],
        ),
      ),
    );
  }
}
