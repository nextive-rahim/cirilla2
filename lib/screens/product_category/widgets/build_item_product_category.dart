import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/product_category/product_category.dart';
import 'package:cirilla/screens/product_list/product_list.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'child_category.dart';
import '../product_subcategory.dart';

/// The widget used return category item type
///
class BuildItemProductCategory extends StatefulWidget {
  // Index of category
  final int index;

  // Product category object
  final ProductCategory? category;

  // Text show at name product
  final String? textName;

  // Template of items
  final Map<String, dynamic>? template;

  // styles of item
  final Map<String, dynamic>? styles;

  // Item width
  final double? widthItem;

  // Item height
  final double? heightItem;

  // Key set theme darkmode
  final String? themeModeKey;

  const BuildItemProductCategory({
    super.key,
    required this.index,
    required this.category,
    this.widthItem,
    this.heightItem,
    this.template = const {},
    this.styles = const {},
    this.textName,
    this.themeModeKey = 'value',
  });

  @override
  State<BuildItemProductCategory> createState() => _BuildItemProductCategoryState();
}

class _BuildItemProductCategoryState extends State<BuildItemProductCategory> with CategoryMixin, TransitionMixin {
  void onClick(BuildContext context, bool enableSubCategory) async {
    if (enableSubCategory) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, __) => ProductSubcategoryScreen(
            category: widget.category,
            parentWidget: buildItem(context, enableNavigate: true),
          ),
          transitionsBuilder: slideTransition,
        ),
      );
    } else {
      navigate(context);
    }
  }

  void navigate(BuildContext context) {
    Navigator.pushNamed(context, ProductListScreen.routeName, arguments: {'category': widget.category});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.widthItem,
      child: buildItem(context, textName: widget.textName),
    );
  }

  /// Build category child level 3
  Widget buildChildren(
    BuildContext context, {
    int? col,
    int? maxCountChildren,
    Map<String, dynamic>? template,
    Map<String, dynamic>? configs,
  }) {
    return ChildCategory(
      parent: widget.category,
      template: template,
      styles: configs,
      col: col,
      perPage: maxCountChildren,
      themeModeKey: widget.themeModeKey,
    );
  }

  Widget buildItem(
    BuildContext context, {
    bool enableNavigate = false,
    String? textName,
  }) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    // setting styles
    Color background =
        ConvertData.fromRGBA(get(widget.styles, ['backgroundItem', widget.themeModeKey], {}), theme.cardColor);
    double? sizeText = ConvertData.stringToDouble(get(widget.styles, ['sizeText'], 16));
    Color textColor = ConvertData.fromRGBA(get(widget.styles, ['textColor', widget.themeModeKey], {}), Colors.white);
    double? sizeSubtext = ConvertData.stringToDouble(get(widget.styles, ['sizeSubtext'], 12));
    Color subtextColor =
        ConvertData.fromRGBA(get(widget.styles, ['subtextColor', widget.themeModeKey], {}), Colors.white);
    double? radiusItem = ConvertData.stringToDouble(get(widget.styles, ['radiusItem'], 8));
    double? radiusImage = ConvertData.stringToDouble(get(widget.styles, ['radiusImage'], 0));

    String? typeTemplate = get(widget.template, ['template'], Strings.productCategoryItemHorizontal);
    Map<String, dynamic>? dataTemplate = get(widget.template, ['data'], {});
    String? thumbSizes = get(dataTemplate, ['thumbSizes'], 'src');

    bool enableSubcategories = get(dataTemplate, ['enableSubcategories'], true);

    bool isSubcategory = widget.category?.categories?.isNotEmpty == true;
    bool isCheckSubcategoryScreen = enableNavigate ? false : isSubcategory && enableSubcategories;

    switch (typeTemplate) {
      case Strings.productCategoryItemCard:
        // setting template
        bool enableImage = get(dataTemplate, ['enableImage'], true);
        bool enableNumber = get(dataTemplate, ['enableNumber'], true);
        bool? enableRound = get(dataTemplate, ['enableRound'], true);
        bool enableShadow = get(dataTemplate, ['enableShadow'], false);
        bool enableBorder = get(dataTemplate, ['enableBorder'], false);
        Color borderColor =
            ConvertData.fromRGBA(get(dataTemplate, ['borderColor', widget.themeModeKey], {}), Colors.white);

        // size image
        double size = widget.heightItem is double && widget.heightItem! < 60 ? widget.heightItem! : 60;

        double padVertical = size < 60
            ? 0
            : widget.heightItem is! double
                ? 16
                : (widget.heightItem! - size) / 2;

        return ProductCategoryCardItem(
          image: enableImage
              ? buildImage(
                  category: widget.category!,
                  width: size,
                  height: size,
                  radius: radiusImage,
                  enableRoundImage: enableRound,
                  sizes: thumbSizes,
                )
              : null,
          name: buildNameProduct(
            textName: textName,
            nameStyle: theme.textTheme.titleMedium?.copyWith(fontSize: sizeText, color: textColor),
          ),
          count: enableNumber
              ? buildCount(
                  category: widget.category,
                  style: theme.textTheme.bodySmall?.copyWith(fontSize: sizeSubtext, color: subtextColor),
                  translate: translate,
                )
              : null,
          padding: EdgeInsets.symmetric(horizontal: itemPaddingMedium, vertical: padVertical),
          color: background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusItem),
            side: enableBorder ? BorderSide(width: 1, color: borderColor) : BorderSide.none,
          ),
          elevation: enableShadow ? 5 : 0,
          onClick: () => onClick(context, isCheckSubcategoryScreen),
        );
      case Strings.productCategoryItemOverlay:
        // setting template
        bool enableNumber = get(dataTemplate, ['enableNumber'], true);
        TextAlign alignment = ConvertData.toTextAlignDirection(get(dataTemplate, ['alignment'], 'center'));
        Color opacityColor =
            ConvertData.fromRGBA(get(dataTemplate, ['opacityColor', widget.themeModeKey], {}), Colors.black);
        double opacity = ConvertData.stringToDouble(get(dataTemplate, ['opacity'], 0.5));

        // size image
        double? widthImage = widget.widthItem;
        double? heightImage = widget.heightItem ?? widthImage;
        return ProductCategoryOverlayItem(
          image: buildImage(
            category: widget.category!,
            width: widthImage,
            height: heightImage,
            radius: radiusImage,
            sizes: thumbSizes,
          ),
          name: buildNameProduct(
            nameStyle: theme.textTheme.titleMedium?.copyWith(fontSize: sizeText, color: textColor),
            textAlign: alignment,
            textName: textName,
          ),
          count: enableNumber
              ? buildCount(
                  category: widget.category,
                  style: theme.textTheme.bodySmall?.copyWith(fontSize: sizeSubtext, color: subtextColor),
                  textAlign: alignment,
                  translate: translate,
                )
              : null,
          opacityColor: opacityColor,
          opacity: opacity,
          borderRadius: BorderRadius.circular(radiusItem),
          onClick: () => onClick(context, isCheckSubcategoryScreen),
        );
      case Strings.productCategoryItemContained:
        // setting template
        bool enableImage = get(dataTemplate, ['enableImage'], true);
        bool enableNumber = get(dataTemplate, ['enableNumber'], true);
        bool? enableRound = get(dataTemplate, ['enableRound'], false);
        bool? enableBorder = get(dataTemplate, ['enableBorder'], true);
        Color borderColor =
            ConvertData.fromRGBA(get(dataTemplate, ['borderColor', widget.themeModeKey], {}), theme.dividerColor);

        // size image
        double sizeImage = widget.widthItem!;

        return ProductCategoryContainedItem(
          image: enableImage
              ? buildImage(
                  category: widget.category!,
                  width: sizeImage,
                  height: sizeImage,
                  radius: radiusImage,
                  borderStyle: enableBorder! ? 'solid' : 'none',
                  borderColor: borderColor,
                  enableRoundImage: enableRound,
                  sizes: thumbSizes,
                )
              : null,
          name: buildNameProduct(
            nameStyle: theme.textTheme.titleMedium?.copyWith(fontSize: sizeText, color: textColor),
            textAlign: TextAlign.center,
            textName: textName,
          ),
          count: enableNumber
              ? buildCount(
                  category: widget.category,
                  style: theme.textTheme.bodySmall?.copyWith(fontSize: sizeSubtext, color: subtextColor),
                  textAlign: TextAlign.center,
                  translate: translate,
                )
              : null,
          width: sizeImage,
          onClick: () => onClick(context, isCheckSubcategoryScreen),
        );
      case Strings.productCategoryItemGrid:
        // setting template
        bool enableNumber = get(dataTemplate, ['enableNumber'], true);
        // item sub category
        int countSubcategory = ConvertData.stringToInt(get(dataTemplate, ['maxCountSubcategory'], 6));
        int colSubcategory = ConvertData.stringToInt(get(dataTemplate, ['columnSubcategory'], 3));

        Map<String, dynamic> dataTemplateSubcategory = {
          'enableSubcategories': false,
          'enableImage': true,
          'enableNumber': false,
          'enableRound': get(dataTemplate, ['enableRoundSubcategory'], false),
          'enableBorder': get(dataTemplate, ['enableBorderSubcategory'], true),
          'borderColor': get(dataTemplate, ['borderColorSubCategory'], {}),
        };
        Map<String, dynamic> stylesSubCategory = {
          'backgroundItem': {
            'dark': {'r': 255, 'g': 255, 'b': 255, 'a': 0},
            'value': {'r': 255, 'g': 255, 'b': 255, 'a': 0},
          },
          'radiusItem': 0,
          'radiusImage': get(dataTemplate, ['radiusSubCategory'], 8),
          'sizeText': get(dataTemplate, ['sizeSubcategory'], 12),
          'textColor': get(dataTemplate, ['textColorSubcategory'], {}),
        };
        return ProductCategoryGridItem(
          name: buildNameProduct(
            nameStyle: theme.textTheme.titleMedium?.copyWith(fontSize: sizeText, color: textColor),
            countStyle: theme.textTheme.bodySmall?.copyWith(fontSize: sizeSubtext, color: subtextColor) ??
                TextStyle(fontSize: sizeSubtext, color: subtextColor),
            showCount: enableNumber,
            textName: textName,
          ),
          action: InkWell(
            onTap: () => navigate(context),
            child: Text(
              translate('product_category_show_all'),
              style: theme.textTheme.bodySmall?.copyWith(fontSize: sizeSubtext, color: subtextColor),
            ),
          ),
          color: background,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusItem)),
          child: enableSubcategories && widget.category!.categories!.isNotEmpty
              ? buildChildren(
                  context,
                  col: colSubcategory,
                  maxCountChildren: countSubcategory,
                  template: {
                    'template': Strings.productCategoryItemContained,
                    'data': dataTemplateSubcategory,
                  },
                  configs: stylesSubCategory,
                )
              : null,
        );
      case Strings.productCategoryItemBasic:
        // setting template

        bool enableNumber = get(dataTemplate, ['enableNumber'], true);
        bool enableIcon = get(dataTemplate, ['enableIcon'], false);
        bool enableBorder = get(dataTemplate, ['enableBorder'], true);
        Color borderColor =
            ConvertData.fromRGBA(get(dataTemplate, ['borderColor', widget.themeModeKey], {}), theme.dividerColor);
        double? iconSize = ConvertData.stringToDouble(get(dataTemplate, ['iconSize'], 14));
        Color iconColor =
            ConvertData.fromRGBA(get(dataTemplate, ['iconColor', widget.themeModeKey], {}), theme.iconTheme.color);

        return ProductCategoryBasicItem(
          name: buildNameProduct(
            nameStyle: theme.textTheme.titleMedium?.copyWith(fontSize: sizeText, color: textColor),
            countStyle: theme.textTheme.bodySmall?.copyWith(fontSize: sizeSubtext, color: subtextColor) ??
                TextStyle(fontSize: sizeSubtext, color: subtextColor),
            showCount: enableNumber,
            textName: textName,
          ),
          border: enableBorder ? Border(bottom: BorderSide(width: 1, color: borderColor)) : null,
          icon: enableIcon ? Icon(FeatherIcons.chevronRight, size: iconSize, color: iconColor) : null,
          height: widget.heightItem ?? 58,
          color: background,
          padding: paddingVerticalSmall,
          onClick: () => onClick(context, isCheckSubcategoryScreen),
        );
      case Strings.productCategoryItemHorizontalOver:
        bool enableImage = get(dataTemplate, ['enableImage'], true);
        String alignmentView = get(dataTemplate, ['alignmentView'], 'left');
        bool enableNumber = get(dataTemplate, ['enableNumber'], true);
        bool enableShadow = get(dataTemplate, ['enableShadow'], false);
        bool enableBorder = get(dataTemplate, ['enableBorder'], false);
        Color borderColor =
            ConvertData.fromRGBA(get(dataTemplate, ['borderColor', widget.themeModeKey], {}), Colors.white);

        // size image
        double widthImage = widget.widthItem is double && widget.widthItem! / 2 < 120 ? widget.widthItem! / 2 : 120;
        double heightImage = widget.heightItem is double && widget.heightItem! < 92 ? widget.heightItem! : 92;

        bool enableEndImage = alignmentView == 'right' || (alignmentView == 'zigzag' && widget.index % 2 == 1);

        return ProductCategoryHorizontalOverItem(
          image: enableImage
              ? buildImage(
                  category: widget.category!,
                  width: widthImage,
                  height: heightImage,
                  radius: radiusImage,
                  sizes: thumbSizes,
                )
              : null,
          name: buildNameProduct(
            textName: textName,
            nameStyle: theme.textTheme.titleMedium?.copyWith(fontSize: sizeText, color: textColor),
          ),
          count: enableNumber
              ? buildCount(
                  category: widget.category,
                  style: theme.textTheme.bodySmall?.copyWith(fontSize: sizeSubtext, color: subtextColor),
                  translate: translate,
                )
              : null,
          widthImage: widthImage,
          heightImage: heightImage,
          enableEndImage: enableEndImage,
          color: background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusItem),
            side: enableBorder ? BorderSide(width: 1, color: borderColor) : BorderSide.none,
          ),
          elevation: enableShadow ? 5 : 0,
          onClick: () => onClick(context, isCheckSubcategoryScreen),
        );
      default:
        // setting template

        bool enableImage = get(dataTemplate, ['enableImage'], true);
        bool enableNumber = get(dataTemplate, ['enableNumber'], true);
        bool enableShadow = get(dataTemplate, ['enableShadow'], false);
        bool enableBorder = get(dataTemplate, ['enableBorder'], false);
        Color borderColor =
            ConvertData.fromRGBA(get(dataTemplate, ['borderColor', widget.themeModeKey], {}), Colors.white);

        // size image
        double widthImage = widget.widthItem is double && widget.widthItem! / 2 < 92 ? widget.widthItem! / 2 : 92;
        double? heightImage = widget.heightItem is double && widget.heightItem! < 92 ? widget.heightItem : 92;

        return ProductCategoryHorizontalItem(
          image: enableImage
              ? buildImage(
                  category: widget.category!,
                  width: widthImage,
                  height: heightImage,
                  radius: radiusImage,
                  sizes: thumbSizes,
                )
              : null,
          name: buildNameProduct(
            textName: textName,
            nameStyle: theme.textTheme.titleMedium?.copyWith(fontSize: sizeText, color: textColor) ??
                TextStyle(fontSize: sizeText, color: textColor),
          ),
          count: enableNumber
              ? buildCount(
                  category: widget.category,
                  style: theme.textTheme.bodySmall?.copyWith(fontSize: sizeSubtext, color: subtextColor),
                  translate: translate,
                )
              : null,
          color: background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusItem),
            side: enableBorder ? BorderSide(width: 1, color: borderColor) : BorderSide.none,
          ),
          elevation: enableShadow ? 5 : 0,
          onClick: () => onClick(context, isCheckSubcategoryScreen),
        );
    }
  }

  Widget buildNameProduct(
      {TextStyle? nameStyle,
      TextStyle? countStyle,
      bool showCount = false,
      TextAlign textAlign = TextAlign.start,
      String? textName}) {
    if (showCount) {
      return RichText(
        text: TextSpan(
          style: nameStyle,
          text: textName ?? widget.category!.name,
          children: [
            const TextSpan(text: ' '),
            TextSpan(
              text: '(${widget.category!.count})',
              style: countStyle,
            )
          ],
        ),
      );
    }
    return Text(textName ?? widget.category!.name!, style: nameStyle, textAlign: textAlign);
  }
}
