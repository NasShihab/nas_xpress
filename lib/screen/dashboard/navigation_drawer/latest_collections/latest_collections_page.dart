import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LatestCollectionsPage extends StatelessWidget {
  const LatestCollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Image(
                  image: const AssetImage('assets/images/asset2.png'),
                  fit: BoxFit.cover,
                  height: 250.h,
                ),
                Image(
                  image: const AssetImage('assets/images/portrait1.png'),
                  fit: BoxFit.cover,
                  height: 250.h,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
