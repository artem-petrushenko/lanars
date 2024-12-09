import 'package:flutter/material.dart';
import 'package:lanars/src/core/utils/validator/validation/validation.dart';

/// a validation that checks if the value is a valid email.
class EmailValidation extends Validation<String> {
  const EmailValidation({
    this.minLength = 6,
    this.maxLength = 30,
  });

  final int minLength;
  final int maxLength;

  @override
  String? validate(BuildContext context, String? value) {
    /// Regular have a length of 10 characters for username, the domain and 10 characters for the subdomain.
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+\\/=?^_`{|}~-]{1,10}@(?:(?!.*--)[a-zA-Z0-9-]{1,10}(?<!-))(?:\.(?:[a-zA-Z0-9-]{2,10}))+$");
    if (value == null || value.isEmpty) return 'Email is required';
    if (value.length < minLength) return 'Email must be at least $minLength characters';
    if (value.length > maxLength) return 'Email must be at most $maxLength characters';
    if (!emailRegex.hasMatch(value)) return 'Invalid email format';
    return null;
  }
}
