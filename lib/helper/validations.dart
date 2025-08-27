import 'package:flutter/services.dart';

class ValidatorAndInputFormatters {
  static bool isValidEmail(String email) {
    final pattern = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+\$';
    return RegExp(pattern).hasMatch(email);
  }

  static bool isValidIndianPhoneNumber(String phone) {
    final pattern =
        r'^[6789]\d{9}$'; // Ensures number starts with 6, 7, 8, or 9 and is exactly 10 digits
    return RegExp(pattern).hasMatch(phone);
  }

  static bool isValidPhoneNumber(String phone, String countryCode) {
    String pattern;
    switch (countryCode) {
      case '+91': // India
        pattern = r'^[6789]\d{9}$'; // 10 digits, starts with 6/7/8/9
        break;
      case '+1': // USA/Canada
        pattern = r'^\d{10}$'; // 10 digits
        break;
      case '+44': // UK
        pattern = r'^\d{10,11}$'; // 10 or 11 digits
        break;
      case '+61': // Australia
        pattern = r'^\d{9}$'; // 9 digits
        break;
      case '+81': // Japan
        pattern = r'^\d{10,11}$'; // 10 or 11 digits
        break;
      case '+49': // Germany
        pattern = r'^\d{10,11}$'; // 10 or 11 digits
        break;
      case '+33': // France
        pattern = r'^\d{9}$'; // 9 digits
        break;
      case '+39': // Italy
        pattern = r'^\d{9,10}$'; // 9 or 10 digits
        break;
      case '+971': // UAE
        pattern = r'^\d{9}$'; // 9 digits
        break;
      case '+880': // Bangladesh
        pattern = r'^\d{10}$'; // 10 digits
        break;
      case '+92': // Pakistan
        pattern = r'^\d{10}$'; // 10 digits
        break;
      case '+94': // Sri Lanka
        pattern = r'^\d{9}$'; // 9 digits
        break;
      case '+7': // Russia
        pattern = r'^\d{10}$'; // 10 digits
        break;
      case '+86': // China
        pattern = r'^\d{11}$'; // 11 digits
        break;
      default:
        pattern = r'^\d{6,15}$'; // Generic: 6 to 15 digits
    }
    return RegExp(pattern).hasMatch(phone);
  }

  static String formatPhoneNumber(String phone) {
    return phone.replaceAll(RegExp(r'\D'), '');
  }

  static bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }

  static String capitalizeWords(String text) {
    return text
        .split(' ')
        .map((word) =>
            word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
        .join(' ');
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
