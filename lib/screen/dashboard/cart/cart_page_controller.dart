import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CartPageController extends GetxController {
  Future<void> sendCartDataToStore({
    required String id,
    required String title,
    required String description,
    required String image,
    required double price,
  }) async {
    final cartDocRef = FirebaseFirestore.instance
        .collection('user_data')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('user_cart')
        .doc(id);

    await cartDocRef.get().then((cartSnapshot) {
      if (cartSnapshot.exists) {
        int currentQuantity = cartSnapshot.data()!['quantity'];
        int newQuantity = currentQuantity + 1;
        cartDocRef.update({
          'quantity': newQuantity,
        });
      } else {
        cartDocRef.set({
          'id': id,
          'title': title,
          'description': description,
          'image': image,
          'price': price,
          'quantity': 1,
        });
      }
    });
  }

  Stream readCartProducts() => FirebaseFirestore.instance
      .collection('user_data')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('user_cart')
      .snapshots();

  Future<void> updateQuantity(
    String id,
    int quantity,
  ) async {
    if(quantity > 0) {
      await FirebaseFirestore.instance
        .collection('user_data')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('user_cart')
        .doc(id)
        .update({
      "quantity": quantity,
    });
    }
  }
}
