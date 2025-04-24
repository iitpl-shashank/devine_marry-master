import 'package:devine_marry/models/home/match_preference_model.dart';
import 'package:devine_marry/widgets/custom_match_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/AuthController/auth_controller.dart';
import '../../helper/date_converter.dart';
import '../../utils/images.dart';
import '../../utils/themes/app_colors.dart';
import '../../widgets/custom_app_bar.dart';

class SeeAllMatchesScreen extends StatelessWidget {
  final List<User> users;
  final String title;
  final AuthController authController = Get.find();
  SeeAllMatchesScreen({
    super.key,
    required this.users,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkTheme,
                ),
              ),
              if (users.isNotEmpty) const SizedBox(height: 8),
              if (users.isNotEmpty)
                Text(
                  '${users.length} Connect found',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black.withOpacity(0.70),
                  ),
                ),
              const SizedBox(height: 12),
              users.isNotEmpty
                  ? Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return CustomMatchCard(
                            imageUrl: user.imageUrl ?? '',
                            name: user.firstName ?? '',
                            age: int.parse(AgeCalculator.calculateAge(
                                user.birthDate.toString())),
                            height: HeightConverter.convertCmToFeetAndInches(
                                user.height ?? 180),
                            religion: authController.religionResponse.religions
                                .firstWhere(
                                    (element) => element.id == user.religion,
                                    orElse: () => authController
                                        .religionResponse.religions.first)
                                .name,
                            userId: user.id.toString(),
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: Center(
                        child: Text(
                          'No matches found',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black.withOpacity(0.70),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
