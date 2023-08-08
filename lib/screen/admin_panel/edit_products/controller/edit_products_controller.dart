import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProductsController extends GetxController {
  List<String> category = [
    'Male Collections',
    'Female Collections',
    'Lids Collections'
  ];

  void updateData(String docID, String image, String title, String description,
      double price, double ratings, String category) {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('product_list');
    DocumentReference docRef = collectionRef.doc(docID);

    docRef.update({
      'image': image,
      'title': title,
      'description': description,
      'price': price.toDouble(),
      'ratings': ratings.toDouble(),
      'category': category,
      // add more fields and their updated values as needed
    });
  }

  void updateFavoriteData(
    String docID,
    String image,
    String title,
    String description,
    double price,
  ) {
    CollectionReference collectionRef = FirebaseFirestore.instance
        .collection('user_data')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('user_favorite');
    DocumentReference docRef = collectionRef.doc(docID);

    docRef.update({
      'image': image,
      'title': title,
      'description': description,
      'price': price.toDouble(),
      // add more fields and their updated values as needed
    });
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

  Future<String> overwriteImageWithGalleryImage(String imageUrl) async {
    try {
      Reference reference = FirebaseStorage.instance.refFromURL(imageUrl);
      await reference.putFile(image.value);

      String downloadURL = await reference.getDownloadURL();
      return downloadURL;
    } catch (e) {
      return '';
    }
  }
}
