import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';

final ThemeData themeLight = ThemeData(
  // fontFamily: 'smooch',
  // primarySwatch: kOrangeMaterialColor,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    titleSpacing: kHorizontalPaddingValue,
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: kDarkModeColor,
      fontWeight: FontWeight.bold,
      fontSize: 25.0,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.blue,
    elevation: 20.0,
  ),
);

final ThemeData themeDark = ThemeData(
  appBarTheme: const AppBarTheme(
      titleSpacing: kHorizontalPaddingValue,
      backgroundColor: kDarkModeColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 25.0,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: kDarkModeColor,
        statusBarIconBrightness: Brightness.dark,
      )),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: kDarkModeColor,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.white,
    elevation: 20.0,
  ),
  scaffoldBackgroundColor: kDarkModeColor,
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Colors.white),
  ),
);

final InputDecoration decorationFormField = InputDecoration(
  filled: true,
  fillColor: Colors.grey[300],
  border: InputBorder.none,
  label: const Text('email'),
  prefixIcon: const Icon(Icons.email_outlined),
);
