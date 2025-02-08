import 'package:cirilla/constants/styles.dart';
import 'package:flutter/material.dart';

class CirillaFixedBottom extends StatelessWidget {
  final Widget child;
  final Widget childBottom;
  final EdgeInsetsGeometry? paddingChildBottom;

  const CirillaFixedBottom({
    super.key,
    required this.child,
    required this.childBottom,
    this.paddingChildBottom,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: child,
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: paddingChildBottom ?? EdgeInsets.zero,
            child: childBottom,
          ),
        ),
      ],
    );
  }
}

class CirillaFixedBottomContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const CirillaFixedBottomContainer({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: theme.cardColor,
        boxShadow: initBoxShadow,
      ),
      child: child,
    );
  }
}
