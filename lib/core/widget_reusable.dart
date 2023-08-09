import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void getToNavigation({required Widget pageName}) {
  Get.to(
    pageName,
    transition: Transition.circularReveal,
    duration: const Duration(seconds: 1),
  );
}

void getOffNavigation({required Widget pageName}) {
  Get.off(
    pageName,
    transition: Transition.circularReveal,
    duration: const Duration(seconds: 2),
  );
}

SnackbarController customSnackBar({
  required String msg,
  SnackPosition snackPosition = SnackPosition.TOP,
}) =>
    Get.snackbar(
      '',
      'done!',
      backgroundColor: Colors.black,
      snackPosition: snackPosition,
      colorText: const Color(0xffffffff),
      titleText: Text(
        msg,
        style: GoogleFonts.secularOne(color: const Color(0xffffffff)),
      ),
    );

flutterToast({required String msg}) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.sp);
}