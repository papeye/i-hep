import 'package:flutter/material.dart';

extension SpacedWidgets on Iterable<Widget> {
  /// Interleaves a widget between a list of widgets
  List<Widget> spacedWith(Widget spacer) => expand((item) sync* {
        yield spacer;
        yield item;
      }).skip(1).toList();

  /// Creates gaps between given widgets
  /// Useful for Column/Row which does not take a fixed size gap as parameter
  ///
  /// ```dart
  /// [Widget1(), Widget2(), Widget3()].spaced(6) == [Widget1(), SizedBox(width: 6, height: 6), Widget2(), SizedBox(width: 6, height: 6), Widget3()]
  /// ```
  List<Widget> spaced(double gap) =>
      spacedWith(SizedBox(width: gap, height: gap));
}
