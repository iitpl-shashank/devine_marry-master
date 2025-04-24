import 'package:flutter/material.dart';
import '../utils/themes/app_colors.dart';

class TappableSearchBar extends StatelessWidget {
  final String hintText;
  final VoidCallback onTap;
  final double? borderWidth;

  const TappableSearchBar({
    super.key,
    required this.hintText,
    required this.onTap,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Trigger navigation when tapped
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: AppColors.black.withOpacity(0.20),
            width: borderWidth ?? 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(Icons.search_sharp, color: AppColors.black.withOpacity(0.50)),
            const SizedBox(width: 8),
            Text(
              hintText,
              style: TextStyle(
                color: AppColors.black.withOpacity(0.50),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
