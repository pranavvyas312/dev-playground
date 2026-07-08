import 'package:flutter/material.dart';

class TextileAuraBackground extends StatelessWidget {
  final List<Color> colors;
  final Widget child;

  const TextileAuraBackground({
    super.key,
    required this.colors,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.5,
          colors: colors.length >= 2
              ? [
                  colors[0].withOpacity(0.15),
                  colors[1].withOpacity(0.05),
                  Colors.black,
                ]
              : [
                  (colors.isNotEmpty ? colors[0] : Colors.white).withOpacity(0.1),
                  Colors.black,
                ],
          stops: const [0.0, 0.6, 1.0],
        ),
      ),
      child: child,
    );
  }
}
