import 'package:cirilla/models/product/product.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/utils.dart';

import 'package:flutter/material.dart';

import 'product_related.dart';

class ProductUpsell extends StatelessWidget {
  final Product? product;
  final EdgeInsetsDirectional padding;
  final String? align;

  const ProductUpsell({
    super.key,
    this.product,
    this.padding = EdgeInsetsDirectional.zero,
    this.align = 'left',
  });

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    List<int> ids = product?.upsellIds ?? [];
    if (ids.isEmpty) {
      return Container();
    }
    return ProductListView(
      ids: ids,
      keyStore: 'upsell_product',
      title: translate('product_upsell'),
      padding: padding,
      align: align,
    );
  }
}
