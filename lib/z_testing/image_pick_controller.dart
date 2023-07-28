import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ZImagePickerController extends GetxController {
  Rx<File> image = File('').obs;

  Future picImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemp = File(image.path);
      this.image.value = imageTemp;
      // this.image.value = imageTemp;
    } on PlatformException catch (e) {
      return e;
    }
  }

  RxString updateImage = ''.obs;

  Future<String> uploadImageToFirebase(BuildContext context) async {
    String fileName = 'NAS';

    try {
      Reference reference =
          FirebaseStorage.instance.ref().child('product_images/$fileName');
      await reference.putFile(image.value);

      String downloadURL = await reference.getDownloadURL();
      return downloadURL;
    } catch (e) {
      return '';
    }
  }
}
