import 'package:cirilla/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CirillaShimmer extends StatelessWidget {
  final Widget? child;

  const CirillaShimmer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;

    if (isWeb) {
      Container c = child as Container;

      return Container(
        width: c.constraints!.minWidth,
        height: c.constraints!.minHeight,
        color: color,
      );
    }
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: child!,
    );
  }
}
