import 'package:devine_marry/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

import '../../utils/string_texts.dart';
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
    // Add more users here
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomSearchBar(
              hintText: 'Search...',
              onChanged: (value) {
                debugPrint('Search query: $value');
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              StringTexts.matches_based_on_your_preferences,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.darkTheme,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
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
          ],
        ),
      ),
    );
  }
}
