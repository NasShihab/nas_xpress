import 'package:get/get.dart';

class BottomNavigationBarController extends GetxController {

  RxInt currentIndex = 0.obs;

  void selectedIndex(int index) {
   currentIndex.value = index;
  }
}
