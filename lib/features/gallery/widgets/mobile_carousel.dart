import 'package:flutter/material.dart';
import 'dart:math' as math;

class MobileCarousel extends StatefulWidget {
  const MobileCarousel({super.key});

  @override
  State<MobileCarousel> createState() => _MobileCarouselState();
}

class _MobileCarouselState extends State<MobileCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.7);
  double _currentPage = 0;

  final List<Map<String, String>> items = [
    {'title': 'RENAISSANCE BROCADE', 'image': 'assets/images/renaissance_brocade.png'},
    {'title': 'JAPANESE INDIGO SHIBORI', 'image': 'assets/images/japanese_indigo_shibori.png'},
    {'title': 'MODERNIST MINIMALISM', 'image': 'assets/images/modernist_minimalism.png'},
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemCount: items.length,
      itemBuilder: (context, index) {
        double relativePosition = index - _currentPage;
        double scale = math.max(0.8, 1 - relativePosition.abs() * 0.2);
        double rotation = relativePosition * 0.2;

        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.002)
            ..scale(scale)
            ..rotateY(rotation),
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
              image: DecorationImage(
                image: AssetImage(items[index]['image']!),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      items[index]['title']!,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
