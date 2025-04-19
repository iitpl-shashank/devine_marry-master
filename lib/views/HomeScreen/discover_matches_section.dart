import 'package:flutter/material.dart';

import '../../utils/images.dart';
import '../../utils/string_texts.dart';
import '../../utils/themes/app_colors.dart';
import '../../widgets/custom_discover_icon.dart';

class DiscoverMatchesSection extends StatelessWidget {
  const DiscoverMatchesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundGrey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 25,
          horizontal: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringTexts.discover_matches,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.darkTheme,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomDiscoverIcon(
                  svgPath: Svgs.religionVector,
                  padding: 10.0,
                  borderColor: AppColors.lightTheme,
                  label: "Religion",
                ),
                CustomDiscoverIcon(
                  svgPath: Svgs.qualificationVector,
                  padding: 10.0,
                  borderColor: AppColors.lightTheme,
                  label: "Qualification",
                ),
                CustomDiscoverIcon(
                  svgPath: Svgs.stateVector,
                  padding: 10.0,
                  borderColor: AppColors.lightTheme,
                  label: "State",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
