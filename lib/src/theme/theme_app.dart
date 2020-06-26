import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterclonethecoffeehouse/src/theme/theme_text.dart';

import 'my_colors.dart';

enum ThemeMode { light, dark }

class ThemeApp {
  static final Color primaryColor = MyColors.yellowOrange;
  static final Color secondaryColor = MyColors.white;
  static final Color disableColor = MyColors.grey;

  static final ThemeData _theme = ThemeData(
    fontFamily: 'OpenSans',
    platform: TargetPlatform.iOS,
    primaryColor: primaryColor,
    errorColor: MyColors.red,
    disabledColor: disableColor,
    cupertinoOverrideTheme: CupertinoThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
    ),
    dividerTheme: DividerThemeData(
      color: disableColor,
      thickness: 1,
    ),
    textTheme: ThemeText.textTheme,
    canvasColor: Colors.white,
    buttonColor: primaryColor,
    scaffoldBackgroundColor: const Color.fromRGBO(245, 246, 242, 1.0),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(
        color: MyColors.white,
        size: 28,
      ),
      actionsIconTheme: IconThemeData(
        size: 28,
      ),
    ),
  );
  static final ThemeData kLightTheme = _theme.copyWith(
    brightness: Brightness.light,
  );

  static final ThemeData kDarkTheme = _theme.copyWith(
    brightness: Brightness.dark,
  );
}
