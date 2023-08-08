import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nas_xpress/screen/dashboard/home_page/poster_view/controller/poster_view_controller.dart';

import '../../../../core/my_colors.dart';

class PosterView extends StatelessWidget {
  PosterView({super.key});

  final controller = Get.put(PageViewController());

  @override
  Widget build(BuildContext context) {
    return getSliderImages();
  }

  Widget getSliderImages() {
    return SizedBox(
      height: 120.h,
      child: Obx(() {
        return Stack(
          children: [
            PageView.builder(
              scrollDirection: Axis.horizontal,
              onPageChanged: controller.selectedIndex,
              itemCount: controller.allImage.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    CachedNetworkImage(
                      height: 120.h,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      imageUrl: controller.allImage[index].toString(),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ],
                );
              },
            ),
            Positioned(
              bottom: 5.h,
              right: 10.w,
              child: Wrap(
                spacing: 10,
                children: List.generate(controller.allImage.length, (index) {
                  return Obx(() {
                    return Center(
                      child: Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                            color: controller.selectedIndex.value == index
                                ? myOrange
                                : Colors.tealAccent,
                            border: Border.all(color: Colors.black),
                            shape: BoxShape.circle),
                      ),
                    );
                  });
                }),
              ),
            ),
          ],
        );
      }),
    );
  }
}
