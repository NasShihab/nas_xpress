import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nas_xpress/model/user_info_model.dart';

import '../../../../singleton_data/user_data/user_info_singleton.dart';

class ReadUserController extends GetxController {
  Stream<UserInfoModel?> readUserData2() => FirebaseFirestore.instance
          .collection('user_data')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .snapshots()
          .map((snapshot) {
        if (snapshot.exists) {
          final userInfoModel = UserInfoModel.fromJson(snapshot.data()!);
          UserInfoSingleton().updateFromModel(userInfoModel);
          return userInfoModel;
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

  updateData(
      // String name, String phone, String address1, String city,
      // String age, String gender
      ) {
    isLoading.value = true;
    try {
      FirebaseFirestore.instance
          .collection('user_data')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .set({
        'name': UserInfoSingleton().name,
        'phone': UserInfoSingleton().phone,
        'address1': UserInfoSingleton().address1,
        'city': UserInfoSingleton().city,
        'age': UserInfoSingleton().age,
        'gender': UserInfoSingleton().gender,
      });
      readonly.value = true;
      saveButtonVisible();
    } finally {
      isLoading.value = false;
    }
  }
}
