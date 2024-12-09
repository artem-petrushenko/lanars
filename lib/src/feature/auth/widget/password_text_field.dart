import 'package:flutter/material.dart';
import 'package:lanars/src/core/utils/validator/validation/password_validation.dart';
import 'package:lanars/src/core/utils/validator/validator.dart';

/// {@template password_text_field}
/// _PasswordTextField widget
/// {@endtemplate}
class PasswordTextField extends StatefulWidget {
  /// {@macro password_text_field}
  const PasswordTextField({
    super.key,
    required this.controller,
    this.readOnly = false,
    this.enable = true,
  });

  final TextEditingController controller;
  final bool readOnly;
  final bool enable;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92.0,
      child: TextFormField(
        controller: widget.controller,
        obscureText: true,
        readOnly: widget.readOnly,
        enabled: widget.enable,
        validator: Validator.apply(
          context,
          [
            const PasswordValidation(
              minLength: 6,
              maxLength: 10,
              upperCase: true,
              number: true,
              lowerCase: true,
            ),
          ],
        ),
        autofillHints: const [AutofillHints.password],
        decoration: const InputDecoration(
          labelText: 'Password',
        ),
      ),
    );
  }
}
