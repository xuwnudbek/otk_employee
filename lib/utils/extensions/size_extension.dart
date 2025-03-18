import 'package:flutter/widgets.dart';

extension SizeExtension on Size {
  double get customWidth {
    if (width < 600) {
      return width * 0.6;
    } else if (width < 1200) {
      return width * 0.4;
    } else {
      return width * 0.3;
    }
  }

  double get rw {
    if (width < 600) {
      return width * 0.5;
    } else if (width < 1200) {
      return width * 0.3;
    } else {
      return width * 0.2;
    }
  }

  int get countElement {
    if (width < 800) {
      return 2;
    }
    if (width < 1200) {
      return 3;
    } else {
      return 4;
    }
  }

  double get ap {
    return width / height;
  }
}
