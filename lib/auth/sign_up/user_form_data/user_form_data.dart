import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nas_xpress/auth/sign_up/user_form_data/controller/user_data_controller.dart';
import 'package:nas_xpress/core/my_colors.dart';
import 'package:nas_xpress/core/theme/text_theme.dart';
import '../../../../core/height_width/height_width_custom.dart';

import '../../auth_widget/auth_widget.dart';

final userDataController = Get.put(UserDataController());

class UserDataForm extends StatelessWidget {
  const UserDataForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: myOrange,
          statusBarIconBrightness: Brightness.light,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: myOrange,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(70.r),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Sign Up Complete! Now enter your information',
                      textAlign: TextAlign.center,
                      style: titleSmall(context)?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              height15(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            userDataController.picImage();
                          },
                          child: Text(
                            'Select Picture',
                            style: bodyMedium(context)?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        width10(),
                        Obx(() {
                          if (userDataController.image.value.path == '') {
                            return CircleAvatar(
                              backgroundColor: myOrange,
                              radius: 30.r,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 40.sp,
                                color: Colors.white,
                              ),
                            );
                          } else {
                            return CircleAvatar(
                              backgroundImage: FileImage(
                                  File(userDataController.image.value.path)),
                              radius: 30.r,
                            );
                          }
                        }),
                      ],
                    ),
                    height15(),
                    FormFieldWidget(
                      onChanged: (value) {},
                      labelText: 'Full Name',
                      controller: userDataController.nameController,
                    ),
                    height15(),
                    FormFieldWidget(
                      onChanged: (value) {},
                      labelText: 'Address 1',
                      controller: userDataController.addressLine1Controller,
                    ),
                    height15(),
                    TextFormField(
                      style: bodySmall(context),
                      readOnly: true,
                      controller: userDataController.cityNameController,
                      decoration: InputDecoration(
                        labelText: 'Select City',
                        labelStyle: bodySmall(context),
                        prefixIcon: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: PopupMenuButton<String>(
                            itemBuilder: (BuildContext context) {
                              return userDataController.city
                                  .map((String value) {
                                return PopupMenuItem<String>(
                                  value: value,
                                  child: ListTile(
                                    title: Text(
                                      value,
                                      style: bodySmall(context),
                                    ),
                                    onTap: () {
                                      userDataController
                                          .cityNameController.text = value;
                                      Navigator.pop(
                                          context); // Close the popup menu
                                    },
                                  ),
                                );
                              }).toList();
                            },
                            child: const Icon(
                                CupertinoIcons.arrow_down_circle_fill),
                            onSelected: (String value) {},
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.r)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 2.w,
                          ),
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                      ),
                    ),
                    height15(),
                    TextFormField(
                      style: bodySmall(context),
                      readOnly: true,
                      controller: userDataController.genderController,
                      decoration: InputDecoration(
                        prefixIcon: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: PopupMenuButton<String>(
                            itemBuilder: (BuildContext context) {
                              return userDataController.gender
                                  .map((String value) {
                                return PopupMenuItem<String>(
                                  value: value,
                                  child: ListTile(
                                    title: Text(
                                      value,
                                      style: bodySmall(context),
                                    ),
                                    onTap: () {
                                      userDataController.genderController.text =
                                          value;
                                      Navigator.pop(
                                          context); // Close the popup menu
                                    },
                                  ),
                                );
                              }).toList();
                            },
                            child: const Icon(
                                CupertinoIcons.arrow_down_circle_fill),
                            onSelected: (String value) {},
                          ),
                        ),
                        labelText: 'Gender',
                        labelStyle: bodySmall(context),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.r)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 2.w,
                          ),
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                      ),
                    ),
                    height15(),
                    FormFieldWidget(
                      onChanged: (value) {},
                      labelText: 'Phone Number',
                      controller: userDataController.phoneController,
                    ),
                    SizedBox(height: 16.h),
                    FormFieldWidget(
                      textInputFormatter:
                          FilteringTextInputFormatter.digitsOnly,
                      onChanged: (value) {},
                      labelText: 'Age',
                      controller: userDataController.ageController,
                    ),
                    height15(),
                    Obx(() {
                      return ElevatedButton(
                        onPressed: () async {
                          if (userDataController.nameController.text.isEmpty ||
                              userDataController.ageController.text.isEmpty ||
                              userDataController
                                  .genderController.text.isEmpty ||
                              userDataController.phoneController.text.isEmpty ||
                              userDataController
                                  .addressLine1Controller.text.isEmpty ||
                              userDataController
                                  .cityNameController.text.isEmpty) {
                            Get.snackbar(
                              'Error',
                              'Please fill in all the fields',
                              backgroundColor: Colors.white,
                              snackPosition: SnackPosition.TOP,
                              colorText: const Color(0xff021112),
                              titleText: Text(
                                'Fill all the information',
                                style: GoogleFonts.secularOne(),
                              ),
                            );
                          } else {
                            try {
                              await userDataController
                                  .uploadImageToFirebaseN(context);
                              userDataController.sendDataToStore();
                            } catch (e) {
                              return;
                            }
                            userDataController.disposeText();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: userDataController.isLoading.value
                            ? Center(
                                child: SizedBox(
                                  height: 20.h,
                                  width: 20.w,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                ),
                              )
                            : Text(
                                'Continue',
                                style: bodyMedium(context)?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
