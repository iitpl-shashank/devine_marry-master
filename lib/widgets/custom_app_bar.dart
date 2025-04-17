import 'package:devine_marry/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String startIconPath;
  final String endIconPath;
  final String centerLogoPath;
  final VoidCallback onStartIconTap;
  final VoidCallback onEndIconTap;

  double? startIconWidth;
  double? startIconHeight;
  double? centerLogoHeight;
  double? centerLogoWidth;
  double? endIconWidth;
  double? endIconHeight;
  double? endIconBackgroundRadius;

  CustomAppBar({
    super.key,
    required this.startIconPath,
    required this.endIconPath,
    required this.centerLogoPath,
    required this.onStartIconTap,
    required this.onEndIconTap,
    this.startIconWidth,
    this.startIconHeight,
    this.centerLogoHeight,
    this.centerLogoWidth,
    this.endIconWidth,
    this.endIconHeight,
    this.endIconBackgroundRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 65,
        left: 18,
        right: 18,
      ),
      color: AppColors.appBarBackground,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onStartIconTap,
                child: SvgPicture.asset(
                  startIconPath,
                  width: startIconWidth ?? 24,
                  height: startIconHeight ?? 24,
                ),
              ),
              SvgPicture.asset(
                centerLogoPath,
                width: centerLogoWidth ?? 100,
                height: centerLogoHeight ?? 40,
              ),
              GestureDetector(
                onTap: onEndIconTap,
                child: Container(
                  width: endIconBackgroundRadius ?? 40,
                  height: endIconBackgroundRadius ?? 40,
                  decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      endIconPath,
                      width: endIconWidth ?? 24,
                      height: endIconHeight ?? 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(100); // Set the height of the app bar
}
