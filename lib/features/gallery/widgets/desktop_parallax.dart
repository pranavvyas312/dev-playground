import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'textile_aura_background.dart';

class DesktopParallax extends StatefulWidget {
  const DesktopParallax({super.key});

  @override
  State<DesktopParallax> createState() => _DesktopParallaxState();
}

class _DesktopParallaxState extends State<DesktopParallax> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;
  int _currentIndex = 0;

  final Map<int, List<Color>> _palettes = {};
  Color? _selectedColor;

  final List<Map<String, String>> items = [
    {
      'title': "L'Essence de la Haute Couture",
      'subtitle': 'RENAISSANCE BROCADE',
      'description': 'Every thread tells a story of centuries-old craftsmanship, reimagined through digital precision.',
      'image': 'assets/images/renaissance_brocade.png'
    },
    {
      'title': "L'Art de la Temporalité",
      'subtitle': 'JAPANESE INDIGO SHIBORI',
      'description': 'A dialogue between the indigo depths of Edo-period Japan and the fluid silhouettes of tomorrow.',
      'image': 'assets/images/japanese_indigo_shibori.png'
    },
    {
      'title': 'Minimalisme Radical',
      'subtitle': 'MODERNIST MINIMALISM',
      'description': 'Stripping away the superfluous to reveal the architectural soul of the garment.',
      'image': 'assets/images/modernist_minimalism.png'
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    _generatePalettes();
  }

  void _handleScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
      double itemWidth = MediaQuery.of(context).size.width * 0.6;
      int newIndex = (_scrollOffset / itemWidth).round().clamp(0, items.length - 1);
      if (newIndex != _currentIndex) {
        _currentIndex = newIndex;
        _selectedColor = null;
      }
    });
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
          palette.lightVibrantColor?.color ?? Colors.white70,
          palette.darkMutedColor?.color ?? Colors.black87,
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Color> currentAura = _palettes[_currentIndex] ?? [Colors.white, Colors.grey];
    if (_selectedColor != null) {
      currentAura = [_selectedColor!, currentAura[1]];
    }

    return Row(
      children: [
        // Left Side: Horizontal Parallax Gallery (60% width)
        Expanded(
          flex: 6,
          child: Container(
            color: const Color(0xFF0A0A0A),
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _buildParallaxItem(index);
              },
            ),
          ),
        ),

        // Right Side: Scrollable Editorial (40% width)
        Expanded(
          flex: 4,
          child: TextileAuraBackground(
            colors: currentAura,
            child: Container(
              color: Colors.transparent, // Background handled by Aura
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAnimatedText(
                      'CHRONOS MASTER GALLERY',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: const Color(0xFFD4AF37),
                            letterSpacing: 4,
                          ),
                      delay: 0,
                    ),
                    const SizedBox(height: 40),
                    ...items.asMap().entries.map((entry) {
                      if (entry.key == _currentIndex) {
                         return _buildEditorialSection(entry.value, entry.key);
                      }
                      return const SizedBox.shrink();
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildParallaxItem(int index) {
    double itemWidth = MediaQuery.of(context).size.width * 0.6;
    double parallaxEffect = (_scrollOffset - (index * itemWidth)) * 0.2;

    return Container(
      width: itemWidth,
      height: double.infinity,
      padding: const EdgeInsets.all(80),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Transform.translate(
              offset: Offset(parallaxEffect, 0),
              child: Image.asset(
                items[index]['image']!,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditorialSection(Map<String, String> item, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAnimatedText(
            item['subtitle']!,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: const Color(0xFFD4AF37),
                  letterSpacing: 2,
                ),
            delay: 200,
          ),
          const SizedBox(height: 16),
          _buildAnimatedText(
            item['title']!,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 48,
                  height: 1.1,
                ),
            delay: 400,
          ),
          const SizedBox(height: 32),
          _buildAnimatedText(
            item['description']!,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 18,
              height: 1.6,
              fontWeight: FontWeight.w300,
            ),
            delay: 600,
          ),
          const SizedBox(height: 40),
          _buildColorPalette(index),
          const SizedBox(height: 40),
          _buildAnimatedTextButton(delay: 800),
        ],
      ),
    );
  }

  Widget _buildColorPalette(int index) {
    final colors = _palettes[index] ?? [];
    if (colors.isEmpty) return const SizedBox(height: 40);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: Row(
              children: colors.map((color) => _buildColorSwatch(color)).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildColorSwatch(Color color) {
    bool isSelected = _selectedColor == color;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _selectedColor = color),
      onExit: (_) => setState(() => _selectedColor = null),
      child: GestureDetector(
        onTap: () => setState(() => _selectedColor = color),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 1.0, end: isSelected ? 1.2 : 1.0),
          duration: const Duration(milliseconds: 200),
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: Container(
                width: 32,
                height: 32,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.white : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: [
                    if (isSelected)
                      BoxShadow(
                        color: color.withOpacity(0.4),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAnimatedText(String text, {required TextStyle? style, required int delay}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Interval(delay / 1000, 1.0, curve: Curves.easeOut),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: Text(text, style: style),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedTextButton({required int delay}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Interval(delay / 1000, 1.0, curve: Curves.easeOut),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 10 * (1 - value)),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                foregroundColor: const Color(0xFFD4AF37),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('EXPLORE COLLECTION', style: TextStyle(letterSpacing: 2)),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 16),
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
    _scrollController.dispose();
    super.dispose();
  }
}
