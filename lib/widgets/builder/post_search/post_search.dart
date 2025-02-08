import 'package:cirilla/models/setting/setting.dart';
import 'package:cirilla/widgets/builder/product_search/search_widget.dart';
import 'package:flutter/material.dart';

class PostSearchWidget extends SearchWidget {
  final WidgetConfig widgetConfig;
  const PostSearchWidget({
    super.key,
    required this.widgetConfig,
  }) : super(
          widgetConfigData: widgetConfig,
          typePost: true,
        );
}