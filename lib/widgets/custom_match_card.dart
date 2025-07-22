import 'package:devine_marry/controller/HomeController/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/themes/app_colors.dart';

class CustomMatchCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int age;
  final String height;
  final String religion;
  final String userId;
  final HomeController homeController = Get.find();
  final int connectionStatus;

  CustomMatchCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.age,
    required this.religion,
    required this.height,
    required this.userId,
    required this.connectionStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: InkWell(
        onTap: () {
          homeController.homeUserNavigation(
            id: userId,
          );
        },
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                    if (connectionStatus != 0)
                      InkWell(
                          onTap: () {
                            Get.snackbar(
                              "Divine Marry",
                              "Connect with $name",
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: AppColors.lightTheme,
                              colorText: Colors.white,
                              duration: Duration(seconds: 2),
                            );
                          },
                          child: connectionStatus == 1
                              ? Container(
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
                                    Icons.chat,
                                    color: AppColors.white,
                                    size: 16,
                                  ))
                              : Container(
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
                                  ))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
