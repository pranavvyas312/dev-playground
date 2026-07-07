import 'package:flutter_test/flutter_test.dart';
import 'package:chronos_atelier/main.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Chronos App smoke test', (WidgetTester tester) async {
    // Set a large surface size to avoid overflow in test environment
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;

    // Build our app and trigger a frame.
    // We wrap it in runAsync to allow the network image failure to be handled asynchronously
    await tester.runAsync(() async {
      await tester.pumpWidget(const ChronosApp());
    });

    // Verify that the app title or a key text is present.
    expect(find.text('CHRONOS'), findsWidgets);
  });
}
