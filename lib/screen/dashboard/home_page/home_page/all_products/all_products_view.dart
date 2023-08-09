import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/height_width/height_width_custom.dart';
import '../../../../../model/product_model.dart';
import '../../products/controller/get_product_controller.dart';
import '../../products/product_card_widget/product_card_widget.dart';

class AllProductsView extends StatelessWidget {
  const AllProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Products'),
        ),
        body: SafeArea(
            child: StreamBuilder<List<Product>>(
          // stream: controller.readAllProduct(),
          stream: Get.put(GetProductsController().readAllProduct()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Invalid');
            } else if (snapshot.hasData) {
              final product = snapshot.data!;
              return SizedBox(
                height: myHeight(context) * .30,
                width: double.infinity,
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 10.w,
                  children: List.generate(product.length, (index) {
                    return ProductCardWidget(
                      id: product[index].id,
                      image: product[index].image,
                      title: product[index].title,
                      description: product[index].description,
                      price: product[index].price,
                      ratings: product[index].ratings,
                      category: product[index].category,
                    );
                  }),
                ),
              );
            } else {
              return SizedBox(
                  height: 180.h,
                  child: const Center(child: CircularProgressIndicator()));
            }
          },
        )));
  }
}
