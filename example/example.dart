import 'package:flutter/material.dart';
import 'package:shimmer_alternative/shimmer_alternative.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Shimmer Alternative Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ShimmerAlternative(
                duration: const Duration(seconds: 2),
                direction: ShimmerDirection.ttb,
                shape: ShimmerShape.rectangle,
                isDarkMode: true,
                onAnimationStart: () {
                },
                onAnimationStop: () {
                },
                child: Container(
                  width: double.infinity,
                  height: 150.0,
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(height: 20),
              ShimmerAlternative(
                duration: const Duration(seconds: 3),
                direction: ShimmerDirection.btt,
                shape: ShimmerShape.circle,
                onAnimationStart: () {
                },
                onAnimationStop: () {
                },
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(height: 20),
              ShimmerAlternative(
                duration: const Duration(seconds: 1),
                direction: ShimmerDirection.rtl,
                shape: ShimmerShape.custom,
                customShapeBuilder: (canvas, size, paint) {
                  Path path = Path();
                  path.moveTo(size.width * 0.5, 0);
                  path.lineTo(size.width, size.height);
                  path.lineTo(0, size.height);
                  path.close();
                  canvas.drawPath(path, paint);
                },
                onAnimationStart: () {
                },
                onAnimationStop: () {
                },
                child: TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Loading...',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ShimmerAlternative(
                customGradient: const LinearGradient(
                  colors: [Colors.red, Colors.blue, Colors.green],
                  stops: [0.4, 0.5, 0.6],
                ),
                onAnimationStart: () {
                },
                onAnimationStop: () {
                },
                child: Container(
                  width: double.infinity,
                  height: 150.0,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}