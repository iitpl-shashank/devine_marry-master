import 'package:devine_marry/utils/string_texts.dart';
import 'package:devine_marry/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
           SizedBox(height: 91),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringTexts.Preferences,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.darkTheme,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        height: 1.40,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}