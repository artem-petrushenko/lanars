import 'package:flutter/material.dart';
import 'package:lanars/src/core/utils/validator/validation/email_validation.dart';
import 'package:lanars/src/core/utils/validator/validator.dart';

class EmailTextField extends StatefulWidget {
  const EmailTextField({
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
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final String? errorText;

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92.0,
      child: TextFormField(
        enabled: widget.enable,
        controller: widget.controller,
        validator: Validator.apply(
          context,
          [const EmailValidation()],
        ),
        decoration: InputDecoration(
          labelText: 'Email',
          errorText: widget.errorText,
        ),
        readOnly: widget.readOnly,
        autofillHints: const [AutofillHints.email],
        textInputAction: TextInputAction.next,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
      ),
    );
  }
}
