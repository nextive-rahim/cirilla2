import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpacerWidget extends StatelessWidget with Utility, ContainerMixin {
  final WidgetConfig? widgetConfig;

  SpacerWidget({
    super.key,
    required this.widgetConfig,
  });

  @override
  Widget build(BuildContext context) {
    SettingStore settingStore = Provider.of<SettingStore>(context);
    String themeModeKey = settingStore.themeModeKey;

    // Styles
    Map<String, dynamic> styles = widgetConfig?.styles ?? {};
    Map<String, dynamic>? margin = get(styles, ['margin'], {});
    Map<String, dynamic>? padding = get(styles, ['padding'], {});
    Map? background = get(styles, ['backgroundColor', themeModeKey], {});

    Color backgroundColor = ConvertData.fromRGBA(background, Colors.transparent);

    double? height = ConvertData.stringToDouble(get(widgetConfig!.fields, ['height'], 0));

    return Container(
      height: height,
      margin: ConvertData.space(margin, 'margin'),
      padding: ConvertData.space(padding, 'padding'),
      decoration: decorationColorImage(color: backgroundColor),
    );
  }
}
