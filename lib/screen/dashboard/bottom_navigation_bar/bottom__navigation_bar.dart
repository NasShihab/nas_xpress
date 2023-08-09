import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nas_xpress/screen/dashboard/user_profile/user_profile_view.dart';
import 'package:nas_xpress/screen/dashboard/cart/cart_page.dart';
import 'package:nas_xpress/core/my_colors.dart';
import '../favorite_products/favorite_products.dart';
import '../home_page/home_page/home_page.dart';
import 'controller/bottom_navigation_controller.dart';

class BottomNavigationBarPage extends StatelessWidget {
  const BottomNavigationBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavigationBarController());

    final List<Widget> screens = [
      // 1st Screen
      const HomePage(),
      // 2nd Screen
      const FavoriteProduct(),
      //3ed Screen
      const CartPage(),
      //4th Screen
      const UserProfileView(),
    ];

    return Scaffold(
      bottomNavigationBar: Obx(() {
        return NavigationBarTheme(
          data: NavigationBarThemeData(
            iconTheme: MaterialStateProperty.resolveWith<IconThemeData?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return const IconThemeData(color: Color(0xff9dd9d2));
                }
                return IconThemeData(
                  size: 25.sp,
                  color: Colors.black,
                );
              },
            ),
            indicatorShape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            indicatorColor: Colors.black,
            backgroundColor: myOrange,
            labelTextStyle: MaterialStateProperty.all(
              GoogleFonts.secularOne(fontSize: 13.sp),
            ),
          ),
          child: NavigationBar(
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            selectedIndex: controller.currentIndex.value,
            onDestinationSelected: (index) {
              controller.currentIndex.value = index;
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(CupertinoIcons.home),
                label: 'Home',
                selectedIcon: Icon(
                  CupertinoIcons.home,
                ),
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_border),
                label: 'Favorite',
                selectedIcon: Icon(
                  Icons.favorite_border,
                ),
              ),
              NavigationDestination(
                icon: Icon(CupertinoIcons.shopping_cart),
                label: 'Cart',
                selectedIcon: Icon(
                  CupertinoIcons.shopping_cart,
                ),
              ),
              NavigationDestination(
                icon: Icon(CupertinoIcons.profile_circled),
                label: 'Profile',
                selectedIcon: Icon(
                  CupertinoIcons.profile_circled,
                ),
              ),
            ],
          ),
        );
      }),
      body: Obx(() {
        return screens[controller.currentIndex.value];
      }),
    );
  }
}
