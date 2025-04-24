import 'package:devine_marry/controller/HomeController/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/themes/app_colors.dart';

class MatchCard extends StatelessWidget {
  final String name;
  final int age;
  final String height;
  final String religion;
  final String imageUrl;
  final String userId;
  final HomeController homeController = Get.find<HomeController>();

  MatchCard({
    super.key,
    required this.name,
    required this.age,
    required this.height,
    required this.religion,
    required this.imageUrl,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        homeController.homeUserNavigation(
          id: userId,
        );
      },
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            onError: (exception, stackTrace) {
              debugPrint('Error loading image: $exception');
            },
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(blurRadius: 4, color: Colors.black),
                    ],
                  ),
                ),
                Text(
                  "$age yrs | $height | $religion",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    shadows: [
                      Shadow(blurRadius: 4, color: Colors.black),
                    ],
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Get.snackbar(
                  "Divine Marry",
                  "Connect with $name",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.lightTheme,
                  colorText: Colors.white,
                  duration: Duration(seconds: 2),
                );
              },
              child: Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.lightTheme,
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
