import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nas_xpress/model/product_model.dart';
import '../product_card_widget/product_card_widget.dart';

class FetchAllProducts extends StatelessWidget {
  const FetchAllProducts({super.key, required this.function});

  final Stream<List<Product>> function;

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
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 20.w,
              direction: Axis.horizontal,
              children: List.generate(product.length, (index) {
                return Product222CardWidget(
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
    );
  }
}
