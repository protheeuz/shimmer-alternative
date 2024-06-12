import 'package:flutter/material.dart';
import 'package:shimmer_alternative/shimmer_alternative.dart';

/// Entry point of the application.
void main() => runApp(const MyApp());

/// The main application widget.
class MyApp extends StatelessWidget {
  /// Creates a new instance of [MyApp].
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Shimmer Alternative Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ShimmerAlternative(
                  duration: const Duration(seconds: 2),
                  direction: ShimmerDirection.ttb,
                  isDarkMode: true,
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
                  child: Text(
                    'Loading text...',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ShimmerAlternative(
                  duration: const Duration(seconds: 1),
                  direction: ShimmerDirection.rtl,
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
                  child: Container(
                    width: double.infinity,
                    height: 150.0,
                    color: Colors.grey[300],
                  ),
                ),
                const SizedBox(height: 20),
                ShimmerAlternative(
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
                    width: double.infinity,
                    height: 150.0,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
