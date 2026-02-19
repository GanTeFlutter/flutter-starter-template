import 'package:flutter/material.dart';

extension ResponsiveExtension on BuildContext {
  /// Baz genişlik: 375pt (iPhone 13/14 standart).
  /// Scale factor: [0.75, 1.5] arasında clamp edilir.
  double get _scale => (MediaQuery.sizeOf(this).width / 375).clamp(0.75, 1.5);

  /// Responsive boyut (width, height, padding, margin, radius, shadow).
  double r(double value) => value * _scale;

  /// Responsive font boyutu.
  double rf(double value) => value * _scale;
}
