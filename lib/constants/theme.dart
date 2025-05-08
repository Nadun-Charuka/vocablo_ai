// theme.dart
import 'package:flutter/material.dart';
import 'colors.dart';

/// =========================
/// 🌓 Theme Data Configuration
/// =========================

/// Light Theme Configuration
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,

  /// Define the primary and secondary colors
  primaryColor: kLightPrimaryColor,
  colorScheme: ColorScheme.light(
    primary: kLightPrimaryColor,
    secondary: kLightSecondaryColor,
    surface: kLightBackgroundColor,
    error: kLightErrorColor,
    onPrimary: kLightOnBackgroundColor,
    onSecondary: kLightOnBackgroundColor,
    onSurface: kLightOnBackgroundColor,
    onError: Colors.white,
  ),

  /// Scaffold background color
  scaffoldBackgroundColor: kLightBackgroundColor,

  /// AppBar Theme
  appBarTheme: AppBarTheme(
    backgroundColor: kLightAppBarBackgroundColor,
    iconTheme: IconThemeData(color: kLightOnBackgroundColor),
    titleTextStyle: TextStyle(
      color: kLightOnBackgroundColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),

  /// Floating Action Button Theme
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kLightAppBarBackgroundColor,
    foregroundColor: kLightFABColor,
  ),

  /// Button Theme
  buttonTheme: ButtonThemeData(
    buttonColor: kLightPrimaryButtonColor,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),

  /// Text Theme
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: kLightOnBackgroundColor),
    bodyMedium: TextStyle(color: kLightOnBackgroundColor),
    titleLarge: TextStyle(
      color: kLightOnBackgroundColor,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(color: kLightGrey),
  ),

  /// Icon Theme
  iconTheme: IconThemeData(
    color: kLightOnBackgroundColor,
  ),

  /// Link Style
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: kLightLinkColor,
    ),
  ),

  /// Card Theme
  cardTheme: CardTheme(
    color: kLightCardBackgroundColor,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  bottomAppBarTheme: BottomAppBarTheme(color: kLightPrimaryColor),
);

/////////////////////////////////////////////////////////////////////////////////////////////
/// Dark Theme Configuration
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,

  /// Define the primary and secondary colors
  primaryColor: kDarkPrimaryColor,
  colorScheme: ColorScheme.dark(
    primary: kDarkPrimaryColor,
    secondary: kDarkSecondaryColor,
    surface: kDarkBackgroundColor,
    error: kDarkErrorColor,
    onPrimary: Colors.black,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onError: Colors.black,
  ),

  /// Scaffold background color
  scaffoldBackgroundColor: kDarkBackgroundColor,

  /// AppBar Theme
  appBarTheme: AppBarTheme(
    backgroundColor: kDarkAppBarBackgroundColor,
    iconTheme: IconThemeData(color: kDarkOnBackgroundColor),
    titleTextStyle: TextStyle(
      color: kDarkOnBackgroundColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),

  /// Floating Action Button Theme
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kDarkAppBarBackgroundColor,
    foregroundColor: kDarkFABColor,
  ),

  /// Button Theme
  buttonTheme: ButtonThemeData(
    buttonColor: kDarkPrimaryButtonColor,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),

  /// Text Theme
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: kDarkOnBackgroundColor),
    bodyMedium: TextStyle(color: kDarkOnBackgroundColor),
    titleLarge: TextStyle(
      color: kDarkOnBackgroundColor,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(color: kDarkGrey),
  ),

  /// Icon Theme
  iconTheme: IconThemeData(
    color: kDarkOnBackgroundColor,
  ),

  /// Link Style
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: kDarkLinkColor,
    ),
  ),

  /// Card Theme
  cardTheme: CardTheme(
    color: kDarkCardBackgroundColor,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  bottomAppBarTheme: BottomAppBarTheme(color: kDarkAppBarBackgroundColor),
);
