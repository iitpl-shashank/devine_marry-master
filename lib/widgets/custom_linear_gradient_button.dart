import 'package:devine_marry/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CustomLinearGradientButton extends StatelessWidget {
  final Color? startColor;
  final Color? endColor;
  final double borderRadius;
  final double height;
  final double width;
  final Widget child;

  const CustomLinearGradientButton({
    Key? key,
    this.startColor,
    this.endColor,
    this.borderRadius = 12.0,
    this.height = 60.0,
    this.width = 60.0,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            startColor ?? AppColors.lightTheme,
            endColor ?? AppColors.darkTheme,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(child: child),
    );
  }
}
