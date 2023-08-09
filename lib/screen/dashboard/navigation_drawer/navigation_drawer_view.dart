import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nas_xpress/core/theme/text_theme.dart';
import 'package:nas_xpress/screen/dashboard/user_profile/controller/user_profile_picture_controller.dart';
import 'package:nas_xpress/screen/dashboard/navigation_drawer/latest_collections/latest_collections_page.dart';
import '../../admin_panel/admin_page.dart';
import '../../../auth/login/login_page.dart';
import '../user_profile/user_profile_view.dart';
import '../../../core/routes/my_routes.dart';
import '../../../core/my_colors.dart';
import '../../../core/widget_reusable.dart';
import '../../../../core/height_width/height_width_custom.dart';

class MyNavigationDrawer extends StatelessWidget {
  MyNavigationDrawer({super.key});

  final getController = Get.put(UserPictureController());

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      children: [
        profilePart(context),
        ListTile(
          title: Text(
            'Men\'s Collection',
            style: bodyLarge(context)?.copyWith(fontWeight: FontWeight.bold),
          ),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            'Women\'s Collection',
            style: bodyLarge(context)?.copyWith(fontWeight: FontWeight.bold),
          ),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            'Latest Collection',
            style: bodyLarge(context)?.copyWith(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            navigationRightToLeftWithFade(
                pageName: const LatestCollectionsPage());
          },
        ),
        ListTile(
          title: Text(
            'Most Popular',
            style: bodyLarge(context)?.copyWith(fontWeight: FontWeight.bold),
          ),
          onTap: () {},
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
                      style: bodyMedium(context),
                    ),
                    Text(
                      "${FirebaseAuth.instance.currentUser?.email}",
                      style: bodySmall(context)?.copyWith(color: myOrange),
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
