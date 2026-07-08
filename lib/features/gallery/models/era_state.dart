import 'package:flutter/material.dart';

enum EraType { renaissance, shibori, modernist }

class EraState {
  final EraType type;
  final String title;
  final String subtitle;
  final String description;
  final String assetPath;
  final String fontFamily;
  final TextAlign alignment;
  final String century;

  const EraState({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.assetPath,
    required this.fontFamily,
    required this.alignment,
    required this.century,
  });

  static List<EraState> get eras => [
    const EraState(
      type: EraType.renaissance,
      title: "L'Essence de la Haute Couture",
      subtitle: 'RENAISSANCE BROCADE',
      description: 'Every thread tells a story of centuries-old craftsmanship, reimagined through digital precision.',
      assetPath: 'assets/images/renaissance_brocade.png',
      fontFamily: 'RenaissanceSerif', // Placeholder for theme handling
      alignment: TextAlign.left,
      century: 'XV - XVI',
    ),
    const EraState(
      type: EraType.shibori,
      title: "L'Art de la Temporalité",
      subtitle: 'JAPANESE INDIGO SHIBORI',
      description: 'A dialogue between the indigo depths of Edo-period Japan and the fluid silhouettes of tomorrow.',
      assetPath: 'assets/images/japanese_indigo_shibori.png',
      fontFamily: 'NotoSansJP',
      alignment: TextAlign.right,
      century: 'XVII - XIX',
    ),
    const EraState(
      type: EraType.modernist,
      title: 'Minimalisme Radical',
      subtitle: 'MODERNIST MINIMALISM',
      description: 'Stripping away the superfluous to reveal the architectural soul of the garment.',
      assetPath: 'assets/images/modernist_minimalism.png',
      fontFamily: 'ModernistSans',
      alignment: TextAlign.center,
      century: 'XX - XXI',
    ),
  ];
}
