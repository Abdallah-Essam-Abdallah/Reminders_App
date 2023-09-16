import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData appTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color.fromARGB(172, 52, 66, 73),
  scaffoldBackgroundColor: const Color(0xFF1A2127),
  fontFamily: 'Sriracha',
  dividerColor: Colors.white,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Color(0xFF1A2127),
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  ),
  /*bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 20,
    type: BottomNavigationBarType.fixed,
    backgroundColor: const Color(0x441C2A3D),
    selectedItemColor: const Color.fromRGBO(108, 99, 255, 1),
    selectedIconTheme: IconThemeData(
      color: Colors.grey[700],
    ),
    unselectedIconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),*/
  dialogTheme: const DialogTheme(
    backgroundColor: Color.fromARGB(255, 77, 76, 76),
    elevation: 20,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
    titleTextStyle: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    contentTextStyle: TextStyle(
        fontSize: 15, fontWeight: FontWeight.normal, color: Colors.white),
  ),
  snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color.fromARGB(221, 0, 0, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 30,
      contentTextStyle: const TextStyle(color: Colors.black)),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color?>(
          const Color.fromRGBO(108, 99, 255, 1)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color?>(
          const Color.fromRGBO(108, 99, 255, 1)),
      shape: MaterialStateProperty.all(
        const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color?>(
          const Color.fromRGBO(108, 99, 255, 1)),
      shape: MaterialStateProperty.all(const CircleBorder()),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color.fromRGBO(108, 99, 255, 1)),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
    headlineMedium: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    titleLarge: TextStyle(
        fontWeight: FontWeight.bold, color: Color.fromARGB(255, 228, 222, 222)),
  ),
  cardTheme: CardTheme(
    elevation: 10,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //margin: const EdgeInsets.all(10),
    color: const Color.fromARGB(172, 52, 66, 73),
    shadowColor: const Color.fromARGB(172, 73, 92, 102),
  ),
  tabBarTheme: const TabBarTheme(
      labelColor: Colors.white,
      labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
);
