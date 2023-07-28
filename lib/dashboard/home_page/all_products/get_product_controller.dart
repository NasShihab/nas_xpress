import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nas_xpress/dashboard/home_page/all_products/product_model.dart';

class GetProductsController extends GetxController {
  Stream<List<Product>> readAllUser() => FirebaseFirestore.instance
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
// this will matching the collections
  Stream<QuerySnapshot> selectedCollections() => FirebaseFirestore.instance
      .collection('product_list')
      .where('category', isEqualTo: 'categoryName')
      .snapshots();
}
