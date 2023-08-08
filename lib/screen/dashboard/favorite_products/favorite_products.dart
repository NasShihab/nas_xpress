import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controller/favorite_product_controller.dart';

class FavoriteProduct extends StatelessWidget {
  const FavoriteProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteAddController = Get.put(FavoriteProductController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite Items',
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: favoriteAddController.readFavoriteProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Invalid');
            } else if (snapshot.hasData) {
              return SizedBox(
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot favorites = snapshot.data!.docs[index];
                      return ListTile(
                        isThreeLine: true,
                        title: Text(favorites["title"]),
                        leading: Image.network(
                          favorites["image"],
                          width: 50.w,
                          height: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              favorites["description"],
                              style: GoogleFonts.secularOne(fontSize: 15.sp),
                            ),
                            Text(
                              favorites["id"],
                              style: TextStyle(fontSize: 15.sp),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('user_data')
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .collection('user_favorite')
                                .doc(favorites["id"])
                                .delete();
                          },
                          icon: const Icon(Icons.favorite, color: Colors.green),
                        ),
                      );
                    }),
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
