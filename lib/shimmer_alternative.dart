library shimmer_alternative;

import 'package:flutter/material.dart';

/// A widget that applies a shimmer effect to its child.
class ShimmerAlternative extends StatefulWidget {
  /// Creates a [ShimmerAlternative] widget.
  const ShimmerAlternative({
    Key? key,
    required this.child,
    this.baseColor = const Color(0xFFBDBDBD), // Default base color
    this.highlightColor = const Color(0xFFFFFFFF), // Default highlight color
    this.duration = const Duration(milliseconds: 1500),
    this.direction = ShimmerDirection.ltr,
    this.shape = ShimmerShape.rectangle,
    this.customGradient,
    this.isDarkMode = false,
    this.customShapeBuilder,
    this.onAnimationStart,
    this.onAnimationStop,
    this.colorInterpolation = 0.5,
    this.opacity = 1.0,
    this.loopCount = 0,
    this.easing = Curves.linear,
  }) : super(key: key);

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

  /// The interpolation factor for color blending.
  final double colorInterpolation;

  /// The opacity of the shimmer effect.
  final double opacity;

  /// The number of times the animation should loop.
  final int loopCount;

  /// The easing curve for the animation.
  final Curve easing;

  @override
  ShimmerAlternativeState createState() => ShimmerAlternativeState();
}

/// The state class for [ShimmerAlternative].
class ShimmerAlternativeState extends State<ShimmerAlternative>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  int _currentLoop = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )
      ..repeat()
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          if (widget.loopCount > 0 && _currentLoop >= widget.loopCount) {
            _controller.stop();
            widget.onAnimationStop?.call();
          } else {
            _currentLoop++;
            _controller.forward(from: 0.0);
          }
        }
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

  /// Pauses the shimmer animation.
  void pauseAnimation() {
    _controller.stop();
  }

  /// Resumes the shimmer animation.
  void resumeAnimation() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final Color adjustedBaseColor =
        widget.isDarkMode ? Colors.grey[700]! : widget.baseColor;
    final Color adjustedHighlightColor =
        widget.isDarkMode ? Colors.grey[500]! : widget.highlightColor;

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: _getGradientBegin(),
                end: _getGradientEnd(),
                colors: <Color>[
                  adjustedBaseColor.withOpacity(widget.opacity),
                  adjustedHighlightColor.withOpacity(widget.opacity),
                  adjustedBaseColor.withOpacity(widget.opacity),
                ],
                stops: <double>[
                  widget.colorInterpolation - 0.3,
                  widget.colorInterpolation,
                  widget.colorInterpolation + 0.3,
                ],
                transform: _SlidingGradientTransform(
                  slidePercent: _controller.value,
                  direction: widget.direction,
                ),
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: CustomPaint(
              painter: _ShimmerPainter(widget.shape, widget.customShapeBuilder),
              child: widget.child,
            ),
          );
        },
      ),
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

/// The direction of the shimmer animation.
enum ShimmerDirection { ltr, rtl, ttb, btt }

/// The shape of the shimmer effect.
enum ShimmerShape { rectangle, circle, custom }

/// Callback function for custom shape drawing.
typedef CustomShapeBuilder = void Function(
    Canvas canvas, Size size, Paint paint);

/// Painter class for custom shimmer shapes.
class _ShimmerPainter extends CustomPainter {
  _ShimmerPainter(this.shape, this.customShapeBuilder);

  final ShimmerShape shape;
  final CustomShapeBuilder? customShapeBuilder;

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

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.slidePercent,
    required this.direction,
  });

  final double slidePercent;
  final ShimmerDirection direction;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    switch (direction) {
      case ShimmerDirection.rtl:
        return Matrix4.translationValues(
            -bounds.width * slidePercent, 0.0, 0.0);
      case ShimmerDirection.ttb:
        return Matrix4.translationValues(
            0.0, bounds.height * slidePercent, 0.0);
      case ShimmerDirection.btt:
        return Matrix4.translationValues(
            0.0, -bounds.height * slidePercent, 0.0);
      case ShimmerDirection.ltr:
      default:
        return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
    }
  }
}
