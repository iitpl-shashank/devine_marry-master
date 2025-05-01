import 'dart:io';

import 'package:devine_marry/controller/ProfileController/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
  // final List<File> images = []; // List to store selected image files
  final ProfileController profileController = Get.find<ProfileController>();

  // final ImagePicker _picker = ImagePicker();
  Future<void> _addPhoto() async {
    // Open the gallery and allow the user to select multiple images
    // final List<XFile>? selectedImages = await _picker.pickMultiImage();

    // if (selectedImages != null && selectedImages.isNotEmpty) {
    //   setState(() {
    //     // Add the selected images to the list
    //     images.addAll(selectedImages.map((image) => File(image.path)));
    //   });
    // }
  }

  void _removePhoto(int index) {
    // Remove the photo at the given index
    // setState(() {
    //   images.removeAt(index);
    // });
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
                    itemCount: profileController.selectedImages.length +
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
                      } else {
                        // Display Image with Cross Button
                        final imageIndex = index - 1; // Adjust index for images
                        return Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: FileImage(File(profileController
                                      .selectedImages[imageIndex].path)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () => _removePhoto(imageIndex),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
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
