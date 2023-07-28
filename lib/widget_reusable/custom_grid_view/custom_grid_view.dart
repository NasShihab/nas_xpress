import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({super.key});

  Widget customGridView({required Widget widget}) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 15.h,
        childAspectRatio: .8,
        crossAxisCount: 2,
      ),
      itemCount: 5,
      itemBuilder: (context, index) {
        return widget;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
