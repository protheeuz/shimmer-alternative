# Changelog

## [0.0.7] - 2024-06-13
### Added
- Added color interpolation feature.
- Added opacity control for shimmer effect.
- Added loop count and easing curve support for shimmer animation.
- Added pause and resume animation control.
- Added detailed example usage for new features.

### Changed
- Improved performance with RepaintBoundary.
- Optimized gradient creation in shaderCallback.

### Fixed
- Fixed issues with custom gradients in certain configurations.

## [0.0.6+1] - 2024-06-12
### Fixed
- Fixed linting issues by specifying type annotations and sorting constructor declarations.

## [0.0.6] - 2024-06-12
### Added
- Added `onAnimationStart` and `onAnimationStop` callbacks to `ShimmerAlternative` for monitoring animation events.
- Example usage demonstrating the new callback features.
- Documentation updates for callback functionality.
- Included detailed unit tests for `onAnimationStart` and `onAnimationStop` callbacks.

### Changed
- Optimized animation control in `TestableShimmer` for precise testing.
- Enhanced example application to showcase various configurations and new callback features.
- Improved test coverage for various ShimmerAlternative configurations.

### Fixed
- Fixed onAnimationStop callback test to ensure accurate triggering of the callback.

## [0.0.5] - 2024-06-12
### Added
- Added support for custom gradients.
- Added support for dark mode.

### Changed
- Replaced `headline4` with `headlineMedium` to support the latest version of Flutter.
- Fixed overflow issue in main example.

### Fixed
- Fixed static analysis errors.

## [0.0.3] - 2024-06-12
### Added
- Support for dark mode with `isDarkMode` parameter to adjust colors automatically.
- Custom gradient support with `customGradient` parameter.
- Added unit tests for dark mode and custom gradient features.
- Documentation updates for new features.
- Updated example to demonstrate new features.

## [0.0.2] - 2024-06-12
### Added
- Support for custom shapes (rectangle, circle, custom) in ShimmerAlternative.
- Documentation updates for new features.

## [0.0.1] - 2024-06-12
- Initial release of Shimmer Alternative.
- Added customizable shimmer colors, speed, and direction.