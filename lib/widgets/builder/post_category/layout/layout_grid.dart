import 'package:cirilla/models/models.dart';
import 'package:cirilla/types/types.dart';
import 'package:flutter/material.dart';

class LayoutGrid extends StatelessWidget {
  final List<PostCategory>? categories;
  final BuildItemPostCategoryType? buildItem;
  final int column;
  final double? ratio;
  final double? pad;
  final EdgeInsetsDirectional padding;
  final double? widthView;

  const LayoutGrid({
    super.key,
    this.categories,
    this.buildItem,
    this.column = 2,
    this.ratio = 1,
    this.pad = 0,
    this.padding = EdgeInsetsDirectional.zero,
    this.widthView = 300,
  });

  @override
  Widget build(BuildContext context) {
    double widthWidget = widthView! - padding.start - padding.end;

    int col = column > 1 ? column : 2;

    double widthItem = (widthWidget - (col - 1) * pad!) / col;
    double heightItem = widthItem / ratio!;

    return Padding(
      padding: padding,
      child: Wrap(
        spacing: pad!,
        runSpacing: pad!,
        children: List.generate(
          categories!.length,
          (index) {
            return SizedBox(
              width: widthItem,
              height: heightItem,
              child: buildItem!(
                context,
                category: categories![index],
                width: widthItem,
                height: heightItem,
              ),
            );
          },
        ),
      ),
    );
  }
}
