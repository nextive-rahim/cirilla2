import 'package:flutter/material.dart';

abstract mixin class ShapeMixin {
  ShapeBorder borderRadiusTop({double radius = 20}) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(radius), topRight: Radius.circular(radius)),
    );
  }
}
