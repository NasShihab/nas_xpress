
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nas_xpress/auth/sign_up/user_data/user_form_data.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isLoading = false.obs;

  Future signUp() async {
    isLoading.value = true;
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      User? user = userCredential.user;
      if (user != null) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            ).then((value) => FirebaseFirestore.instance
            .collection('user_data')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .set({
          "name": '',
          "age": '',
          "gender": '',
          "phone": '',
          "address1": '',
          "city": '',
          "role": 'user',
        }).then((value) => Get.to(const UserDataForm())));

      }
      emailController.clear();
      passwordController.clear();
    } catch (error) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
