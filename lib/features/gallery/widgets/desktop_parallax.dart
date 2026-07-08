import 'package:flutter/material.dart';

class DesktopParallax extends StatefulWidget {
  const DesktopParallax({super.key});

  @override
  State<DesktopParallax> createState() => _DesktopParallaxState();
}

class _DesktopParallaxState extends State<DesktopParallax> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;

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
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
          child: Container(
            color: Colors.black,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CHRONOS MASTER GALLERY',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: const Color(0xFFD4AF37),
                          letterSpacing: 4,
                        ),
                  ),
                  const SizedBox(height: 40),
                  ...items.map((item) => _buildEditorialSection(item)).toList(),
                ],
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

  Widget _buildEditorialSection(Map<String, String> item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item['subtitle']!,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: const Color(0xFFD4AF37),
                  letterSpacing: 2,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            item['title']!,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 48,
                  height: 1.1,
                ),
          ),
          const SizedBox(height: 32),
          Text(
            item['description']!,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 18,
              height: 1.6,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 40),
          TextButton(
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
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
