import 'package:flutter/material.dart';
import 'package:lanars/src/core/utils/validator/validation/email_validation.dart';
import 'package:lanars/src/core/utils/validator/validator.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    required this.controller,
    this.readOnly = false,
    this.enable = true,
  });

  final TextEditingController controller;
  final bool readOnly;
  final bool enable;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92.0,
      child: TextFormField(
        enabled: enable,
        controller: controller,
        validator: Validator.apply(
          context,
          [const EmailValidation()],
        ),
        decoration: const InputDecoration(
          labelText: 'Email',
        ),
        readOnly: readOnly,
        autofillHints: const [AutofillHints.email],
      ),
    );
  }
}
