import 'package:flutter/material.dart';

const Color orange = Color.fromRGBO(234, 94, 64, 1);
const Color blue = Color.fromRGBO(29, 161, 242, 1);
const Color lightGrey = Color.fromRGBO(217, 217, 217, 1);
const Color white = Color.fromRGBO(255, 255, 255, 1);
const Color black = Color.fromRGBO(0, 0, 0, 1);

final ThemeData theme = ThemeData(
  backgroundColor: white,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      backgroundColor: Colors.black,
      fixedSize: const Size(double.infinity, 50),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[100],
    focusedBorder: const OutlineInputBorder(
      borderSide:
          BorderSide(color: Color.fromARGB(255, 91, 128, 240), width: 1.0),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),
    ),
  ),
);