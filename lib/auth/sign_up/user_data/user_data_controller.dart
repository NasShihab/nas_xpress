import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nas_xpress/singleton_data/user_data/user_info_singleton.dart';

import '../../../dashboard/dashboard_page/dashboard_page.dart';

class UserDataController extends GetxController {
  List<String> gender = ['Male', 'Female', 'Other'];
  List<String> city = [
    'Dhaka',
    'Rajshahi',
    'Chattagram',
    'Barishal',
    'Sylhet',
    'Khulna',
    'Cumilla'
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController cityNameController = TextEditingController();

  RxBool isLoading = false.obs;

  sendDataToStore() async {
    isLoading.value = true;

    try {
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('user_data');

      UserInfoSingleton().name = nameController.text.trim();
      UserInfoSingleton().age = ageController.text.trim();
      UserInfoSingleton().gender = genderController.text.trim();
      UserInfoSingleton().phone = phoneController.text.trim();
      UserInfoSingleton().address1 = addressLine1Controller.text.trim();
      UserInfoSingleton().city = cityNameController.text.trim();

      if (UserInfoSingleton().name!.isEmpty ||
          UserInfoSingleton().age!.isEmpty ||
          UserInfoSingleton().gender!.isEmpty ||
          UserInfoSingleton().phone!.isEmpty) {
        Get.snackbar(
          'Error',
          'Please fill in all the fields',
          snackPosition: SnackPosition.TOP,
          colorText: const Color(0xFF190101),
          titleText: Text(
            'Not Complete',
            style: GoogleFonts.secularOne(),
          ),
        );
        return;
      }

      return collectionRef
          .doc(FirebaseAuth.instance.currentUser!.email)
          .update({
        "name": UserInfoSingleton().name,
        "age": UserInfoSingleton().age,
        "gender": UserInfoSingleton().gender,
        "phone": UserInfoSingleton().phone,
        "address1": UserInfoSingleton().address1,
        "city": UserInfoSingleton().city,
      }).then((value) => Get.to(const DashBoard()));
    } catch (error) {
      isLoading.value = false;
    }
  }

  void disposeText() {
    nameController.clear();
    ageController.clear();
    genderController.clear();
    phoneController.clear();
  }

  Rx<File> image = File('').obs;

  Future picImage() async {
    try {
      final imagePick =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagePick == null) {
        return;
      }
      final imageTemp = File(imagePick.path);
      image.value = imageTemp;
      // this.image.value = imageTemp;
    } on PlatformException catch (e) {
      return e;
    }
  }

  Future<String> uploadImageToFirebaseN(BuildContext context) async {
    String fileName = FirebaseAuth.instance.currentUser!.email.toString();

    try {
      Reference reference =
          FirebaseStorage.instance.ref().child('user_image/$fileName.png');
      await reference.putFile(image.value);

      String downloadURL = await reference.getDownloadURL();
      return downloadURL;
    } catch (e) {
      return '';
    }
  }

  Future<String> uploadImageToFirebase(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      // No image selected
      return '';
    }

    File imageFile = File(pickedFile.path);
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    String fileName = currentUser!.email.toString();

    try {
      // Upload the file to Firebase Storage
      Reference reference =
          FirebaseStorage.instance.ref().child('upload_file/$fileName.png');
      await reference.putFile(imageFile);

      String downloadURL = await reference.getDownloadURL();
      return downloadURL;
    } catch (e) {
      return '';
    }
  }
}
