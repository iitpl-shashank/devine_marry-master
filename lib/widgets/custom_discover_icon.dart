import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/themes/app_colors.dart';

class CustomDiscoverIcon extends StatelessWidget {
  final String svgPath;
  final String label; // Text to display under the icon
  final double size;
  final double padding;
  final Color borderColor;

  const CustomDiscoverIcon({
    Key? key,
    required this.svgPath,
    required this.label, // Add label as a required parameter
    this.size = 82, // Default size of the circle
    this.padding = 8.0, // Default padding inside the circle
    this.borderColor = AppColors.darkTheme, // Default border color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Ensures the column takes minimal space
      children: [
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: borderColor, // Border color
              width: 2.0, // Border width
            ),
            color: Colors.transparent, // Transparent background
          ),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Center(
              child: SvgPicture.asset(
                svgPath,
                height: 42,
                width: 42,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8), // Space between the icon and the text
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.black.withOpacity(0.80), // Text color
          ),
          textAlign: TextAlign.center, // Center align the text
        ),
      ],
    );
  }
}
