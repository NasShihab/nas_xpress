import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../screen/dashboard/dashboard_page.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isLoading = false.obs;

  Future signIn() async {
    isLoading.value = true;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) => Get.to(const DashBoard()));
    } catch (error) {
      // Handle any sign-in errors
      print('Sign-in Error: $error');
    } finally {
      isLoading.value = false;
    }
  }

  cleanTextField() {
    emailController.clear();
    passwordController.clear();
  }
}
