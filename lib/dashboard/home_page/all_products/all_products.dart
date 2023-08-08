import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nas_xpress/auth/admin_panel/admin_page_controller.dart';
import 'package:nas_xpress/auth/admin_panel/edit_products/edit_products_controller.dart';
import 'package:nas_xpress/auth/admin_panel/edit_products/edit_products_view.dart';
import 'package:nas_xpress/screen/dashboard/cart/cart_page_controller.dart';
import 'package:nas_xpress/model/product_model.dart';
import 'package:nas_xpress/dashboard/home_page/all_products/product_view.dart';
import 'package:nas_xpress/core/my_colors.dart';
import 'package:nas_xpress/core/widget_reusable.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../screen/dashboard/favorite_products/favorite_product_controller.dart';
import 'get_product_controller.dart';

class AllProducts extends StatelessWidget {
  AllProducts({super.key});

  final controller = Get.put(GetProductsController());
  final adminController = Get.put(AdminPageController());
  final editProductController = Get.put(EditProductsController());
  final favoriteAddController = Get.put(FavoriteProductController());
  final cartController = Get.put(CartPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(),
      ),
    );
  }

// Get All products
  StreamBuilder fetchAllProducts() {
    return StreamBuilder<List<Product>>(
      stream: controller.readAllProduct(),
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
                child: productViewBox(
                  product[index].id,
                  product[index].image,
                  product[index].title,
                  product[index].description,
                  product[index].price,
                  product[index].ratings,
                  product[index].category,
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

// Category Item
  StreamBuilder selectedCollections(String categoryName) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('product_list')
          .where('category', isEqualTo: categoryName)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 180.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          final documents = snapshot.data!.docs;
          List<Product> productList = documents
              .map(
                  (doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
              .toList();
          return SizedBox(
            height: 180.h,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                // Display the product details based on your UI requirements
                return productViewBox(
                  product.id,
                  product.image,
                  product.title,
                  product.description,
                  product.price,
                  product.ratings,
                  product.category,
                );
              },
              separatorBuilder: (context, index) {
                return width10();
              },
            ),
          );
        }

        // Handle the case where there are no products
        return const Text('No products found.');
      },
    );
  }

  Widget productViewBox(
    String id,
    String image,
    String title,
    String description,
    double price,
    double ratings,
    String category,

  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Material(
        child: InkWell(
          splashColor: myOrange,
          onTap: () {
            Get.to(ProductViewPanel(image));
          },
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      // Color(0xFFe9edc9),
                      // Color(0xFF48cae4),
                      Colors.white,
                      Colors.white,
                    ],
                  ),
                  border: Border.all(color: myOrange),
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(1),
                      offset: const Offset(0, 5),
                      blurRadius: 5.r,
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        image,
                        fit: BoxFit.cover,
                        height: 100.h,
                        width: 100.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: GoogleFonts.secularOne(fontSize: 14.sp),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '${price.toString()} ৳',
                                style: GoogleFonts.secularOne(fontSize: 14.sp),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: ratingsBarWidget(
                                        ratingsProducts: ratings)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: .1.h,
                right: .1.w,
                child: IconButton(
                  isSelected: false,
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                    size: 25.sp,
                    color: myOrange,
                  ),
                ),
              ),
              Positioned(
                top: .1.h,
                right: .1.w,
                child: IconButton(
                  isSelected: false,
                  onPressed: () {
                    favoriteAddController.sendFavoriteDataToStore(
                      id,
                      title,
                      description,
                      image,
                      price,
                    );
                    flutterToast(msg: "Added to favorites");
                  },
                  icon: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('user_data')
                          .doc(FirebaseAuth.instance.currentUser!.email)
                          .collection('user_favorite')
                          .doc(id)
                          .snapshots()
                          .map((snapshot) => snapshot.data()?['isFavorite']),
                      builder: (context, snapshot) {
                        Color iconColor =
                            snapshot.data == 'true' ? myOrange : Colors.white;
                        return Icon(
                          Icons.favorite,
                          size: 18,
                          color: iconColor,
                        );
                      }),
                ),
              ),
              Positioned(
                top: 25.h,
                right: .1.w,
                child: IconButton(
                  isSelected: false,
                  onPressed: () {
                    cartController.sendCartDataToStore(
                      id: id,
                      title: title,
                      description: description,
                      image: image,
                      price: price,
                    );
                    flutterToast(msg: "Added to cart Items");
                  },
                  icon: Icon(
                    CupertinoIcons.add_circled_solid,
                    size: 25.sp,
                    color: myOrange,
                  ),
                ),
              ),
              Positioned(
                top: 60.h,
                right: 10.w,
                child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('user_data')
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!['role'] == 'admin') {
                      return adminDeleteUpdate(
                        context,
                        docID: id,
                        imageView: image,
                        titleProduct: title,
                        descriptionProduct: description,
                        imageProduct: image,
                        priceProducts: price,
                        ratingsProducts: ratings,
                        categoryProducts: category,
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget adminDeleteUpdate(
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
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return EditProducts().editProducts(
                    context,
                    docID: docID,
                    imageView: imageView,
                    titleProduct: titleProduct,
                    descriptionProduct: descriptionProduct,
                    imageProduct: imageProduct,
                    priceProducts: priceProducts,
                    ratingsProducts: ratingsProducts,
                    categoryProducts: categoryProducts,
                  );
                });
          },
          child: Icon(
            Icons.edit,
            color: Colors.yellow,
            size: 25.sp,
          ),
        ),
        GestureDetector(
          onTap: () {
            // delete from main product data
            FirebaseFirestore.instance
                .collection('product_list')
                .doc(docID)
                .delete();
            //delete from favorite product data
            FirebaseFirestore.instance
                .collection('user_data')
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection('user_favorite')
                .doc(docID)
                .delete();
            FirebaseFirestore.instance
                .collection('user_data')
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection('user_cart')
                .doc(docID)
                .delete();

            adminController.deleteFireStorageImage(imageProduct);
          },
          child: Icon(
            Icons.delete,
            color: Colors.red,
            size: 25.sp,
          ),
        ),
        // IconButton(
        //   onPressed: () {},
        //   icon: Icon(
        //     Icons.edit,
        //     color: Colors.yellow,
        //     size: 25.sp,
        //   ),
        // ),
        // IconButton(
        //   onPressed: () {},
        //   icon: Icon(
        //     Icons.edit,
        //     color: Colors.yellow,
        //     size: 25.sp,
        //   ),
        // ),
      ],
    );
  }

  Widget ratingsBarWidget({required double ratingsProducts}) => Center(
        child: RatingBar(
          itemPadding: EdgeInsets.zero,
          itemSize: 18.sp,
          initialRating: ratingsProducts,
          ratingWidget: RatingWidget(
            full: const Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            half: const Icon(
              Icons.star,
              color: Colors.black,
            ),
            empty: const Icon(
              Icons.star,
              color: Colors.black,
            ),
          ),
          onRatingUpdate: (ratings) {
            ratings = ratings;
            //need setState
          },
        ),
      );
}
