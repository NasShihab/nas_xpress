import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nas_xpress/widget_reusable/my_colors.dart';

class AdminPageController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController ratingsController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  List<String> category = [
    'Male Collections',
    'Female Collections',
  ];

  Future<void> sendDataToStore() async {
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();
    String image = imageController.text.trim();
    String priceText = priceController.text.trim();
    String ratingsText = ratingsController.text.trim();
    String category = categoryController.text.trim();

    if (title.isEmpty ||
        description.isEmpty ||
        image.isEmpty ||
        priceText.isEmpty ||
        ratingsText == '' ||
        category.isEmpty) {
      // Display an error message or handle the case where any of the fields are empty.
      Get.snackbar(
        'Error',
        'Please fill in all the fields',
        snackPosition: SnackPosition.TOP,
        colorText: myOrange,
        titleText: Text(
          'Not Complete',
          style: GoogleFonts.secularOne(),
        ),
      );
      return;
    }

    double price = double.parse(priceText);
    double ratings = double.parse(ratingsText);
    //
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('product_list');
    String documentId =
        FirebaseFirestore.instance.collection('product_list').doc().id;
    await collectionRef.doc(documentId).set({
      "id": documentId,
      "title": title,
      "description": description,
      "image": image,
      "price": price,
      "ratings": ratings,
      "category": category,
    }).then(
      (value) => Get.snackbar(
        'Error',
        'Please fill in all the fields',
        snackPosition: SnackPosition.TOP,
        colorText: myOrange,
        titleText: Text(
          'Add Successful',
          style: GoogleFonts.secularOne(),
        ),
      ),
    );
  }

  // Image Upload
///////////////////////////////////////////////////////////////////////////////////////////
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

  Future<String> uploadImageToFirebase(BuildContext context) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    try {
      // Upload the file to Firebase Storage
      Reference reference =
          FirebaseStorage.instance.ref().child('product_images/$fileName.png');
      await reference.putFile(image.value);

      String downloadURL = await reference.getDownloadURL();
      return downloadURL;
    } catch (e) {
      return '';
    }
  }

  void deleteFireStorageImage(String downloadUrl) async {
    Reference storageRef = FirebaseStorage.instance.refFromURL(downloadUrl);
    await storageRef.delete();
  }

  void disposeText() {
    titleController.clear();
    descriptionController.clear();
    imageController.clear();
    priceController.clear();
    ratingsController.clear();
    categoryController.clear();
    image.value = File('');
    // Clear other text fields if needed
  }
}
