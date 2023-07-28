import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ReadUserController extends GetxController {
  Stream readUserData() => FirebaseFirestore.instance
      .collection('user_data')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .snapshots();

  RxBool editButton = true.obs;
  RxBool saveButton = false.obs;

  editButtonVisible() {
    editButton.value = false;
    saveButton.value = true;
  }

  saveButtonVisible() {
    saveButton.value = false;
    editButton.value = true;
  }

  RxBool readonly = true.obs;

  editDataMode() {
    readonly.value = false;
  }

  RxBool isLoading = false.obs;

  updateData(
      String name, String phone, String address1, String city, String age, String gender) {
    isLoading.value = true;
    try {
      FirebaseFirestore.instance
          .collection('user_data')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .update({
        'name': name,
        'phone': phone,
        'address1': address1,
        'city': city,
        'age': int.parse(age),
        'gender' : gender,
      });
      readonly.value = true;
      saveButtonVisible();
    } finally {
      isLoading.value = false;
    }
  }
}
