import 'package:flutter/material.dart';

class CustomAnimatedMatchCard extends StatefulWidget {
  final List<Widget> cards;
  final double cardWidth;
  final double cardHeight;

  const CustomAnimatedMatchCard({
    super.key,
    required this.cards,
    this.cardWidth = 300,
    this.cardHeight = 400,
  });

  @override
  State<CustomAnimatedMatchCard> createState() =>
      _AnimatedMatchCardCarouselState();
}

class _AnimatedMatchCardCarouselState extends State<CustomAnimatedMatchCard> {
  late PageController _pageController;
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.75);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.cardHeight,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.cards.length,
        itemBuilder: (context, index) {
          final double scale = (_currentPage - index).abs() < 1
              ? 1 - (_currentPage - index).abs() * 0.1
              : 0.9;

          final double translateY = (_currentPage - index).abs() * 20;

          return Transform.translate(
            offset: Offset(0, translateY),
            child: Transform.scale(
              scale: scale,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: widget.cards[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
