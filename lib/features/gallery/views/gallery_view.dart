import 'package:flutter/material.dart';
import 'dart:ui';
import '../widgets/mobile_carousel.dart';
import '../widgets/desktop_parallax.dart';
import '../../../core/responsive_layout.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main Content
          Padding(
            padding: EdgeInsets.only(
              left: ResponsiveLayout.isDesktop(context) ? MediaQuery.of(context).size.width * 0.03 : 0,
            ),
            child: const ResponsiveLayout(
              mobile: MobileView(),
              tablet: MobileView(),
              desktop: DesktopParallax(),
            ),
          ),

          // Desktop Navigation Rail (3% width)
          if (ResponsiveLayout.isDesktop(context))
            Container(
              width: MediaQuery.of(context).size.width * 0.03,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                border: Border(right: BorderSide(color: Colors.white.withOpacity(0.1))),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildNavIcon(Icons.collections_outlined),
                  const SizedBox(height: 40),
                  _buildNavIcon(Icons.history_outlined),
                  const SizedBox(height: 40),
                  _buildNavIcon(Icons.settings_outlined),
                ],
              ),
            ),

          // Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildHeader(context),
          ),
        ],
      ),
      bottomNavigationBar: ResponsiveLayout.isMobile(context) ? _buildMobileBottomNav() : null,
      drawer: ResponsiveLayout.isDesktop(context) ? null : const AppDrawer(),
    );
  }

  Widget _buildNavIcon(IconData icon) {
    return Icon(icon, color: Colors.white54, size: 20);
  }

  Widget _buildHeader(BuildContext context) {
    bool isDesktop = ResponsiveLayout.isDesktop(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40 : 20,
        vertical: 30,
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!isDesktop)
                Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  );
                }),
              if (isDesktop) const SizedBox(width: 48),
              const Text(
                'CHRONOS',
                style: TextStyle(
                  letterSpacing: 12,
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_bag_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileBottomNav() {
    return Container(
      height: 80,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.home_filled, color: Color(0xFFD4AF37)),
              Icon(Icons.search, color: Colors.white70),
              Icon(Icons.bookmark_outline, color: Colors.white70),
              Icon(Icons.person_outline, color: Colors.white70),
            ],
          ),
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const NavigationDrawer(
      backgroundColor: Color(0xFF0A0A0A),
      children: [
        DrawerHeader(
          child: Center(
            child: Text(
              'CHRONOS',
              style: TextStyle(
                color: Color(0xFFD4AF37),
                fontSize: 24,
                letterSpacing: 4,
              ),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.collections_outlined, color: Colors.white),
          title: Text('Collections', style: TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: Icon(Icons.history_outlined, color: Colors.white),
          title: Text('Legacy', style: TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: Icon(Icons.settings_outlined, color: Colors.white),
          title: Text('Atelier', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

class MobileView extends StatelessWidget {
  const MobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(child: MobileCarousel()),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('THE NEW ERA', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 16),
              Text('Historical Master Gallery', style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 16),
              const Text(
                'Immerse yourself in a curated selection of artifacts that bridge the gap between antiquity and the avant-garde.',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
