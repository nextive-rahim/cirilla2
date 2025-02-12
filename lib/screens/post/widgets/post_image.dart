import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/cirilla_cache_image.dart';
import 'package:flutter/material.dart';

class PostImage extends StatelessWidget with Utility {
  final Post? post;
  final double? width;
  final double? height;
  final Map<String, dynamic>? styles;

  const PostImage({super.key, this.post, this.width, this.height, this.styles});

  @override
  Widget build(BuildContext context) {
    String image = post?.image ?? '';
    BoxFit boxFit = BoxFit.cover;
    if (styles?.isNotEmpty == true) {
      String thumbSizes = get(styles, ['thumbSizes'], 'shop_catalog');
      String fit = get(styles, ['imageSize'], 'cover');
      image = get(post?.images, [thumbSizes], '');
      boxFit = ConvertData.toBoxFit(fit);
    }

    return CirillaCacheImage(
      image,
      width: width,
      height: height,
      fit: boxFit,
    );
  }
}
