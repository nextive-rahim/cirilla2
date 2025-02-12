import 'package:cirilla/models/product/product.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:flutter/material.dart';

class ProductName extends StatelessWidget {
  final Product? product;
  final String? align;

  const ProductName({
    super.key,
    this.product,
    this.align = 'left',
  });

  @override
  Widget build(BuildContext context) {
    TextAlign textAlign = ConvertData.toTextAlignDirection(align);
    return Text(
      product?.name ?? '',
      style: Theme.of(context).textTheme.titleLarge,
      textAlign: textAlign,
    );
  }
}
