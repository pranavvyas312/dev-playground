import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../core/theme.dart';
import 'dart:math' as math;

class MobileView extends StatelessWidget {
  const MobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChronosTheme.backgroundBlack,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.6,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  background: _CarouselWheel(),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(24),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Text(
                      'THE NEW ERA',
                      style: ChronosTheme.darkTheme.textTheme.displayLarge?.copyWith(
                        fontSize: 14,
                        letterSpacing: 4,
                        color: ChronosTheme.primaryGold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Chronos: Atelier',
                      style: ChronosTheme.darkTheme.textTheme.displayLarge?.copyWith(
                        fontSize: 42,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Immerse yourself in a curated selection of digital couture where time and space dissolve into pure aesthetic expression.',
                      style: ChronosTheme.darkTheme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 100), // Space for bottom nav
                  ]),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: _GlassBottomNav(),
          ),
        ],
      ),
    );
  }
}

class _CarouselWheel extends StatefulWidget {
  @override
  State<_CarouselWheel> createState() => _CarouselWheelState();
}

class _CarouselWheelState extends State<_CarouselWheel> {
  late PageController _pageController;
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.7);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: 5,
      itemBuilder: (context, index) {
        double relativePosition = index - _currentPage;
        String imageUrl = 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&q=80';
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailView(index: index, imageUrl: imageUrl),
            ));
          },
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(relativePosition * 0.5),
            child: Hero(
              tag: 'card_$index',
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                decoration: ChronosTheme.glassBoxDecoration(opacity: 0.2).copyWith(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DetailView extends StatelessWidget {
  final int index;
  final String imageUrl;

  const DetailView({super.key, required this.index, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChronosTheme.backgroundBlack,
      body: Stack(
        children: [
          Hero(
            tag: 'card_$index',
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(40),
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, ChronosTheme.backgroundBlack],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'COLLECTION #$index',
                    style: ChronosTheme.darkTheme.textTheme.displayLarge?.copyWith(fontSize: 32),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'A masterpiece of digital weaving and temporal aesthetics.',
                    style: ChronosTheme.darkTheme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(Icons.home_outlined, color: ChronosTheme.primaryGold),
              Icon(Icons.search, color: Colors.white54),
              Icon(Icons.bookmark_border, color: Colors.white54),
              Icon(Icons.person_outline, color: Colors.white54),
            ],
          ),
        ),
      ),
    );
  }
}
