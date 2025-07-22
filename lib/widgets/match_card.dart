import 'package:devine_marry/controller/HomeController/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/themes/app_colors.dart';

class MatchCard extends StatelessWidget {
  final String name;
  final int age;
  final String height;
  final String religion;
  final String imageUrl;
  final String userId;
  final int connectionStatus;
  final HomeController homeController = Get.find<HomeController>();

  MatchCard({
    super.key,
    required this.name,
    required this.age,
    required this.height,
    required this.religion,
    required this.imageUrl,
    required this.userId,
    required this.connectionStatus,
  });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         homeController.homeUserNavigation(
//           id: userId,
//         );
//       },
//       child: Container(
//         width: 300,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           image: DecorationImage(
//             image: NetworkImage(imageUrl),
//             onError: (exception, stackTrace) {
//               debugPrint('Error loading image: $exception');
//             },
//             fit: BoxFit.cover,
//           ),
//         ),
//         alignment: Alignment.bottomLeft,
//         padding: const EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 16,
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500,
//                     shadows: [
//                       Shadow(blurRadius: 4, color: Colors.black),
//                     ],
//                   ),
//                 ),
//                 Text(
//                   "$age yrs | $height\n$religion",
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     shadows: [
//                       Shadow(blurRadius: 4, color: Colors.black),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             InkWell(
//               onTap: () {
//                 Get.snackbar(
//                   "Divine Marry",
//                   "Connect with $name",
//                   snackPosition: SnackPosition.BOTTOM,
//                   backgroundColor: AppColors.lightTheme,
//                   colorText: Colors.white,
//                   duration: Duration(seconds: 2),
//                 );
//               },
//               child: Container(
//                 height: 36,
//                 width: 36,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: AppColors.lightTheme,
//                   border: Border.all(
//                     color: Colors.white,
//                     width: 1,
//                   ),
//                 ),
//                 child: const Icon(
//                   Icons.add,
//                   color: AppColors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
        ),
        child: Stack(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                width: 300,
                height: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 300,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 300,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 50,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                          "$age yrs | $height\n$religion",
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
                    connectionStatus == 1
                        ? InkWell(
                            onTap: () {
                              Get.snackbar(
                                "Divine Marry",
                                "CHAT SCREEN",
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: AppColors.lightTheme,
                                colorText: Colors.white,
                                duration: const Duration(seconds: 2),
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
                                Icons.chat,
                                color: AppColors.white,
                                size: 16,
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              homeController.homeUserNavigation(
                                id: userId,
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
            ),
          ],
        ),
      ),
    );
  }
}
