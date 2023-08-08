import 'package:flutter/material.dart';
import 'bottom_navigation_bar/bottom__navigation_bar.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: BottomNavigationBarPage(),
      ),
    );
  }
}
