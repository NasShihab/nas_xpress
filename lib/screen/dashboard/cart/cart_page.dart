import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nas_xpress/screen/dashboard/cart/controller/cart_page_controller.dart';
import 'package:nas_xpress/core/widget_reusable.dart';

import '../../../core/theme/text_theme.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartPageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart Items',
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: cartController.readCartProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Invalid');
            } else if (snapshot.hasData) {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot favorites = snapshot.data!.docs[index];
                        return Slidable(
                          endActionPane: ActionPane(
                            extentRatio: .2,
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  FirebaseFirestore.instance
                                      .collection('user_data')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.email)
                                      .collection('user_cart')
                                      .doc(favorites["id"])
                                      .delete();
                                },
                                icon: Icons.delete,
                                label: 'Delete',
                                backgroundColor: Colors.red,
                                spacing: 1,
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: ListTile(
                                  isThreeLine: true,
                                  title: Text(
                                    favorites["title"],
                                    style: bodySmall(context)
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  leading: Image.network(
                                    favorites["image"],
                                    height: double.infinity,
                                    width: 50.w,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        favorites["description"],
                                        style: bodySmall(context),
                                      ),
                                      Text(
                                        favorites["id"],
                                        style: bodySmall(context)
                                            ?.copyWith(fontSize: 12.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            cartController.updateQuantity(
                                                favorites["id"],
                                                favorites["quantity"] - 1);
                                          },
                                          icon: const Icon(
                                            Icons.remove,
                                          ),
                                        ),
                                        Text(
                                          favorites["quantity"].toString(),
                                          style: bodyMedium(context),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            cartController.updateQuantity(
                                                favorites["id"],
                                                favorites["quantity"] + 1);
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      favorites["price"].toString(),
                                      style: bodySmall(context)?.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 50.h,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Color(0xff173f7d),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('user_data')
                                    .doc(FirebaseAuth
                                        .instance.currentUser!.email)
                                    .collection('user_cart')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  }

                                  double sum = 0;

                                  if (snapshot.hasData) {
                                    sum = snapshot.data!.docs.fold(
                                      0,
                                      (previousValue, document) =>
                                          previousValue +
                                          (document.data()['price']) *
                                              (document.data()['quantity']),
                                    );
                                  }

                                  return Text(
                                    'Total Price: $sum ৳',
                                    style: GoogleFonts.secularOne(
                                        color: Colors.white),
                                  );
                                },
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    flutterToast(msg: 'Checkout');
                                  },
                                  child: const Text('Checkout'))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
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
    );
  }
}
