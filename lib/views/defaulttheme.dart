import 'package:flutter/material.dart';

final ColorScheme defaultColorScheme = ColorScheme.fromSwatch(
  primarySwatch: Colors.orange,
);
final ColorScheme defaultColorSchemeDark = ColorScheme.fromSwatch(
  primarySwatch: Colors.orange,
  brightness: Brightness.dark,
);

final ThemeData defaultTheme = ThemeData(
  colorScheme: defaultColorScheme,
  brightness: Brightness.light,
  // primaryColor: Colors.orange[800],
  // focusColor: Colors.lightBlue[800],
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    titleTextStyle: TextStyle(
      color: Colors.black,
    ),
  ),
  // bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //   selectedItemColor: Colors.lightBlue[800],
  // ),
);

final ThemeData defaultThemeDark = ThemeData(
  brightness: Brightness.dark,
  colorScheme: defaultColorSchemeDark,
);
