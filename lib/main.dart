import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'presentation/widgets/responsive_layout.dart';
import 'presentation/views/mobile/mobile_view.dart';
import 'presentation/views/tablet/tablet_view.dart';
import 'presentation/views/desktop/desktop_view.dart';

void main() {
  runApp(const ChronosApp());
}

class ChronosApp extends StatelessWidget {
  const ChronosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chronos: Atelier',
      debugShowCheckedModeBanner: false,
      theme: ChronosTheme.darkTheme,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      switchInCurve: ChronosTheme.defaultCurve,
      switchOutCurve: ChronosTheme.defaultCurve,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.98, end: 1.0).animate(animation),
            child: child,
          ),
        );
      },
      child: ResponsiveLayout(
        key: ValueKey(MediaQuery.of(context).size.width > 600 ? 'wide' : 'narrow'),
        mobile: const MobileView(),
        tablet: const TabletView(),
        desktop: const DesktopView(),
      ),
    );
  }
}
