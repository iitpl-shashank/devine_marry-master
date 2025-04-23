import 'package:devine_marry/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final VoidCallback onImageTap;
  final VoidCallback connectButtonTap;

  const UserItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.onImageTap,
    required this.connectButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
      child: Column(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: onImageTap,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                  child: CircleAvatar(
                    radius: 36,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: connectButtonTap,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightTheme,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.all(3),
                    child: Icon(
                      Icons.add,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              color: AppColors.black.withOpacity(0.60),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
