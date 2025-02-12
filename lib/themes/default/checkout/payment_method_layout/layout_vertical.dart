import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/models/cart/gateway.dart';
import 'package:cirilla/payment_methods.dart';
import 'package:flutter/material.dart';

import 'item_gateway.dart';

class LayoutVertical extends StatelessWidget {
  final List<Gateway> gateways;
  final int active;
  final void Function(int index) select;
  final double padHorizontal;
  const LayoutVertical({
    required this.gateways,
    required this.active,
    required this.select,
    this.padHorizontal = layoutPadding,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        gateways.length,
        (index) {
          String? imageMethod = methods[gateways[index].id]?.logoPath;
          String? packageName = methods[gateways[index].id]?.libraryName;
          if (gateways[index].title == 'Credit Card/Debit Card/NetBanking' ||
              gateways[index].title == 'CinetPay' && packageName == 'razorpay_gateway') {
            // packageName='CinetPay';
            gateways[index].title = 'Mobile Money Cameroon';
            gateways[active].description =
            'Powered by CinetPay  \n Pay safely using Orange Money, MTN Mobile Money, Express Union, VISA or MasterCard; You will be redirected to the payment page after placing your order.';
          }
          if (packageName != null) {
            if (packageName.isEmpty) {
              packageName = null;
            }
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: padHorizontal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ItemGateway(
                  active: active,
                  index: index,
                  select: select,
                  imageMethod: imageMethod,
                  packageName: packageName,
                  title: Expanded(
                    child: Text(
                      gateways[index].title ?? '',
                      style: theme.textTheme.titleSmall?.copyWith(color: 0 == index ? theme.primaryColor : null),
                    ),
                  ),
                  padding: const EdgeInsets.only(bottom: itemPaddingMedium),
                ),
                if (gateways.isNotEmpty && active == index)
                  ItemDescription(
                    padding: const EdgeInsets.only(bottom: itemPaddingMedium),
                    description: gateways[active].description ?? '',
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
