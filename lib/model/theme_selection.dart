import 'package:flutter/material.dart';

enum ThemeSelection {
  Sky,
  Cherry,
  Melon,
  Lime,
  Sakura,
}

extension ThemeSelectionExtension on ThemeSelection {
  //get the color
  Color get color {
    switch (this) {
      case ThemeSelection.Sky:
        return Color.fromRGBO(130, 219, 245, 1);
      case ThemeSelection.Cherry:
        return Color.fromRGBO(211, 45, 50, 1);
      case ThemeSelection.Melon:
        return Color.fromRGBO(236, 225, 135, 1);
      case ThemeSelection.Lime:
        return Color.fromRGBO(196, 234, 1, 1);
      case ThemeSelection.Sakura:
        return Color.fromRGBO(230, 131, 136, 1);
    }
  }

  //get the associated icon
  Icon get icon {
    switch (this) {
      case ThemeSelection.Sky:
        return Icon(Icons.circle, color: Color.fromRGBO(130, 219, 245, 1));
      case ThemeSelection.Cherry:
        return Icon(Icons.circle, color: Color.fromRGBO(211, 45, 50, 1));
      case ThemeSelection.Melon:
        return Icon(Icons.circle, color: Color.fromRGBO(236, 225, 135, 1));
      case ThemeSelection.Lime:
        return Icon(Icons.circle, color: Color.fromRGBO(196, 234, 1, 1));
      case ThemeSelection.Sakura:
        return Icon(Icons.circle, color: Color.fromRGBO(230, 131, 136, 1));
    }
  }
}
