import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screen/dashboard/dashboard_page.dart';
import '../../screen/onboard/splash_screen.dart';

var myRoutes = <String, WidgetBuilder>{
  '/': (context) => const SplashScreen(),
  '/home_page': (context) => const DashBoard(),
};

void navigationRightToLeftWithFade({required Widget pageName}) => Get.to(
      pageName,
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(seconds: 1),
    );
