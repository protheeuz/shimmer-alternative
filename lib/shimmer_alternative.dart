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

  /// The custom gradient of the shimmer effect.
  final Gradient? customGradient;

  /// Whether to automatically adjust colors for dark mode.
  final bool isDarkMode;

  /// Custom shape builder callback.
  final CustomShapeBuilder? customShapeBuilder;

  /// Callback when the animation starts.
  final VoidCallback? onAnimationStart;

  /// Callback when the animation stops.
  final VoidCallback? onAnimationStop;

  /// Creates a [ShimmerAlternative] widget.
  const ShimmerAlternative({
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

  @override
  Widget build(BuildContext context) {
    final adjustedBaseColor = isDarkMode ? Colors.grey[800]! : baseColor;
    final adjustedHighlightColor =
        isDarkMode ? Colors.grey[600]! : highlightColor;

    return RepaintBoundary(
      child: _Shimmer.fromColors(
        baseColor: adjustedBaseColor,
        highlightColor: adjustedHighlightColor,
        customGradient: customGradient,
        child: child,
        duration: duration,
        direction: direction,
        shape: shape,
        customShapeBuilder: customShapeBuilder,
        onAnimationStart: onAnimationStart,
        onAnimationStop: onAnimationStop,
      ),
    );
  }
}

/// The direction of the shimmer animation.
enum ShimmerDirection { ltr, rtl, ttb, btt }

/// The shape of the shimmer effect.
enum ShimmerShape { rectangle, circle, custom }

/// Callback function for custom shape drawing.
typedef CustomShapeBuilder = void Function(
    Canvas canvas, Size size, Paint paint);

class _Shimmer extends StatefulWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;
  final ShimmerDirection direction;
  final ShimmerShape shape;
  final Gradient? customGradient;
  final CustomShapeBuilder? customShapeBuilder;
  final VoidCallback? onAnimationStart;
  final VoidCallback? onAnimationStop;

  const _Shimmer({
    required this.child,
    required this.baseColor,
    required this.highlightColor,
    required this.duration,
    required this.direction,
    required this.shape,
    this.customGradient,
    this.customShapeBuilder,
    this.onAnimationStart,
    this.onAnimationStop,
  });

  static Widget fromColors({
    required Widget child,
    required Color baseColor,
    required Color highlightColor,
    Duration duration = const Duration(milliseconds: 1500),
    ShimmerDirection direction = ShimmerDirection.ltr,
    ShimmerShape shape = ShimmerShape.rectangle,
    Gradient? customGradient,
    CustomShapeBuilder? customShapeBuilder,
    VoidCallback? onAnimationStart,
    VoidCallback? onAnimationStop,
  }) {
    return _Shimmer(
      child: child,
      baseColor: baseColor,
      highlightColor: highlightColor,
      duration: duration,
      direction: direction,
      shape: shape,
      customGradient: customGradient,
      customShapeBuilder: customShapeBuilder,
      onAnimationStart: onAnimationStart,
      onAnimationStop: onAnimationStop,
    );
  }

  @override
  _ShimmerState createState() => _ShimmerState();
}

class _ShimmerState extends State<_Shimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat()
      ..addStatusListener((status) {
        if (status == AnimationStatus.forward) {
          widget.onAnimationStart?.call();
        } else if (status == AnimationStatus.dismissed) {
          widget.onAnimationStop?.call();
        }
      });
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
            final gradient = widget.customGradient ??
                LinearGradient(
                  begin: _getGradientBegin(),
                  end: _getGradientEnd(),
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
    final paint = Paint()
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
