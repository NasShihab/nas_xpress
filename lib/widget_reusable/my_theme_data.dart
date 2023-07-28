import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nas_xpress/widget_reusable/my_colors.dart';

ThemeData myThemeData = ThemeData(
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
        GoogleFonts.secularOne(fontSize: 20.sp),
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: myOrange,
    foregroundColor: Colors.white,
    centerTitle: true,
    titleTextStyle: GoogleFonts.secularOne(
      fontSize: 25.sp,
    ),
  ),
  iconTheme: IconThemeData(
    color: myOrange,
    size: 22.sp,
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
  ),
);
