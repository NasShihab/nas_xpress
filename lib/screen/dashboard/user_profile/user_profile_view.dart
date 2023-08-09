import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nas_xpress/auth/sign_up/user_form_data/controller/user_data_controller.dart';
import 'package:nas_xpress/core/theme/text_theme.dart';
import 'package:nas_xpress/screen/dashboard/user_profile/controller/read_user_controller.dart';
import 'package:nas_xpress/screen/dashboard/user_profile/controller/user_profile_picture_controller.dart';
import 'package:nas_xpress/core/my_colors.dart';
import '../../../../core/height_width/height_width_custom.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReadUserController());
    final fetching = Get.put(UserPictureController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: controller.readUserData2(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userdata = snapshot.data!;

              TextEditingController nameController =
                  TextEditingController(text: userdata.name);
              TextEditingController emailController = TextEditingController(
                  text: FirebaseAuth.instance.currentUser!.email);
              TextEditingController address1Controller =
                  TextEditingController(text: userdata.address1);
              TextEditingController cityController =
                  TextEditingController(text: userdata.city);

              TextEditingController phoneController =
                  TextEditingController(text: userdata.phone);
              TextEditingController ageController =
                  TextEditingController(text: userdata.age);
              TextEditingController genderController =
                  TextEditingController(text: userdata.gender);

              return Obx(() {
                return ListView(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  children: [
                    height15(),
                    Stack(
                      children: [
                        Center(
                            child: fetching.image.value.path == ''
                                ? Get.put(UserPictureController())
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
                                  radius: 15.r,
                                  child: Icon(
                                    CupertinoIcons.camera,
                                    size: 16.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                    textFormField(
                      context,
                      controller: nameController,
                      labelText: 'Name',
                      readonly: controller.readonly.value,
                    ),
                    textFormField(
                      context,
                      controller: emailController,
                      labelText: 'Email',
                      readonly: true,
                      prefixIcon: const Icon(CupertinoIcons.mail),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: textFormField(
                            context,
                            controller: address1Controller,
                            labelText: 'Address',
                            readonly: controller.readonly.value,
                            prefixIcon:
                                const Icon(CupertinoIcons.map_pin_ellipse),
                          ),
                        ),
                        Expanded(
                          child: textFormField(
                            context,
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
                      context,
                      controller: phoneController,
                      labelText: 'Phone',
                      readonly: controller.readonly.value,
                      prefixIcon: const Icon(CupertinoIcons.phone_fill),
                    ),
                    textFormField(
                      context,
                      keyboardType: TextInputType.number,
                      controller: ageController,
                      labelText: 'Age',
                      readonly: controller.readonly.value,
                      prefixIcon: const Icon(CupertinoIcons.person_badge_minus),
                    ),
                    textFormField(
                      context,
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
                        child: Text(
                          'Edit Data',
                          style: bodyLarge(context)?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.saveButton.value,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.updateData(
                            name: nameController.text.trim(),
                            phone: phoneController.text.trim(),
                            address1: address1Controller.text.trim(),
                            city: cityController.text.trim(),
                            age: ageController.text.trim(),
                            gender: genderController.text.trim(),
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
                                style: bodyLarge(context)?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
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

TextFormField textFormField(
  BuildContext context, {
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
        hintStyle: bodySmall(context),
        prefixIcon: prefixIcon,
        prefixIconColor: Colors.green[700],
        labelText: labelText),
    style: bodySmall(context)
        ?.copyWith(color: myOrange, fontWeight: FontWeight.bold),
  );
}
