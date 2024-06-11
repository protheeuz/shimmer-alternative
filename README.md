# Shimmer Alternative

Shimmer Alternative is a Flutter package designed to provide beautiful shimmer effects for loading states in your apps. This package is perfect for adding visually appealing animations to your cards, containers, text, and text fields, making the loading experience more engaging for users.

## Features

- Customizable shimmer colors
- Adjustable shimmer speed
- Support for multiple directions (left-to-right, right-to-left, top-to-bottom, bottom-to-top)
- Easy integration with existing widgets
- Lightweight and highly customizable

## Getting Started

To use this package, add `shimmer_alternative` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  shimmer_alternative: ^0.0.1


## Getting Started

To use this package, add `shimmer_alternative` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  shimmer_alternative: ^0.0.1
```
### Usage
Here is a simple example of how to use Shimmer Alternative:

```dart
import 'package:flutter/material.dart';
import 'package:shimmer_alternative/shimmer_alternative.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Shimmer Alternative Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ShimmerAlternative(
                duration: Duration(seconds: 2),
                direction: ShimmerDirection.ttb,
                child: Container(
                  width: double.infinity,
                  height: 150.0,
                  color: Colors.grey[300],
                ),
              ),
              SizedBox(height: 20),
              ShimmerAlternative(
                duration: Duration(seconds: 3),
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
              SizedBox(height: 20),
              ShimmerAlternative(
                duration: Duration(seconds: 1),
                direction: ShimmerDirection.rtl,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Loading...',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```
### Customization
Shimmer Colors
You can customize the base color and highlight color of the shimmer effect:

```dart
ShimmerAlternative(
  baseColor: Colors.grey[300]!,
  highlightColor: Colors.grey[100]!,
  child: Container(
    width: double.infinity,
    height: 150.0,
    color: Colors.grey[300],
  ),
);
```

### Shimmer Speed
You can adjust the speed of the shimmer effect by changing the duration parameter:

```dart
ShimmerAlternative(
  duration: Duration(seconds: 2),
  child: Container(
    width: double.infinity,
    height: 150.0,
    color: Colors.grey[300],
  ),
);
```

### Shimmer Direction
You can change the direction of the shimmer effect using the direction parameter:

```dart
ShimmerAlternative(
  direction: ShimmerDirection.ttb,
  child: Container(
    width: double.infinity,
    height: 150.0,
    color: Colors.grey[300],
  ),
);
```

### Contributing
Contributions are welcome! If you have any ideas, suggestions, or find a bug, please create an issue or submit a pull request.

License
This project is licensed under the GPL-3.0 license - see the [LICENSE](https://github.com/protheeuz/shimmer-alternative?tab=GPL-3.0-1-ov-file#GPL-3.0-1-ov-file) file for details.