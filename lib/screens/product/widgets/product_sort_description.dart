import 'package:cirilla/widgets/cirilla_html.dart';
import 'package:flutter/material.dart';

import 'package:cirilla/mixins/utility_mixin.dart';

import 'package:cirilla/models/product/product.dart';

class ProductSortDescription extends StatelessWidget with Utility {
  final Product? product;

  const ProductSortDescription({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return CirillaHtml(html: product?.shortDescription ?? '');
  }
}
