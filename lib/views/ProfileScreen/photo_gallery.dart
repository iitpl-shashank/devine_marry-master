import 'dart:io';

import 'package:devine_marry/controller/ProfileController/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/images.dart';
import '../../utils/string_texts.dart';
import '../../utils/themes/app_colors.dart';
import '../../widgets/custom_app_bar.dart';

class PhotoGallery extends StatefulWidget {
  const PhotoGallery({super.key});

  @override
  State<PhotoGallery> createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  final ProfileController profileController = Get.find<ProfileController>();

  void _removePhoto(int index) {
    // Remove the photo from the selectedImages list
    profileController.selectedImages.removeAt(index);
    profileController.update(); // Notify listeners about the change
  }

  void _removeServerImage(int index) {
    // Remove the photo from the galleryImages list
    profileController.galleryImages.removeAt(index);
    profileController.update(); // Notify listeners about the change
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.fetchGalleryImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          appBar: CustomAppBar(
            startIconPath: Svgs.backArrowVector,
            endIconPath: Svgs.notificationVector,
            centerLogoPath: Svgs.logo,
            endIconHeight: 21,
            endIconWidth: 16,
            centerLogoHeight: 51,
            centerLogoWidth: 104,
            onStartIconTap: () {
              Get.back();
            },
            onEndIconTap: () {
              // Handle end icon tap
            },
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  profileController.uploadGalleryImages();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
                  StringTexts.uploadPhoto,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: profileController.galleryImages.length +
                        profileController.selectedImages.length +
                        1, // Add 1 for the "Add Photo" button
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        // Add Photo Button
                        return GestureDetector(
                          onTap: profileController.selectGalleryImages,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.transparent,
                            ),
                            child: const Center(
                              child: Text(
                                "Add Photo",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if (index <=
                          profileController.galleryImages.length) {
                        // Display images fetched from the server
                        final imageIndex =
                            index - 1; // Adjust index for galleryImages
                        return Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(profileController
                                      .galleryImages[imageIndex].image!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                // onTap: () => _removeServerImage(imageIndex),
                                onTap: () {
                                  Get.snackbar(
                                    "Images",
                                    "Server images removed",
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: Get.theme.primaryColor,
                                    colorText: Get.theme.colorScheme.onPrimary,
                                  );
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors
                                        .blue, // Blue color for server images
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        // Display user-selected images
                        final selectedImageIndex =
                            index - profileController.galleryImages.length - 1;
                        return Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: FileImage(File(profileController
                                      .selectedImages[selectedImageIndex]
                                      .path)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () => _removePhoto(selectedImageIndex),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors
                                        .red, // Red color for user-selected images
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
