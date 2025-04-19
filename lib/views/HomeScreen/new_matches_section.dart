import 'package:flutter/material.dart';

import '../../utils/string_texts.dart';
import '../../utils/themes/app_colors.dart';
import '../../widgets/custom_match_card.dart';

class NewMatchesSection extends StatelessWidget {
  final String title;
  final Color? backgroundColor;

  const NewMatchesSection({
    super.key,
    required this.title,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: backgroundColor ?? AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 25,
          horizontal: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkTheme,
                  ),
                ),
                Text(
                  StringTexts.seeAll,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black.withOpacity(0.60),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 255, // Height of the CustomMatchCard
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Horizontal scrolling
                itemCount: 5, // Number of cards
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index == 4 ? 0 : 16, // Add spacing between cards
                    ),
                    child: CustomMatchCard(
                      imageUrl:
                          'https://randomuser.me/api/portraits/men/${index + 1}.jpg',
                      name: 'User ${index + 1}',
                      age: 20,
                      height: 170,
                      religion: 'Hindu',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
