import 'package:flutter/material.dart';

class ProductViewPanel extends StatelessWidget {
  const ProductViewPanel(this.image, {super.key});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Image.network(image),
      ),
    );
  }
}
