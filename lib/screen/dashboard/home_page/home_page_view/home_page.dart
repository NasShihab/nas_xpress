import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nas_xpress/screen/dashboard/home_page/poster_view/poster_view.dart';
import 'package:nas_xpress/core/my_colors.dart';
import 'package:nas_xpress/core/widget_reusable.dart';
import '../../cart/cart_page.dart';
import '../../navigation_drawer/navigation_drawer_view.dart';
import '../products/controller/get_product_controller.dart';
import '../products/all_products.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GetProductsController());
    return Scaffold(
      drawer: MyNavigationDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu_sharp,
                color: myOrange,
              ),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.search),
            color: myOrange,
          ),
          IconButton(
            onPressed: () {
              Get.to(const CartPage());
            },
            icon: const Icon(CupertinoIcons.cart_fill),
            color: myOrange,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PosterView().getSliderImages(),
                height5(),

                //All Products
                titleRow(
                  itemCategoryTitle: 'All Products',
                  pageName: AllProducts(
                    function: controller.readAllProduct(),
                  ),
                ),
                AllProducts(
                  function: controller.readAllProduct(),
                ),

                // Female Collections
                titleRow(
                  itemCategoryTitle: 'Female Collections',
                  pageName: AllProducts(
                    function: controller.femaleCollectionsProduct(),
                  ),
                ),
                AllProducts(
                  function: controller.femaleCollectionsProduct(),
                ),

                // Male Collections
                titleRow(
                  itemCategoryTitle: 'Male Collections',
                  pageName: AllProducts(
                      function: controller.maleCollectionsProduct()),
                ),
                AllProducts(
                  function: controller.maleCollectionsProduct(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget titleRow(
      {required String itemCategoryTitle, required Widget pageName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(itemCategoryTitle, style: GoogleFonts.secularOne()),
        TextButton(
          onPressed: () {
            getToNavigation(pageName: pageName);
          },
          child: Text(
            'View More',
            style: GoogleFonts.secularOne(color: myOrange, fontSize: 16.sp),
          ),
        ),
      ],
    );
  }
}
