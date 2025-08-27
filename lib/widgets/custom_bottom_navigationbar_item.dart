import 'package:devine_marry/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBarItem extends StatelessWidget {
  final String svgIconPath;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const CustomBottomNavigationBarItem({
    Key? key,
    required this.svgIconPath,
    required this.label,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.lightThemeWith15Opacity
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  svgIconPath,
                  color: isActive
                      ? AppColors.darkTheme
                      : AppColors.blackWith40Opacity,
                  width: 20,
                  height: 20,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive
                    ? AppColors.lightTheme
                    : AppColors.blackWith40Opacity,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
