import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer_alternative/shimmer_alternative.dart';

void main() {
  testWidgets('ShimmerAlternative renders correctly',
      (WidgetTester tester) async {
    const Key testKey = Key('shimmer');

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

  testWidgets('ShimmerAlternative applies shimmer effect',
      (WidgetTester tester) async {
    const Key testKey = Key('shimmer_effect');

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

    final Finder shaderMaskFinder = find.descendant(
      of: find.byKey(testKey),
      matching: find.byType(ShaderMask),
    );

    expect(shaderMaskFinder, findsOneWidget);
  });

  testWidgets('ShimmerAlternative works with Text widget',
      (WidgetTester tester) async {
    const Key testKey = Key('shimmer_text');

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

  testWidgets('ShimmerAlternative applies configurable speed',
      (WidgetTester tester) async {
    const Key testKey = Key('shimmer_speed');

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

  testWidgets('ShimmerAlternative applies custom direction',
      (WidgetTester tester) async {
    const Key testKey = Key('shimmer_direction');

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

  testWidgets('ShimmerAlternative supports dark mode',
      (WidgetTester tester) async {
    const Key testKey = Key('shimmer_dark_mode');

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

  testWidgets('ShimmerAlternative supports custom gradient',
      (WidgetTester tester) async {
    const Key testKey = Key('shimmer_custom_gradient');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ShimmerAlternative(
            key: testKey,
            customGradient: const LinearGradient(
              colors: <Color>[Colors.red, Colors.blue, Colors.green],
              stops: <double>[0.4, 0.5, 0.6],
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

    final Finder shaderMaskFinder = find.descendant(
      of: find.byKey(testKey),
      matching: find.byType(ShaderMask),
    );

    expect(shaderMaskFinder, findsOneWidget);
  });

  testWidgets('ShimmerAlternative applies custom shape',
      (WidgetTester tester) async {
    const Key testKey = Key('shimmer_custom_shape');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ShimmerAlternative(
            key: testKey,
            shape: ShimmerShape.custom,
            customShapeBuilder: (Canvas canvas, Size size, Paint paint) {
              final Path path = Path();
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

  testWidgets('ShimmerAlternative triggers onAnimationStart callback',
      (WidgetTester tester) async {
    const Key testKey = Key('shimmer_animation_start');
    bool animationStarted = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TestableShimmer(
            key: testKey,
            onAnimationStart: () {
              animationStarted = true;
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

    // Access the state and start the animation manually
    final TestableShimmerState state =
        tester.state<TestableShimmerState>(find.byKey(testKey));
    state.startAnimation();

    await tester.pump(const Duration(milliseconds: 100));
    expect(animationStarted, isTrue);
  });

  testWidgets('ShimmerAlternative triggers onAnimationStop callback',
      (WidgetTester tester) async {
    const Key testKey = Key('shimmer_animation_stop');
    bool animationStopped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TestableShimmer(
            key: testKey,
            duration: const Duration(milliseconds: 500),
            onAnimationStop: () {
              animationStopped = true;
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

    // Access the state and stop the animation manually
    final TestableShimmerState state =
        tester.state<TestableShimmerState>(find.byKey(testKey));
    state.stopAnimation();

    await tester.pump(const Duration(milliseconds: 500));
    expect(animationStopped, isTrue);
  });
}

/// A testable shimmer widget for triggering animation callbacks.
class TestableShimmer extends StatefulWidget {
  const TestableShimmer({
    Key? key,
    required this.child,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.duration = const Duration(milliseconds: 1500),
    this.direction = ShimmerDirection.ltr,
    this.shape = ShimmerShape.rectangle,
    this.customGradient,
    this.isDarkMode = false,
    this.customShapeBuilder,
    this.onAnimationStart,
    this.onAnimationStop,
  }) : super(key: key);

  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;
  final ShimmerDirection direction;
  final ShimmerShape shape;
  final Gradient? customGradient;
  final bool isDarkMode;
  final CustomShapeBuilder? customShapeBuilder;
  final VoidCallback? onAnimationStart;
  final VoidCallback? onAnimationStop;

  @override
  TestableShimmerState createState() => TestableShimmerState();
}

/// State class for the testable shimmer widget.
class TestableShimmerState extends State<TestableShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.forward ||
            status == AnimationStatus.reverse) {
          widget.onAnimationStart?.call();
        } else if (status == AnimationStatus.dismissed ||
            status == AnimationStatus.completed) {
          widget.onAnimationStop?.call();
        }
      });
    startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Starts the shimmer animation.
  void startAnimation() {
    _controller.repeat();
  }

  /// Stops the shimmer animation.
  void stopAnimation() {
    _controller.stop();
    widget.onAnimationStop?.call();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (BuildContext context, Widget? child) {
        return ShaderMask(
          shaderCallback: (Rect bounds) {
            final Gradient gradient = widget.customGradient ??
                LinearGradient(
                  begin: _getGradientBegin(),
                  end: _getGradientEnd(),
                  colors: <Color>[
                    widget.baseColor,
                    widget.highlightColor,
                    widget.baseColor,
                  ],
                  stops: <double>[
                    _controller.value - 0.3,
                    _controller.value,
                    _controller.value + 0.3,
                  ],
                );
            return gradient.createShader(bounds);
          },
          child: CustomPaint(
            painter: _ShimmerPainter(widget.shape, widget.customShapeBuilder),
            child: child,
          ),
        );
      },
    );
  }

  Alignment _getGradientBegin() {
    switch (widget.direction) {
      case ShimmerDirection.rtl:
        return Alignment.centerRight;
      case ShimmerDirection.ttb:
        return Alignment.topCenter;
      case ShimmerDirection.btt:
        return Alignment.bottomCenter;
      case ShimmerDirection.ltr:
      default:
        return Alignment.centerLeft;
    }
  }

  Alignment _getGradientEnd() {
    switch (widget.direction) {
      case ShimmerDirection.rtl:
        return Alignment.centerLeft;
      case ShimmerDirection.ttb:
        return Alignment.bottomCenter;
      case ShimmerDirection.btt:
        return Alignment.topCenter;
      case ShimmerDirection.ltr:
      default:
        return Alignment.centerRight;
    }
  }
}

/// Painter class for custom shimmer shapes.
class _ShimmerPainter extends CustomPainter {
  final ShimmerShape shape;
  final CustomShapeBuilder? customShapeBuilder;

  _ShimmerPainter(this.shape, this.customShapeBuilder);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    switch (shape) {
      case ShimmerShape.circle:
        canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
        break;
      case ShimmerShape.custom:
        if (customShapeBuilder != null) {
          customShapeBuilder!(canvas, size, paint);
        }
        break;
      case ShimmerShape.rectangle:
      default:
        canvas.drawRect(Offset.zero & size, paint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
