import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:flutter/material.dart';

class PostCommentCount extends StatelessWidget with PostMixin {
  final Post? post;
  final Color? color;

  PostCommentCount({super.key, this.post, this.color});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return buildComment(theme, post!, color);
  }
}
