import 'package:devine_marry/helper/common_functions.dart';
import 'package:devine_marry/utils/string_texts.dart';
import 'package:flutter/material.dart';
import '../../utils/themes/app_colors.dart';

class InterestsHobbiesSection extends StatelessWidget {
  final String interestAndHobbies;
  InterestsHobbiesSection({
    super.key,
    required this.interestAndHobbies,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringTexts.interestsAndHobbies,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.darkTheme,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: CommonFunctions.splitStringByComma(interestAndHobbies)
              .map((hobby) => hobbyTile(hobby))
              .toList(),
        ),
      ],
    );
  }

  Widget hobbyTile(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.lightTheme.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.lightTheme,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
