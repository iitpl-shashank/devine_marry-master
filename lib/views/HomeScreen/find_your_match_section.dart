import 'package:devine_marry/widgets/custom_animated_match_card.dart';
import 'package:flutter/material.dart';

import '../../utils/string_texts.dart';
import '../../utils/themes/app_colors.dart';
import '../../widgets/match_card.dart';

class FindYourMatchSection extends StatelessWidget {
  const FindYourMatchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 25,
          horizontal: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringTexts.find_your_match,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.darkTheme,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            CustomAnimatedMatchCard(
              cards: [
                MatchCard(
                  name: "Mankirat",
                  age: 28,
                  height: "5ft 8in",
                  religion: 'Hindu',
                ),
                MatchCard(
                  name: "Aryan",
                  age: 29,
                  height: "6ft 0in",
                  religion: 'Hindu',
                ),
                MatchCard(
                  name: "Kunal",
                  age: 27,
                  height: "5ft 9in",
                  religion: 'Hindu',
                ),
                MatchCard(
                  name: "Kunal",
                  age: 27,
                  height: "5ft 9in",
                  religion: 'Hindu',
                ),
                MatchCard(
                  name: "Kunal",
                  age: 27,
                  height: "5ft 9in",
                  religion: 'Hindu',
                ),
                MatchCard(
                  name: "Kunal",
                  age: 27,
                  height: "5ft 9in",
                  religion: 'Hindu',
                ),
                MatchCard(
                  name: "Kunal",
                  age: 27,
                  height: "5ft 9in",
                  religion: 'Hindu',
                ),
                MatchCard(
                  name: "Kunal",
                  age: 27,
                  height: "5ft 9in",
                  religion: 'Hindu',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
