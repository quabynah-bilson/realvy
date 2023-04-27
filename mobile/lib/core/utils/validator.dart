import 'package:flutter/material.dart';
import 'package:mobile/core/utils/extensions.dart';
import 'package:shared_utils/shared_utils.dart' show TextX;

class Validators {
  /// simple input validator
  static String? validate(String? input) {
    if (input.isNullOrEmpty()) return 'required';
    return null;
  }

  static String? validateAuthCode(BuildContext context, String? input) {
    input = input?.replaceAll(' ', '');
    if (input.isNullOrEmpty()) return context.localizer.required;
    var regex = RegExp(r'^\d{6}$');
    return regex.hasMatch(input!.trim())
        ? null
        : context.localizer.invalidAuthCode;
  }

  static String? validatePhone(BuildContext context, String? input) {
    input = input?.replaceAll(' ', '');
    if (input.isNullOrEmpty()) return context.localizer.required;
    var regex =
        RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$');
    return regex.hasMatch(input!.trim())
        ? null
        : context.localizer.invalidPhoneNumber;
  }

  static String? validateEmail(BuildContext context, String? input) {
    if (input.isNullOrEmpty()) return context.localizer.required;
    var regex = RegExp(r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)');
    return regex.hasMatch(input!.trim())
        ? null
        : context.localizer.invalidEmail;
  }

  static String? validatePassword(BuildContext context, String? input,
      [String? confirmPassword]) {
    if (input.isNullOrEmpty()) return context.localizer.required;

    /// min length of 4
    var regex = RegExp(r'[A-Za-z0-9@#$%^&+=]{4,}');
    var validated = regex.hasMatch(input!.trim());
    if (!validated) return context.localizer.passwordTooShort;
    if (confirmPassword != null && input != confirmPassword) {
      return context.localizer.passwordsDoNotMatch;
    }
    return null;
  }
}
