import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:palette_generator/palette_generator.dart';
import 'textile_aura_background.dart';

class MobileCarousel extends StatefulWidget {
  const MobileCarousel({super.key});

  @override
  State<MobileCarousel> createState() => _MobileCarouselState();
}

class _MobileCarouselState extends State<MobileCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.7);
  double _currentPage = 0;
  final Map<int, List<Color>> _palettes = {};
  Color? _selectedColor;

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
        _selectedColor = null;
      });
    });
    _generatePalettes();
  }

  Future<void> _generatePalettes() async {
    for (int i = 0; i < items.length; i++) {
      final PaletteGenerator palette = await PaletteGenerator.fromImageProvider(
        AssetImage(items[i]['image']!),
        maximumColorCount: 5,
      );
      setState(() {
        _palettes[i] = [
          palette.dominantColor?.color ?? Colors.white,
          palette.vibrantColor?.color ?? palette.mutedColor?.color ?? Colors.grey,
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = _currentPage.round().clamp(0, items.length - 1);
    List<Color> currentAura = _palettes[currentIndex] ?? [Colors.white, Colors.grey];
    if (_selectedColor != null) {
      currentAura = [_selectedColor!, currentAura[1]];
    }

    return TextileAuraBackground(
      colors: currentAura,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
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
            ),
          ),
          _buildColorPalette(currentIndex),
          const SizedBox(height: 120), // Leave space for bottom nav
        ],
      ),
    );
  }

  Widget _buildColorPalette(int index) {
    final colors = _palettes[index] ?? [];
    if (colors.isEmpty) return const SizedBox(height: 60);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: colors.map((color) => _buildColorSwatch(color)).toList(),
      ),
    );
  }

  Widget _buildColorSwatch(Color color) {
    bool isSelected = _selectedColor == color;
    return GestureDetector(
      onTap: () => setState(() => _selectedColor = color),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 1.0, end: isSelected ? 1.2 : 1.0),
        duration: const Duration(milliseconds: 200),
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: Container(
              width: 28,
              height: 28,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
