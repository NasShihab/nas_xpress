import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nas_xpress/model/product_model.dart';
import 'package:nas_xpress/core/widget_reusable.dart';
import 'package:nas_xpress/screen/dashboard/home_page/products/product_card_widget/product_card_widget.dart';
import 'controller/get_product_controller.dart';

class AllProducts extends StatelessWidget {
  AllProducts({super.key, required this.function});

  final Stream<List<Product>> function;

  final controller = Get.put(GetProductsController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      // stream: controller.readAllProduct(),
      stream: function,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Invalid');
        } else if (snapshot.hasData) {
          final product = snapshot.data!;
          return SizedBox(
            height: 180.h,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              separatorBuilder: (context, index) => width10(),
              itemCount: product.length,
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: ProductCardWidget(
                  id: product[index].id,
                  image: product[index].image,
                  title: product[index].title,
                  description: product[index].description,
                  price: product[index].price,
                  ratings: product[index].ratings,
                  category: product[index].category,
                ),
              ),
            ),
          );
        } else {
          return SizedBox(
              height: 180.h,
              child: const Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
