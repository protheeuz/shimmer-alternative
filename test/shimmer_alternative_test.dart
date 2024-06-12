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
      const MaterialApp(
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
            duration: const Duration(seconds: 2),
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

  testWidgets('ShimmerAlternative supports dark mode', (WidgetTester tester) async {
    const testKey = Key('shimmer_dark_mode');

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          body: ShimmerAlternative(
            key: testKey,
            isDarkMode: true,
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

  testWidgets('ShimmerAlternative supports custom gradient', (WidgetTester tester) async {
    const testKey = Key('shimmer_custom_gradient');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ShimmerAlternative(
            key: testKey,
            customGradient: const LinearGradient(
              colors: [Colors.red, Colors.blue, Colors.green],
              stops: [0.4, 0.5, 0.6],
            ),
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

  testWidgets('ShimmerAlternative applies custom shape', (WidgetTester tester) async {
    const testKey = Key('shimmer_custom_shape');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ShimmerAlternative(
            key: testKey,
            shape: ShimmerShape.custom,
            customShapeBuilder: (canvas, size, paint) {
              Path path = Path();
              path.moveTo(size.width * 0.5, 0);
              path.lineTo(size.width, size.height);
              path.lineTo(0, size.height);
              path.close();
              canvas.drawPath(path, paint);
            },
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
