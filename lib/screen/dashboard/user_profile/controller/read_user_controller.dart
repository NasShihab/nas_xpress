import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nas_xpress/model/user_info_model.dart';

class ReadUserController extends GetxController {
  Stream<UserInfoModel?> readUserData2() => FirebaseFirestore.instance
          .collection('user_data')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .snapshots()
          .map((snapshot) {
        if (snapshot.exists) {
          return UserInfoModel.fromJson(snapshot.data()!);
        } else {
          return null;
        }
      });

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

  updateData({
    required String name,
    required String phone,
    required String address1,
    required String city,
    required String age,
    required String gender,
  }) {
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
        'age': age,
        'gender': gender,
      });
      readonly.value = true;
      saveButtonVisible();
    } finally {
      isLoading.value = false;
    }
  }
}
