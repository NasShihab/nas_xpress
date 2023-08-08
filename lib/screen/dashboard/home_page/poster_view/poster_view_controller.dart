import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class PageViewController extends GetxController {
  List allImage = <String>[].obs;
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    subscribeToImageStream();
  }

  Stream<List<String>> getAllImageStream() async* {
    await Firebase.initializeApp();
    final storage = FirebaseStorage.instance.ref().child('slider_images');
    final images = await storage.listAll();

    for (final image in images.items) {
      final downloadUrl = await image.getDownloadURL();
      allImage.add(downloadUrl);
    }
  }

  StreamSubscription<List<String>>? imageStreamSubscription;

  void subscribeToImageStream() {
    imageStreamSubscription = getAllImageStream().listen((_) {});
  }

  void unsubscribeFromImageStream() {
    imageStreamSubscription?.cancel();
    imageStreamSubscription = null;
  }
}
