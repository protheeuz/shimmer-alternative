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
}