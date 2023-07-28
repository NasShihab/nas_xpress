import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FavoriteProductController extends GetxController {
  Future<void> sendFavoriteDataToStore(
    String id,
    String title,
    String description,
    String image,
    double price,
  ) async {
    FirebaseFirestore.instance
        .collection('user_data')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('user_favorite')
        .doc(id)
        .set({
      "id": id,
      "title": title,
      "description": description,
      "image": image,
      "price": price,
      "isFavorite": "true",
    });
  }

  Stream readFavoriteProducts() => FirebaseFirestore.instance
      .collection('user_data')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('user_favorite')
      .snapshots();

}
