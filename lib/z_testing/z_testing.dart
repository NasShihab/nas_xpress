import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nas_xpress/widget_reusable/widget_reusable.dart';
import 'package:nas_xpress/z_testing/image_pick_controller.dart';

import '../widget_reusable/my_colors.dart';

class TestingPageImage extends StatelessWidget {
  const TestingPageImage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ZImagePickerController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  controller.picImage();
                },
                child: const Text('Select image from gallery'),
              ),
            ),
            height20(),
            Obx(
              () {
                return controller.image.value.path != ''
                    ? Image.file(controller.image.value)
                    : const Icon(
                        Icons.ac_unit_outlined,
                        size: 25,
                      );
              },
            ),
            height20(),
            ElevatedButton(
              onPressed: () async {
                String downloadURL =
                    await controller.uploadImageToFirebase(context);
                controller.updateImage.value = downloadURL;
                print(downloadURL);
              },
              child: const Text('Upload to FireStorage'),
            ),
            Obx(() {
              try {
                if (controller.updateImage.value.toString() == '') {
                  return CircleAvatar(
                    backgroundColor: myOrange,
                    radius: 30.r,
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 40.sp,
                    ),
                  );
                } else {
                  return Image(
                    image: NetworkImage(
                      controller.updateImage.value.toString(),
                    ),
                  );
                }
              } catch (e) {
                return Text('HELO');
              }

            }),
          ],
        ),
      ),
    );
  }
}
