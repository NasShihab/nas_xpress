import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nas_xpress/model/product_model.dart';

class GetProductsController extends GetxController {
  Stream<List<Product>> readAllProduct() => FirebaseFirestore.instance
      .collection('product_list')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList());

  Stream<Product?> readSingleProductsItemStream(String doc) async* {
    final docUser =
        FirebaseFirestore.instance.collection('product_list').doc(doc);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      yield Product.fromJson(snapshot.data()!);
    } else {
      yield null;
    }
  }

  Stream<List<Product>> maleCollectionsProduct() => FirebaseFirestore.instance
      .collection('product_list')
      .where('category', isEqualTo: 'Male Collections')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList());

  Stream<List<Product>> femaleCollectionsProduct() => FirebaseFirestore.instance
      .collection('product_list')
      .where('category', isEqualTo: 'Female Collections')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList());
}
