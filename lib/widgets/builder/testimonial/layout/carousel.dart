import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  final int length;
  final double? pad;
  final Widget Function(BuildContext context, int index) renderItem;

  const Carousel({
    super.key,
    this.length = 2,
    required this.renderItem,
    this.pad = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < length; i++) ...[
              if (i > 0)
                SizedBox(
                  width: pad,
                ),
              renderItem(context, i),
            ]
          ],
        ),
      ),
    );
  }
}
