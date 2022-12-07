import 'package:alfabetizando/utils/constants.dart';
import 'package:flutter/material.dart';

ThemeData appThemeData = ThemeData(
  primaryColor: Constants.green,
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelStyle: const TextStyle(color: Constants.green),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10),
    ),
    contentPadding: const EdgeInsets.all(20),
    hintStyle: TextStyle(
      fontSize: 16.0,
      color: Constants.ligthGrey,
    ),
    filled: true,
    fillColor: Colors.grey[200],
  ),
  fontFamily: 'Copse',
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 32.0,
      color: Constants.grey,
    ),
    headline4: TextStyle(
      fontSize: 24.0,
      color: Constants.grey,
    ),
    headline5: TextStyle(
      fontSize: 20.0,
      color: Constants.grey,
    ),
    headline6: TextStyle(
      fontSize: 16.0,
      color: Constants.ligthGrey,
    ),
    bodyText2: TextStyle(
      fontSize: 30.0,
      fontFamily: 'Inter',
      color: Colors.white,
    ),
    button: TextStyle(fontSize: 20),
  ),
  snackBarTheme: SnackBarThemeData(contentTextStyle: TextStyle(fontSize: 20)),
);
