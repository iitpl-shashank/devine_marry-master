import 'package:flutter/material.dart';

import '../utils/themes/app_colors.dart';

class CustomMatchCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int age;
  final int height;
  final String religion;

  const CustomMatchCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.age,
    required this.religion,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 255,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Rounded corners
        image: DecorationImage(
          image: NetworkImage(imageUrl), // Network image URL
          fit: BoxFit.cover, // Cover the entire container
        ),
      ),
      child: Stack(
        children: [
          // Bottom Row with Text and Add Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          "$age yrs | $height",
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          religion,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Add Button
                  Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.lightTheme,
                      border: Border.all(
                        color: Colors.white, // White border color
                        width: 1, // Border width of 1px
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
