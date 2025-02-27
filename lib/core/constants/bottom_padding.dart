import 'package:flutter/widgets.dart';

extension BottomPadding on BuildContext {
  double get bottomPadding {
    final double bottomPadding = MediaQuery.of(this).padding.bottom;
    return bottomPadding + 20;
  }
}
