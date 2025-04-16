import 'package:flutter/services.dart';

class ValidatorAndInputFormatters {
  static bool isValidEmail(String email) {
    final pattern = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+\$';
    return RegExp(pattern).hasMatch(email);
  }

  static bool isValidIndianPhoneNumber(String phone) {
    final pattern = r'^[6789]\d{9}$'; // Ensures number starts with 6, 7, 8, or 9 and is exactly 10 digits
    return RegExp(pattern).hasMatch(phone);
  }

  static String formatPhoneNumber(String phone) {
    return phone.replaceAll(RegExp(r'\D'), '');
  }

  static bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }

  static String capitalizeWords(String text) {
    return text.split(' ').map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '').join(' ');
  }

  static String removeWhitespace(String text) {
    return text.trim();
  }

  static TextInputFormatter numericInputFormatter() {
    return FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
  }

  static bool isValidPassword(String password) {
    return password.length >= 8;
  }
}
