import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/get_product_controller.dart';
import '../../../../../model/product_model.dart';
import '../products_widget/product_card_widget/product_card_widget.dart';

class AllProductsView extends StatelessWidget {
  const AllProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Products',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: StreamBuilder<List<Product>>(
            stream: Get.put(GetProductsController()).readAllProduct(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Invalid');
              } else if (snapshot.hasData) {
                final product = snapshot.data!;
                return SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 15.w,
                      mainAxisSpacing: 15.h,
                      childAspectRatio: .8,
                      crossAxisCount: 2,
                    ),
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
          ),
        ),
      ),
    );
  }
}
