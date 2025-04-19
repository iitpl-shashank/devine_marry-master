import 'package:flutter/material.dart';

class MatchCard extends StatelessWidget {
  final String name;
  final int age;
  final String height;

  const MatchCard({
    super.key,
    required this.name,
    required this.age,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(
              'assets/sample_image.jpg'), // use NetworkImage if needed
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(16),
      child: Text(
        "$name, $age\n$height",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          shadows: [Shadow(blurRadius: 4, color: Colors.black)],
        ),
      ),
    );
  }
}
