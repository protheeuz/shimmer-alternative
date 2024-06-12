library shimmer_alternative;

import 'package:flutter/material.dart';

/// A widget that applies a shimmer effect to its child.
class ShimmerAlternative extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// The base color of the shimmer effect.
  final Color baseColor;

  /// The highlight color of the shimmer effect.
  final Color highlightColor;

  /// The duration of the shimmer animation.
  final Duration duration;

  /// The direction of the shimmer animation.
  final ShimmerDirection direction;

  /// The shape of the shimmer effect.
  final ShimmerShape shape;

  /// Creates a [ShimmerAlternative] widget.
  const ShimmerAlternative({
    Key? key,
    required this.child,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.duration = const Duration(milliseconds: 1500),
    this.direction = ShimmerDirection.ltr,
    this.shape = ShimmerShape.rectangle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: child,
      duration: duration,
      direction: direction,
      shape: shape,
    );
  }
}

/// The direction of the shimmer animation.
enum ShimmerDirection { ltr, rtl, ttb, btt }

/// The shape of the shimmer effect.
enum ShimmerShape { rectangle, circle, custom }

class _Shimmer extends StatefulWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;
  final ShimmerDirection direction;
  final ShimmerShape shape;

  const _Shimmer({
    required this.child,
    required this.baseColor,
    required this.highlightColor,
    required this.duration,
    required this.direction,
    required this.shape,
  });

  static Widget fromColors({
    required Widget child,
    required Color baseColor,
    required Color highlightColor,
    Duration duration = const Duration(milliseconds: 1500),
    ShimmerDirection direction = ShimmerDirection.ltr,
    ShimmerShape shape = ShimmerShape.rectangle,
  }) {
    return _Shimmer(
      child: child,
      baseColor: baseColor,
      highlightColor: highlightColor,
      duration: duration,
      direction: direction,
      shape: shape,
    );
  }

  @override
  _ShimmerState createState() => _ShimmerState();
}

class _ShimmerState extends State<_Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            Gradient gradient;
            switch (widget.direction) {
              case ShimmerDirection.rtl:
                gradient = LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    widget.baseColor,
                    widget.highlightColor,
                    widget.baseColor,
                  ],
                  stops: [
                    _controller.value - 0.3,
                    _controller.value,
                    _controller.value + 0.3,
                  ],
                );
                break;
              case ShimmerDirection.ttb:
                gradient = LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    widget.baseColor,
                    widget.highlightColor,
                    widget.baseColor,
                  ],
                  stops: [
                    _controller.value - 0.3,
                    _controller.value,
                    _controller.value + 0.3,
                  ],
                );
                break;
              case ShimmerDirection.btt:
                gradient = LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    widget.baseColor,
                    widget.highlightColor,
                    widget.baseColor,
                  ],
                  stops: [
                    _controller.value - 0.3,
                    _controller.value,
                    _controller.value + 0.3,
                  ],
                );
                break;
              case ShimmerDirection.ltr:
              default:
                gradient = LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    widget.baseColor,
                    widget.highlightColor,
                    widget.baseColor,
                  ],
                  stops: [
                    _controller.value - 0.3,
                    _controller.value,
                    _controller.value + 0.3,
                  ],
                );
                break;
            }
            return gradient.createShader(bounds);
          },
          child: CustomPaint(
            painter: _ShimmerPainter(widget.shape),
            child: child,
          ),
        );
      },
    );
  }
}

/// Painter class for custom shimmer shapes.
class _ShimmerPainter extends CustomPainter {
  final ShimmerShape shape;

  _ShimmerPainter(this.shape);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    switch (shape) {
      case ShimmerShape.circle:
        canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
        break;
      case ShimmerShape.custom:
        // Add custom shape drawing logic here
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
