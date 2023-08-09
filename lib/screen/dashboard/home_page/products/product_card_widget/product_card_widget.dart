import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nas_xpress/core/height_width/height_width_custom.dart';
import 'package:nas_xpress/core/theme/text_theme.dart';
import '../../../../../core/my_colors.dart';
import '../../../../../core/widget_reusable.dart';
import '../../../../admin_panel/controller/admin_page_controller.dart';
import '../../../../admin_panel/edit_products/edit_products_view.dart';
import '../../../cart/controller/cart_page_controller.dart';
import '../../../favorite_products/controller/favorite_product_controller.dart';
import '../products_details_view/product_details_view.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.ratings,
    required this.category,
  });

  final String id;
  final String image;
  final String title;
  final String description;
  final double price;
  final double ratings;
  final String category;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.r),
      child: Material(
        child: InkWell(
          splashColor: myOrange,
          onTap: () {
            Get.to(
              ProductViewPanel(image),
            );
          },
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Ink(
                width: myWidth(context) * .35,
                height: myHeight(context) * .30,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  border: Border.all(color: myOrange, width: 2.w),
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(1),
                      blurRadius: 5.r,
                    ),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  width: myWidth(context) * .35,
                  height: myHeight(context) * .30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.r),
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                          height: 100.h,
                          width: myWidth(context) * .35,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        title,
                        style: bodySmall(context)
                            ?.copyWith(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '${price.toString()} ৳',
                          style: bodySmall(context),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: myWidth(context) * .35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.star,
                              color: myOrange,
                              size: 16.sp,
                            ),
                            Text(
                              '($ratings)',
                              style:
                                  bodySmall(context)?.copyWith(fontSize: 12.sp),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
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
                bottom: 5.h,
                right: .1.w,
                child: IconButton(
                  isSelected: false,
                  onPressed: () {
                    Get.put(CartPageController()).sendCartDataToStore(
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

            Get.put(AdminPageController()).deleteFireStorageImage(imageProduct);
          },
          child: Icon(
            Icons.delete,
            color: Colors.red,
            size: 25.sp,
          ),
        ),
      ],
    );
  }
}
