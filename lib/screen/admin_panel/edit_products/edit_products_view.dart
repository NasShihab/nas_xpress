import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nas_xpress/screen/admin_panel/controller/admin_page_controller.dart';
import 'package:nas_xpress/screen/admin_panel/edit_products/controller/edit_products_controller.dart';
import '../../../../core/height_width/height_width_custom.dart';
import '../../../auth/auth_widget/auth_widget.dart';

class EditProducts extends StatelessWidget {
  EditProducts({super.key});

  get editImageController => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: editProducts(context,
            imageProduct: '',
            titleProduct: '',
            descriptionProduct: '',
            priceProducts: 1,
            ratingsProducts: 1,
            imageView: '',
            docID: '',
            categoryProducts: ''),
      ),
    );
  }

  final adminController = Get.put(AdminPageController());
  final editProductController = Get.put(EditProductsController());

  Widget editProducts(
    BuildContext context, {
    required String docID,
    required String imageView,
    required String titleProduct,
    required String descriptionProduct,
    required String imageProduct,
    required double priceProducts,
    required double ratingsProducts,
    required String categoryProducts,
  }) {
    ////
    TextEditingController editTitleController =
        TextEditingController(text: titleProduct);
    TextEditingController editDescriptionController =
        TextEditingController(text: descriptionProduct);
    TextEditingController editImageController =
        TextEditingController(text: imageProduct);
    TextEditingController editPriceController =
        TextEditingController(text: priceProducts.toString());
    TextEditingController editRatingsController =
        TextEditingController(text: ratingsProducts.toString());
    TextEditingController editCategoryController =
        TextEditingController(text: categoryProducts);

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      title: const Center(child: Text('Edit Your Products')),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              height15(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(() {
                    if (editProductController.image.value.path == '') {
                      return CircleAvatar(
                        radius: 30.r,
                        child: const Icon(Icons.camera_alt_outlined),
                      );
                    } else {
                      return CircleAvatar(
                        backgroundImage: FileImage(
                            File(editProductController.image.value.path)),
                        radius: 30.r,
                      );
                    }
                  }),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                        textStyle: MaterialStateProperty.all(
                          GoogleFonts.secularOne(fontSize: 15.sp),
                        )),
                    onPressed: () async {
                      editProductController.picImage();
                    },
                    child: const Text('Select New Image'),
                  ),
                ],
              ),
              height15(),
              FormFieldWidget(
                onChanged: (value) {},
                labelText: 'Title',
                controller: editTitleController,
              ),
              height15(),
              FormFieldWidget(
                onChanged: (value) {},
                labelText: 'Description',
                controller: editDescriptionController,
              ),
              height15(),
              FormFieldWidget(
                onChanged: (value) {},
                labelText: 'Image',
                controller: editImageController,
                readOnly: true,
              ),
              height15(),
              FormFieldWidget(
                onChanged: (value) {},
                labelText: 'Price',
                controller: editPriceController,
              ),
              height15(),
              FormFieldWidget(
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    double? number = double.tryParse(value);
                    if (number! < 1 || number > 5) {
                      editRatingsController.value = const TextEditingValue(
                        text: '',
                        selection: TextSelection.collapsed(offset: 0),
                      );
                    }
                  }
                },
                labelText: 'Ratings (1 to 5)',
                controller: editRatingsController,
              ),
              height15(),
              TextFormField(
                readOnly: true,
                controller: editCategoryController,
                decoration: InputDecoration(
                  prefixIcon: DropdownButton<String>(
                    items:
                        EditProductsController().category.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                        onTap: () {
                          editCategoryController.text = value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? value) {},
                  ),
                  labelText: 'Category',
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
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (editProductController.image.value.path != '') {
              String downloadURL = await editProductController
                  .overwriteImageWithGalleryImage(imageProduct);
              // print(downloadURL);
              editImageController.text = downloadURL;
            }

            editProductController.updateData(
              docID,
              editImageController.text,
              editTitleController.text,
              editDescriptionController.text,
              double.parse(editPriceController.text),
              double.parse(editRatingsController.text),
              editCategoryController.text,
            );
            editProductController.updateFavoriteData(
              docID,
              editImageController.text,
              editTitleController.text,
              editDescriptionController.text,
              double.parse(editPriceController.text),
            );
          },
          child: const Text('Update'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
