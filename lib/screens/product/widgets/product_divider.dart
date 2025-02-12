import 'package:flutter/material.dart';

class ProductDivider extends StatelessWidget {
  final double height;
  final Color? color;

  const ProductDivider({super.key, this.height = 1, this.color});

  @override
  Widget build(BuildContext context) {
    if (height < 1) {
      return Container();
    }

    return Divider(
      height: height,
      thickness: height,
      color: color,
    );
  }
}
