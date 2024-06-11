import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer_alternative/shimmer_alternative.dart';

void main() {
  testWidgets('ShimmerAlternative renders correctly', (WidgetTester tester) async {
    const testKey = Key('shimmer');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ShimmerAlternative(
            key: testKey,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );

    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('ShimmerAlternative applies shimmer effect', (WidgetTester tester) async {
    const testKey = Key('shimmer_effect');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ShimmerAlternative(
            key: testKey,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );

    final shaderMaskFinder = find.descendant(
      of: find.byKey(testKey),
      matching: find.byType(ShaderMask),
    );

    expect(shaderMaskFinder, findsOneWidget);
  });

  testWidgets('ShimmerAlternative works with Text widget', (WidgetTester tester) async {
    const testKey = Key('shimmer_text');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ShimmerAlternative(
            key: testKey,
            child: Text(
              'Loading...',
              style: TextStyle(fontSize: 24.0, color: Colors.grey),
            ),
          ),
        ),
      ),
    );

    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('ShimmerAlternative applies configurable speed', (WidgetTester tester) async {
    const testKey = Key('shimmer_speed');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ShimmerAlternative(
            key: testKey,
            duration: Duration(seconds: 2),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );

    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('ShimmerAlternative applies custom direction', (WidgetTester tester) async {
    const testKey = Key('shimmer_direction');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ShimmerAlternative(
            key: testKey,
            direction: ShimmerDirection.ttb,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );

    expect(find.byKey(testKey), findsOneWidget);
  });
}
