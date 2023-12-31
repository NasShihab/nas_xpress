import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nas_xpress/core/my_colors.dart';

ThemeData myThemeData = ThemeData(
  useMaterial3: true,
  primaryColor: Colors.white,
  textTheme: TextTheme(
    //display
    displayLarge: TextStyle(
        fontSize: 50.sp, fontWeight: FontWeight.bold, color: Colors.black),
    displayMedium: TextStyle(
        fontSize: 40.sp, fontWeight: FontWeight.bold, color: Colors.black),
    displaySmall: TextStyle(
        fontSize: 30.sp, fontWeight: FontWeight.bold, color: Colors.black),
    //body
    bodyLarge: TextStyle(fontSize: 18.sp),
    bodyMedium: TextStyle(fontSize: 16.sp, color: Colors.grey[900]),
    bodySmall: TextStyle(fontSize: 14.sp),
    //title
    titleLarge: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
    titleSmall: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
  ),
  listTileTheme: ListTileThemeData(
    titleTextStyle: GoogleFonts.secularOne(
      color: Colors.deepPurple,
      fontSize: 16.sp,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(myOrange),
      foregroundColor: MaterialStateProperty.all(const Color(0xffffffff)),
      textStyle: MaterialStateProperty.all(
        TextStyle(fontSize: 18.sp),
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: myOrange,
    foregroundColor: Colors.white,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  iconTheme: IconThemeData(
    color: myOrange,
    size: 22.sp,
  ),
);
