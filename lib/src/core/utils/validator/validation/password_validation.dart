import 'package:flutter/material.dart';
import 'package:lanars/src/core/utils/validator/validation/validation.dart';

/// a validation that checks if the value is a valid password.
class PasswordValidation extends Validation<String> {
  const PasswordValidation({
    this.minLength = 8,
    this.maxLength = 20,
    this.number = false,
    this.upperCase = false,
    this.specialChar = false,
    this.lowerCase = false,
  });

  final int minLength;
  final int maxLength;
  final bool number;
  final bool upperCase;
  final bool specialChar;
  final bool lowerCase;

  static final _numberRegex = RegExp(r'[0-9]');
  static final _upperCaseRegex = RegExp(r'[A-Z]');
  static final _specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  static final _lowerCaseRegex = RegExp(r'[a-z]');

  @override
  String? validate(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }

    if (value.length > maxLength) {
      return 'Password must be at most $maxLength characters';
    }

    if (number && !_numberRegex.hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    if (upperCase && !_upperCaseRegex.hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    if (specialChar && !_specialCharRegex.hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    if (lowerCase && !_lowerCaseRegex.hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    return null;
  }
}
