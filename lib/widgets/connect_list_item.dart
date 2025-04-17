import 'package:flutter/material.dart';
import '../utils/themes/app_colors.dart';

class ConnectListItem extends StatelessWidget {
  final String userName;
  final String time;
  final String description;
  final String imageUrl;

  const ConnectListItem({
    super.key,
    required this.userName,
    required this.time,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: NetworkImage(imageUrl),
              onBackgroundImageError: (error, stackTrace) {
                debugPrint("Error loading image: $error");
              },
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textBlack,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        time,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    maxLines: 1,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textBlack.withOpacity(0.70)),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Divider(
          thickness: 1,
          color: AppColors.divider.withOpacity(
            0.12,
          ),
        ),
      ],
    );
  }
}
