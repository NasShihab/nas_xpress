import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nas_xpress/core/height_width/height_width_custom.dart';
import 'package:nas_xpress/core/theme/text_theme.dart';
import '../../../../../core/widget_reusable.dart';
import '../../../../admin_panel/controller/admin_page_controller.dart';
import '../../../../admin_panel/edit_products/edit_products_view.dart';
import '../../../cart/controller/cart_page_controller.dart';
import '../../../favorite_products/controller/favorite_product_controller.dart';

class Product222CardWidget extends StatelessWidget {
  final String id;
  final String image;
  final String title;
  final String description;
  final double price;
  final double ratings;
  final String category;

  const Product222CardWidget({
    super.key,
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.ratings,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
        width: myWidth(context) * .35,
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Image.network(
                    image,
                    fit: BoxFit.scaleDown,
                    height: myHeight(context) * .12,
                    width: double.infinity,
                  ),
                  Positioned(
                    left: .1,
                    child: InkWell(
                      onTap: () {
                        Get.put(FavoriteProductController())
                            .sendFavoriteDataToStore(
                          id,
                          title,
                          description,
                          image,
                          price,
                        );
                        flutterToast(msg: "Added to favorites");
                      },
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('user_data')
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .collection('user_favorite')
                              .doc(id)
                              .snapshots()
                              .map(
                                  (snapshot) => snapshot.data()?['isFavorite']),
                          builder: (context, snapshot) {
                            dynamic icon = snapshot.data == 'true'
                                ? CupertinoIcons.heart_fill
                                : CupertinoIcons.heart;
                            return Icon(
                              icon,
                              size: 20,
                              // color: iconColor,
                            );
                          }),
                    ),
                  ),
                ],
              ),
              Text(
                title,
                style:
                    bodySmall(context)?.copyWith(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '৳ $price',
                style: bodySmall(context),
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.red,
                        size: 16.sp,
                      ),
                      Text(
                        '($ratings)',
                        style: bodySmall(context)?.copyWith(fontSize: 12.sp),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('user_data')
                        .doc(FirebaseAuth.instance.currentUser!.email)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data!['role'] == 'admin') {
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
                  InkWell(
                    onTap: () {
                      Get.put(CartPageController()).sendCartDataToStore(
                        id: id,
                        title: title,
                        description: description,
                        image: image,
                        price: price,
                      );
                      flutterToast(msg: "Added to cart Items");
                    },
                    child: Icon(
                      CupertinoIcons.add_circled_solid,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
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
  return Row(
    children: [
      InkWell(
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
          size: 20.sp,
        ),
      ),
      InkWell(
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

          Get.put(AdminPageController()).deleteFireStorageImage(imageProduct);
        },
        child: Icon(
          Icons.delete,
          color: Colors.red,
          size: 20.sp,
        ),
      ),
    ],
  );
}
