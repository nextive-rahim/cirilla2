import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/cirilla_html.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HtmlWidget extends StatefulWidget {
  final WidgetConfig? widgetConfig;

  const HtmlWidget({
    super.key,
    required this.widgetConfig,
  });

  @override
  State<HtmlWidget> createState() => _HtmlWidgetState();
}

class _HtmlWidgetState extends State<HtmlWidget> with Utility, ContainerMixin {
  @override
  Widget build(BuildContext context) {
    SettingStore settingStore = Provider.of<SettingStore>(context);
    String themeModeKey = settingStore.themeModeKey;

    // Styles
    Map<String, dynamic> styles = widget.widgetConfig?.styles ?? {};
    Map<String, dynamic>? margin = get(styles, ['margin'], {});
    Map<String, dynamic>? padding = get(styles, ['padding'], {});
    Map<String, dynamic>? background = get(styles, ['background', themeModeKey], {});
    // General config
    Map<String, dynamic> fields = widget.widgetConfig?.fields ?? {};
    String html = get(fields, ['html', settingStore.languageKey], '');

    return Container(
      margin: ConvertData.space(margin, 'margin'),
      padding: ConvertData.space(padding, 'padding'),
      decoration: decorationColorImage(
        color: ConvertData.fromRGBA(background, Colors.transparent),
      ),
      child: CirillaHtml(html: html),
    );
  }
}
