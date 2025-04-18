import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final String imageUrl;
  final String name;

  const UserItem({required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(imageUrl),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(3),
                  child: Icon(
                    Icons.add,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}