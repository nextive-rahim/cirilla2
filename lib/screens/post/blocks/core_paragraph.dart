import 'package:cirilla/constants/styles.dart';
import 'package:cirilla/mixins/utility_mixin.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';

import 'html_text.dart';

Map<String, Style> styleBlog({String align = 'left', double fontSize = 15}) {
  return {
    'html': Style(
      margin: Margins.zero,
      padding: HtmlPaddings.zero,
    ),
    'body': Style(
      margin: Margins.zero,
      padding: HtmlPaddings.zero,
    ),
    'p': Style(
      lineHeight: const LineHeight(1.8),
      fontSize: FontSize(fontSize),
      padding: HtmlPaddings.zero,
      textAlign: ConvertData.toTextAlignDirection(align),
    ),
    'div': Style(
      lineHeight: const LineHeight(1.8),
      fontSize: FontSize(fontSize),
      margin: Margins.zero,
      padding: HtmlPaddings.zero,
    ),
    'img': Style(
      padding: HtmlPaddings.symmetric(vertical: itemPadding),
    )
  };
}

class Paragraph extends StatelessWidget with Utility {
  final Map<String, dynamic>? block;

  final String? alignCover;

  const Paragraph({super.key, this.block, this.alignCover});

  @override
  Widget build(BuildContext context) {
    Map attrs = get(block, ['attrs'], {}) is Map ? get(block, ['attrs'], {}) : {};

    String alignCover = attrs['align'] ?? '';

    Map? style = get(attrs, ['style'], {}) is Map ? get(attrs, ['style'], {}) : {};

    int fontSize = get(style, ['typography', 'fontSize'], 15);

    return HtmlText(
      text: '${block!['innerHTML']}',
      fontSize: fontSize.toDouble(),
      textAlign: ConvertData.toTextAlignDirection(alignCover),
    );
  }
}
