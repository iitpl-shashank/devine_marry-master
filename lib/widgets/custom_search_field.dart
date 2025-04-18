import 'package:flutter/material.dart';

import '../utils/themes/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  final double? borderWidth;

  const CustomSearchBar({
    Key? key,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.borderWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(Icons.search_sharp, color: AppColors.black.withOpacity(0.50)),
        filled: true,
        fillColor: AppColors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.black.withOpacity(0.20), width: borderWidth ?? 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.black.withOpacity(0.20), width: borderWidth ?? 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.black.withOpacity(0.20), width: borderWidth ?? 1),
        ),
      ),
    );
  }
}
