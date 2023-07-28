import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nas_xpress/auth/sign_up/user_data/user_data_controller.dart';
import 'package:nas_xpress/auth/user_profile_page/user_profile_controller/read_user_controller.dart';
import 'package:nas_xpress/auth/user_profile_page/user_profile_controller/user_profile_picture_controller.dart';
import 'package:nas_xpress/widget_reusable/my_colors.dart';

import '../../widget_reusable/widget_reusable.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReadUserController());
    final fetching = Get.put(UserProfileController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: controller.readUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              DocumentSnapshot userData = snapshot.data!;

              TextEditingController nameController =
                  TextEditingController(text: userData["name"]);
              TextEditingController emailController = TextEditingController(
                  text: FirebaseAuth.instance.currentUser!.email);
              TextEditingController addressController =
                  TextEditingController(text: userData["address1"]);
              TextEditingController cityController =
                  TextEditingController(text: userData["city"]);

              TextEditingController phoneController =
                  TextEditingController(text: userData["phone"]);
              TextEditingController ageController =
                  TextEditingController(text: userData["age"].toString());
              TextEditingController genderController =
                  TextEditingController(text: userData["gender"]);

              return Obx(() {
                return ListView(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  children: [
                    height15(),
                    Stack(
                      children: [
                        Center(
                            child: fetching.image.value.path == ''
                                ? Get.put(UserProfileController())
                                    .fetchProfilePicture()
                                : SizedBox(
                                    height: 100.h,
                                    child: CircleAvatar(
                                      backgroundImage: FileImage(
                                        File(fetching.image.value.path),
                                      ),
                                      radius: 50.r,
                                    ),
                                  )),
                        Visibility(
                          visible: controller.saveButton.value,
                          child: Positioned(
                              right: 100.w,
                              bottom: 10.h,
                              child: GestureDetector(
                                onTap: () {
                                  fetching.picImage();
                                },
                                child: CircleAvatar(
                                  backgroundColor: myOrange,
                                  child: Icon(
                                    CupertinoIcons.camera,
                                    size: 20.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                    textFormField(
                      controller: nameController,
                      labelText: 'Name',
                      readonly: controller.readonly.value,
                    ),
                    textFormField(
                      controller: emailController,
                      labelText: 'Email',
                      readonly: true,
                      prefixIcon: const Icon(CupertinoIcons.mail),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: textFormField(
                            controller: addressController,
                            labelText: 'Address',
                            readonly: controller.readonly.value,
                            prefixIcon:
                                const Icon(CupertinoIcons.map_pin_ellipse),
                          ),
                        ),
                        Expanded(
                          child: textFormField(
                            controller: cityController,
                            labelText: 'City',
                            readonly: true,
                            prefixIcon: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: IgnorePointer(
                                ignoring: controller.readonly.value,
                                child: PopupMenuButton<String>(
                                  itemBuilder: (BuildContext context) {
                                    return Get.put(UserDataController())
                                        .city
                                        .map((String value) {
                                      return PopupMenuItem<String>(
                                        value: value,
                                        child: ListTile(
                                          title: Text(value),
                                          onTap: () {
                                            cityController.text = value;
                                            Navigator.pop(
                                                context); // Close the popup menu
                                          },
                                        ),
                                      );
                                    }).toList();
                                  },
                                  child: const Icon(CupertinoIcons.map_pin),
                                  onSelected: (String value) {},
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    textFormField(
                      controller: phoneController,
                      labelText: 'Phone',
                      readonly: controller.readonly.value,
                      prefixIcon: const Icon(CupertinoIcons.phone_fill),
                    ),
                    textFormField(
                      keyboardType: TextInputType.number,
                      controller: ageController,
                      labelText: 'Age',
                      readonly: controller.readonly.value,
                      prefixIcon: const Icon(CupertinoIcons.person_badge_minus),
                    ),
                    textFormField(
                      controller: genderController,
                      labelText: 'Gender',
                      readonly: true,
                      prefixIcon: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: IgnorePointer(
                          ignoring: controller.readonly.value,
                          child: PopupMenuButton<String>(
                            itemBuilder: (BuildContext context) {
                              return Get.put(UserDataController())
                                  .gender
                                  .map((String value) {
                                return PopupMenuItem<String>(
                                  value: value,
                                  child: ListTile(
                                    title: Text(value),
                                    onTap: () {
                                      genderController.text = value;
                                      Navigator.pop(
                                          context); // Close the popup menu
                                    },
                                  ),
                                );
                              }).toList();
                            },
                            child: const Icon(Icons.male),
                            onSelected: (String value) {},
                          ),
                        ),
                      ),
                    ),
                    height15(),
                    Visibility(
                      visible: controller.editButton.value,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.editDataMode();
                          controller.editButtonVisible();
                        },
                        child: const Text('Edit Data'),
                      ),
                    ),
                    Visibility(
                      visible: controller.saveButton.value,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.updateData(
                            nameController.text.trim(),
                            phoneController.text.trim(),
                            addressController.text.trim(),
                            cityController.text.trim(),
                            ageController.text.trim(),
                            genderController.text.trim(),
                          );
                          fetching.overwriteImageWithGalleryImage();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                        ),
                        child: controller.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Save Changes',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp),
                              ),
                      ),
                    ),
                  ],
                );
              });
            } else {
              return SizedBox(
                height: 180.h,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

TextFormField textFormField({
  required TextEditingController controller,
  required String labelText,
  required bool readonly,
  Widget prefixIcon = const Icon(
    CupertinoIcons.profile_circled,
  ),
  TextInputType keyboardType = TextInputType.text,
}) {
  return TextFormField(
    keyboardType: keyboardType,
    controller: controller,
    readOnly: readonly,
    decoration: InputDecoration(
        hintStyle: GoogleFonts.secularOne(
          fontSize: 16.sp,
        ),
        prefixIcon: prefixIcon,
        prefixIconColor: Colors.green[700],
        labelText: labelText),
    style: GoogleFonts.secularOne(
      fontSize: 16.sp,
      color: myOrange,
    ),
  );
}
