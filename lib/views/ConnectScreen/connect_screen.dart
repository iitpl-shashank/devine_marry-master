import 'package:devine_marry/utils/string_texts.dart';
import 'package:flutter/material.dart';
import '../../utils/themes/app_colors.dart';
import '../../widgets/connect_list_item.dart';

class ConnectScreen extends StatelessWidget {
  const ConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for the connect list
    final List<Map<String, String>> connectList = [
      {
        "userName": "John Doe",
        "time": "2 hours ago",
        "description": "Looking for a match.",
        "imageUrl": "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?cs=srgb&dl=pexels-justin-shaifer-501272-1222271.jpg&fm=jpg",
      },
      {
        "userName": "Jane Smith",
        "time": "5 hours ago",
        "description": "Excited to connect!",
        "imageUrl": "https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?cs=srgb&dl=pexels-simon-robben-55958-614810.jpg&fm=jpg",
      },
      {
        "userName": "Alice Johnson",
        "time": "1 day ago",
        "description": "Open to conversations.",
        "imageUrl": "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg",
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringTexts.connects.toUpperCase(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkTheme,
                ),
              ),
              const SizedBox(height: 28),
              // Display the connect list items
              Column(
                children: connectList.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ConnectListItem(
                      userName: item["userName"]!,
                      time: item["time"]!,
                      description: StringTexts.tempDescription,
                      imageUrl: item["imageUrl"]!,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}