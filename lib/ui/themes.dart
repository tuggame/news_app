import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF47CACC); // 40E2D8
const kPrimaryLightColor = Color(0xff94E1BC);
const kSecondaryColor = Color(0xFFF4E4FC);
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFFF9F8FD);
const kPrimaryDarkColor = Color(0xffC98788);
const purpleColor = Color(0xffB37CFF);
const pinkColor = Color(0xffF895E7);
const greenColor = Color(0xffC4D4A3);

final TextTheme _textTheme = TextTheme(
  headline1: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
  headline2: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
  headline3: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
  subtitle1: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
  subtitle2: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
  button: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
  bodyText1: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
  bodyText2: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
  caption: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
  headline4: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
  headline5: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700),
  headline6: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
);

final lightTheme = ThemeData(
  fontFamily: 'OpenSans',
  textTheme: _textTheme,
  brightness: Brightness.light,
  primarySwatch: Colors.red,
  accentColor: Colors.red,
  dividerColor: Colors.black38,
  scaffoldBackgroundColor: Colors.grey[100],
  backgroundColor: Colors.grey[100],
  colorScheme: ColorScheme(
    primary: Color(0xFF47CACC),
    primaryVariant: Color(0xff94E1BC),
    secondary: Color(0xFFF4E4FC),
    secondaryVariant: Color(0xffC4D4A3),
    surface: Color(0xffB37CFF),
    background: Colors.grey[100],
    error: Colors.red,
    onPrimary: Color(0xFF47CACC),
    onSecondary: Color(0xFFF4E4FC),
    onSurface: Color(0xffB37CFF),
    onBackground: Colors.grey[100],
    onError: Colors.red,
    brightness: Brightness.light,
  ),
  cardColor: Colors.white,
  canvasColor: kPrimaryLightColor,
  bottomAppBarColor: Colors.white,
  buttonColor: Colors.white70,
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.white70,
    textTheme: ButtonTextTheme.normal,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFF4E4FC),
  ),
);

final darkTheme = ThemeData(
  fontFamily: 'OpenSans',
  textTheme: _textTheme,
  brightness: Brightness.dark,
  primarySwatch: Colors.red,
  accentColor: Colors.red,
  dividerColor: Colors.white30,
  scaffoldBackgroundColor: Colors.grey[850],
  backgroundColor: Colors.grey[850],
  colorScheme: ColorScheme(
    primary: Color(0xFF47CACC),
    primaryVariant: Color(0xff94E1BC),
    secondary: Color(0xFFF4E4FC),
    secondaryVariant: Color(0xffC4D4A3),
    surface: Color(0xffB37CFF),
    background: Colors.grey[850],
    error: Colors.red,
    onPrimary: Color(0xFF47CACC),
    onSecondary: Color(0xFFF4E4FC),
    onSurface: Color(0xffB37CFF),
    onBackground: Colors.grey[850],
    onError: Colors.red,
    brightness: Brightness.dark,
  ),
  cardColor: Colors.grey[800],
  canvasColor: kPrimaryLightColor,
  bottomAppBarColor: Colors.grey[700],
  buttonColor: Colors.white70,
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.white30,
    textTheme: ButtonTextTheme.normal,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFF4E4FC),
  ),
);
