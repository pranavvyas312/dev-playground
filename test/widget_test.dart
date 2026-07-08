import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Large surface size to avoid overflows
    tester.view.physicalSize = const Size(2000, 2000);
    tester.view.devicePixelRatio = 1.0;

    await tester.runAsync(() async {
      await tester.pumpWidget(const ChronosApp());
      // Give it time to resolve PaletteGenerator and animations
      await Future.delayed(const Duration(seconds: 3));
    });
    await tester.pump();

    expect(find.text('CHRONOS'), findsWidgets);

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });
}
