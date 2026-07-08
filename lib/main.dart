import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'features/gallery/views/gallery_view.dart';

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
      theme: ChronosTheme.light,
      home: const GalleryView(),
    );
  }
}
