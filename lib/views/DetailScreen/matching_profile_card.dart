import 'package:devine_marry/controller/ProfileController/profile_controller.dart';
import 'package:devine_marry/utils/string_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/themes/app_colors.dart';

class MatchCard extends StatelessWidget {
  final String userImageUrl;
  const MatchCard({
    super.key,
    required this.userImageUrl,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.darkTheme.withOpacity(0.07),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.darkTheme,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                  bottom: Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    StringTexts.matchesYourProfile,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 70,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                left: 60,
                                child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 4,
                                      ),
                                    ),
                                    child: GetBuilder<ProfileController>(
                                        builder: (profileController) {
                                      return CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          profileController.profile.value?.data
                                                  ?.user?.imageUrl ??
                                              profileController
                                                  .defaultProfileImage,
                                        ),
                                        radius: 42,
                                      );
                                    })),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 4,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    userImageUrl,
                                  ),
                                  radius: 42,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 6),
            _detailRow("Height:", "5ft 8 in"),
            _detailRow("Age:", "28"),
            _detailRow("Religion:", "Hindu"),
            _detailRow("Profession:", "Accountant", hideDivider: true),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value, {bool hideDivider = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        children: [
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.black.withOpacity(0.6),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.green,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(StringTexts.matched,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.green,
                          )),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: !hideDivider ? 6 : 20),
          if (!hideDivider)
            Divider(
              color: AppColors.black.withOpacity(0.1),
              thickness: 1,
            ),
        ],
      ),
    );
  }
}
