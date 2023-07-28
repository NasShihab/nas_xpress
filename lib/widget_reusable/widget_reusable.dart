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

Widget height5() => SizedBox(height: 5.h);
Widget height10() => SizedBox(height: 10.h);
Widget height15() => SizedBox(height: 15.h);
Widget height20() => SizedBox(height: 20.h);
Widget height25() => SizedBox(height: 25.h);
Widget height30() => SizedBox(height: 30.h);
Widget height40() => SizedBox(height: 40.h);
Widget height50() => SizedBox(height: 50.h);
Widget height55() => SizedBox(height: 55.h);
Widget height60() => SizedBox(height: 60.h);

Widget width5() => SizedBox(width: 5.w);
Widget width10() => SizedBox(width: 10.w);
Widget width15() => SizedBox(width: 15.w);
Widget width20() => SizedBox(width: 20.w);
Widget width30() => SizedBox(width: 30.w);
Widget width40() => SizedBox(width: 40.w);
Widget width50() => SizedBox(width: 50.w);
