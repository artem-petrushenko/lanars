import 'package:flutter/material.dart';
import 'package:lanars/src/core/utils/validator/validation/password_validation.dart';
import 'package:lanars/src/core/utils/validator/validator.dart';

/// {@template password_text_field}
/// _PasswordTextField widget
/// {@endtemplate}
class PasswordTextField extends StatelessWidget {
  /// {@macro password_text_field}
  const PasswordTextField({
    super.key,
    required this.controller,
    this.readOnly = false,
    this.enable = true,
    this.onChanged,
    this.onTap,
    this.errorText,
  });

  final TextEditingController controller;
  final bool readOnly;
  final bool enable;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92.0,
      child: TextFormField(
        controller: controller,
        obscureText: true,
        readOnly: readOnly,
        enabled: enable,
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
        decoration: InputDecoration(
          labelText: 'Password',
          errorText: errorText,
        ),
        onChanged: onChanged,
        textInputAction: TextInputAction.next,
        onTap: onTap,
      ),
    );
  }
}
