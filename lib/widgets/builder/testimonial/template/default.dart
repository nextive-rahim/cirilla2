import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class Default extends StatelessWidget with Utility {
  final Map<String, dynamic>? item;
  final ShapeBorder shape;
  final Color? color;
  final String languageKey;
  final String themeModeKey;
  final String imageKey;

  Default({
    super.key,
    required this.item,
    this.shape = const RoundedRectangleBorder(borderRadius: borderRadius),
    this.color,
    required this.languageKey,
    required this.themeModeKey,
    required this.imageKey,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    dynamic image = get(item, ['image'], {});

    dynamic title = get(item, ['title'], {});
    dynamic description = get(item, ['description'], {});

    String? linkImage = ConvertData.imageFromConfigs(image, imageKey);

    String textTitle = ConvertData.textFromConfigs(title, languageKey);
    String textDescription = ConvertData.textFromConfigs(description, languageKey);

    TextStyle titleStyle = ConvertData.toTextStyle(title, themeModeKey);
    TextStyle descriptionStyle = ConvertData.toTextStyle(description, themeModeKey);

    return TestimonialBasicItem(
      image: CirillaCacheImage(linkImage, width: 72, height: 72),
      title: Text(
        textTitle,
        style: theme.textTheme.bodyLarge?.merge(titleStyle),
      ),
      description: Text(
        textDescription,
        style: theme.textTheme.bodyLarge?.merge(descriptionStyle),
      ),
      width: 310,
      color: color,
      shape: shape,
    );
  }
}
