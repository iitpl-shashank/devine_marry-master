import 'package:devine_marry/utils/themes/app_colors.dart';
import 'package:devine_marry/views/HomeScreen/discover_matches_section.dart';
import 'package:devine_marry/views/HomeScreen/find_your_match_section.dart';
import 'package:devine_marry/views/HomeScreen/new_matches_section.dart';
import 'package:flutter/material.dart';

import '../../utils/images.dart';
import '../../utils/string_texts.dart';
import '../../widgets/custom_discover_icon.dart';
import '../../widgets/custom_search_field.dart';
import '../../widgets/home_user_item.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> data = [
    {"image": "https://randomuser.me/api/portraits/men/1.jpg", "name": "John"},
    {
      "image": "https://randomuser.me/api/portraits/women/2.jpg",
      "name": "Anna"
    },
    {"image": "https://randomuser.me/api/portraits/men/3.jpg", "name": "Mike"},
    {
      "image":
          "https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg",
      "name": "Daven"
    },
    {
      "image":
          "https://img.freepik.com/free-photo/portrait-father-his-backyard_23-2149489567.jpg?semt=ais_hybrid&w=740",
      "name": "Richard"
    },
    // Add more users here
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomSearchBar(
                hintText: 'Search...',
                onChanged: (value) {
                  debugPrint('Search query: $value');
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),

            // <--- Matches Based on your Preferences Section --->

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Text(
                StringTexts.matches_based_on_your_preferences,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkTheme,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return UserItem(
                      imageUrl: data[index]['image']!,
                      name: data[index]['name']!,
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            // <--- Find Your Match Section --->

            FindYourMatchSection(),
            SizedBox(
              height: 24,
            ),

            // <--- Discover Matches Section --->

            DiscoverMatchesSection(),
            SizedBox(
              height: 24,
            ),

            // <--- New Matches Section --->

            NewMatchesSection(
              title: StringTexts.newMatches,
            ),

            // <--- Matches in your state Section --->

            NewMatchesSection(
              title: StringTexts.matchesInYourState,
              backgroundColor: AppColors.backgroundGrey,
            ),
            SizedBox(
              height: 34,
            ),
          ],
        ),
      ),
    );
  }
}
