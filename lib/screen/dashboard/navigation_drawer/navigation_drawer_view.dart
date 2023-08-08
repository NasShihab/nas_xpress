import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nas_xpress/screen/dashboard/user_profile/controller/user_profile_picture_controller.dart';
import 'package:nas_xpress/screen/dashboard/navigation_drawer/latest_collections/latest_collections_page.dart';
import 'package:nas_xpress/screen/dashboard/home_page/products/all_products_view/all_products_view.dart';
import '../../admin_panel/admin_page.dart';
import '../../../auth/login/controller/login_page.dart';
import '../user_profile/user_profile_view.dart';
import '../../../core/routes/my_routes.dart';
import '../../../core/my_colors.dart';
import '../../../core/widget_reusable.dart';

class MyNavigationDrawer extends StatelessWidget {
  MyNavigationDrawer({super.key});

  final getController = Get.put(UserPictureController());

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      children: [
        profilePart(context),
        ListTile(
          title: const Text('Men\'s Collection'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Women\'s Collection'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Latest Collection'),
          onTap: () {
            navigationRightToLeftWithFade(
                pageName: const LatestCollectionsPage());
          },
        ),
        ListTile(
          title: const Text('Most Popular'),
          onTap: () {
            navigationRightToLeftWithFade(pageName: const AllProductsView());
          },
        ),
        StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('user_data')
              .doc(FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!['role'] == 'admin') {
              return IconButton(
                onPressed: () {
                  Get.offAll(const AdminPage());
                },
                icon: const Icon(Icons.light_mode),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }

  Widget profilePart(
    BuildContext context,
  ) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: getController.fetchProfilePicture(),
            ),
            width15(),
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  getToNavigation(pageName: const UserProfileView());
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: GoogleFonts.secularOne(fontSize: 15.sp),
                    ),
                    Text(
                      "${FirebaseAuth.instance.currentUser?.email}",
                      style: GoogleFonts.secularOne(
                          fontSize: 15.sp, color: myMaroon),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then(
                    (value) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.logout),
              ),
            )
          ],
        ),
      );
}
