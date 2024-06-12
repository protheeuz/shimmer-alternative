import 'package:flutter/material.dart';
import 'package:shimmer_alternative/shimmer_alternative.dart';

/// Titik masuk dari aplikasi.
void main() => runApp(const MyApp());

/// Widget aplikasi utama.
class MyApp extends StatelessWidget {
  /// Membuat instance baru dari [MyApp].
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
            child: Builder(
              builder: (BuildContext context) {
                final GlobalKey<ShimmerAlternativeState> shimmerKey =
                    GlobalKey<ShimmerAlternativeState>();
                return Column(
                  children: <Widget>[
                    ShimmerAlternative(
                      key: shimmerKey,
                      duration: const Duration(seconds: 2),
                      direction: ShimmerDirection.ttb,
                      isDarkMode: true,
                      child: Container(
                        width: double.infinity,
                        height: 150.0,
                        color: Colors.grey[300],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        shimmerKey.currentState?.pauseAnimation();
                      },
                      child: const Text('Pause Animation'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        shimmerKey.currentState?.resumeAnimation();
                      },
                      child: const Text('Resume Animation'),
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
                        colors: <Color>[Colors.red, Colors.blue, Colors.green],
                        stops: <double>[0.4, 0.5, 0.6],
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
                      customShapeBuilder:
                          (Canvas canvas, Size size, Paint paint) {
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
