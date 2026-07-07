import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../core/theme.dart';

class DesktopView extends StatelessWidget {
  const DesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Navigation Rail (3%)
          Container(
            width: MediaQuery.of(context).size.width * 0.03,
            color: ChronosTheme.backgroundBlack,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _NavIcon(icon: Icons.menu),
                const SizedBox(height: 40),
                _NavIcon(icon: Icons.history),
                const SizedBox(height: 40),
                _NavIcon(icon: Icons.collections),
                const SizedBox(height: 40),
                _NavIcon(icon: Icons.settings),
              ],
            ),
          ),
          // Main Viewport
          Expanded(
            child: Row(
              children: [
                // 60% Parallax Gallery
                Expanded(
                  flex: 6,
                  child: Container(
                    color: ChronosTheme.surfaceGrey,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(color: Colors.black), // Placeholder for image in test
                        ),
                        Center(
                          child: Text(
                            'ATELIER',
                            style: ChronosTheme.darkTheme.textTheme.displayLarge?.copyWith(
                              fontSize: 120,
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // 40% Editorial Column
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 80),
                    color: ChronosTheme.backgroundBlack,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CHRONOS',
                            style: ChronosTheme.darkTheme.textTheme.displayLarge?.copyWith(
                              letterSpacing: 8,
                              fontSize: 16,
                              color: ChronosTheme.primaryGold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'L\'Essence de la Haute Couture',
                            style: ChronosTheme.darkTheme.textTheme.displayLarge?.copyWith(
                              fontSize: 64,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 40),
                          // Horizontal color palette strip
                          Row(
                            children: [
                              _ColorChip(color: Color(0xFF1A1A1A)),
                              _ColorChip(color: Color(0xFFC5A059)),
                              _ColorChip(color: Color(0xFFF5F5F5)),
                              _ColorChip(color: Color(0xFF4A4A4A)),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Text(
                            'Exploring the intersection of digital craftsmanship and historical silhouettes. A timeless journey through the evolution of style.',
                            style: ChronosTheme.darkTheme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavIcon extends StatefulWidget {
  final IconData icon;
  const _NavIcon({required this.icon});

  @override
  _NavIconState createState() => _NavIconState();
}

class _NavIconState extends State<_NavIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: _isHovered
              ? [BoxShadow(color: ChronosTheme.primaryGold.withOpacity(0.3), blurRadius: 10, spreadRadius: 2)]
              : [],
        ),
        child: Icon(
          widget.icon,
          color: _isHovered ? ChronosTheme.primaryGold : Colors.white54,
          size: 20,
        ),
      ),
    );
  }
}

class _ColorChip extends StatelessWidget {
  final Color color;
  const _ColorChip({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 4,
      margin: const EdgeInsets.only(right: 8),
      color: color,
    );
  }
}
