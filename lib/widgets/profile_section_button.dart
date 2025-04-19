import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/images.dart';
import '../utils/themes/app_colors.dart';

class ProfileSectionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool showDivider;

  const ProfileSectionButton({
    super.key,
    required this.title,
    required this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.divider,
                ),
              ),
              SvgPicture.asset(Svgs.rightArrowVector),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          if (showDivider)
            Divider(
              color: AppColors.black.withOpacity(0.13),
              thickness: 1,
            ),
        ],
      ),
    );
  }
}
