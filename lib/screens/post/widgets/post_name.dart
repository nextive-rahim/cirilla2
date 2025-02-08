import 'package:cirilla/models/models.dart';
import 'package:flutter/material.dart';

class PostName extends StatelessWidget {
  final Post? post;
  final Color? color;

  const PostName({super.key, this.post, this.color});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Text(post!.postTitle!, style: theme.textTheme.titleLarge?.copyWith(color: color));
  }
}
