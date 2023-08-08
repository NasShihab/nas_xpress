import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/my_colors.dart';

class UserProfileController extends GetxController {
  fetchProfilePicture() {
    return StreamBuilder(
      stream: FirebaseStorage.instance
          .ref()
          .child('user_image/${FirebaseAuth.instance.currentUser!.email}.png')
          .getDownloadURL()
          .asStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return SizedBox(
              height: 100.h,
              child: CircleAvatar(
                backgroundColor: myOrange,
                radius: 50.r,
                backgroundImage: CachedNetworkImageProvider(snapshot.data!),
              ),
            );
          } else if (snapshot.hasError) {
            return SizedBox(
              height: 100.h,
              child: Icon(
                Icons.person,
                size: 30.sp,
              ),
            );
          }
        }
        return SizedBox(
          height: 100.h,
          child: Center(
            child: CircularProgressIndicator(
              color: myOrange,
            ),
          ),
        );
      },
    );
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

  Future<String> overwriteImageWithGalleryImage() async {
    try {
      // Reference reference = FirebaseStorage.instance.refFromURL(imageUrl);
      // await reference.putFile(image.value);

      Reference reference = FirebaseStorage.instance
          .ref()
          .child('user_image/${FirebaseAuth.instance.currentUser!.email}.png');
      await reference.putFile(image.value);

      String downloadURL = await reference.getDownloadURL();
      return downloadURL;
    } catch (e) {
      return '';
    }
  }
}
