import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nas_xpress/core/theme/text_theme.dart';
import 'package:nas_xpress/screen/admin_panel/controller/admin_page_controller.dart';
import 'package:nas_xpress/screen/dashboard/dashboard_page.dart';
import 'package:nas_xpress/core/my_colors.dart';
import '../../../../core/height_width/height_width_custom.dart';
import '../../auth/auth_widget/auth_widget.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    final adminController = Get.put(AdminPageController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    Get.offAll(
                      const DashBoard(),
                    );
                  },
                  child: Text(
                    'Dashboard',
                    style: titleSmall(context)?.copyWith(color: Colors.white),
                  ),
                ),
                Center(
                  child: Text(
                    'Add Products',
                    textAlign: TextAlign.center,
                    style: titleSmall(context),
                  ),
                ),
                height20(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        adminController.picImage();
                      },
                      child: Text(
                        'Select Picture',
                        style: GoogleFonts.secularOne(fontSize: 16.sp),
                      ),
                    ),
                    width10(),
                    Obx(() {
                      if (adminController.image.value.path == '') {
                        return CircleAvatar(
                          backgroundColor: myOrange,
                          radius: 30.r,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 40.sp,
                          ),
                        );
                      } else {
                        return CircleAvatar(
                          backgroundImage:
                              FileImage(File(adminController.image.value.path)),
                          radius: 30.r,
                        );
                      }
                    }),
                    ElevatedButton(
                      onPressed: () {
                        adminController.disposeText();
                      },
                      child: Text(
                        'Clear',
                        style: GoogleFonts.secularOne(fontSize: 16.sp),
                      ),
                    ),
                  ],
                ),
                height15(),
                FormFieldWidget(
                  onChanged: (value) {},
                  labelText: 'Title',
                  controller: adminController.titleController,
                ),
                height15(),
                FormFieldWidget(
                  onChanged: (value) {},
                  labelText: 'Description',
                  controller: adminController.descriptionController,
                ),
                height15(),
                FormFieldWidget(
                  onChanged: (value) {},
                  readOnly: true,
                  labelText: 'Image (Auto filled up)',
                  controller: adminController.imageController,
                ),
                height15(),
                FormFieldWidget(
                  onChanged: (value) {},
                  labelText: 'Price',
                  controller: adminController.priceController,
                ),
                height15(),
                FormFieldWidget(
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      double? number = double.tryParse(value);
                      if (number! < 1 || number > 5) {
                        adminController.ratingsController.value =
                            const TextEditingValue(
                          text: '',
                          selection: TextSelection.collapsed(offset: 0),
                        );
                      }
                    }
                  },
                  labelText: 'Ratings (1 to 5)',
                  controller: adminController.ratingsController,
                ),
                height15(),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: DropdownButton<String>(
                        style: bodySmall(context),
                        padding: EdgeInsets.zero,
                        iconSize: 20.sp,
                        items: adminController.category.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                              style: bodySmall(context),
                            ),
                            onTap: () {
                              adminController.categoryController.text = value;
                            },
                          );
                        }).toList(),
                        onChanged: (String? value) {},
                        alignment: AlignmentDirectional.centerEnd,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        readOnly: true,
                        controller: adminController.categoryController,
                        decoration: InputDecoration(
                          labelText: 'Category',
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
                        style: bodySmall(context),
                      ),
                    ),
                  ],
                ),
                height15(),
                RoundedButton(
                  text: 'ADD',
                  fillColor: myOrange,
                  textColor: Colors.white,
                  onPressed: () async {
                    if (adminController.titleController.text.trim().isEmpty ||
                        adminController.descriptionController.text
                            .trim()
                            .isEmpty ||
                        adminController.priceController.text.trim().isEmpty ||
                        adminController.priceController.text.trim() == '' ||
                        adminController.categoryController.text
                            .trim()
                            .isEmpty) {
                      // Display an error message or handle the case where any of the fields are empty.
                      Get.snackbar(
                        '',
                        '',
                        backgroundColor: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        colorText: const Color(0xff021112),
                        titleText: Text(
                          'Complete all the information for upload picture',
                          style: GoogleFonts.secularOne(),
                        ),
                      );
                      return;
                    } else if (adminController.imageController.text
                        .trim()
                        .isEmpty) {
                      Get.snackbar(
                        'Error',
                        'Please fill in all the fields',
                        backgroundColor: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        colorText: const Color(0xff021112),
                        titleText: Text(
                          'Wait for upload picture',
                          style: GoogleFonts.secularOne(),
                        ),
                      );

                      String downloadURL =
                          await adminController.uploadImageToFirebase(context);

                      adminController.imageController.text = downloadURL;
                    } else {
                      adminController.sendDataToStore();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
