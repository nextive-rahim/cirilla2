import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:ui/paths/curve_convex.dart';

class RegisterScreenImageHeaderConner extends StatelessWidget {
  final Widget? header;
  final Widget? registerForm;
  final Widget? socialLogin;
  final Widget? loginText;
  final Widget? title;
  final Color? background;
  final EdgeInsetsDirectional? padding;
  final EdgeInsetsDirectional? paddingFooter;

  const RegisterScreenImageHeaderConner({
    super.key,
    this.header,
    this.registerForm,
    this.socialLogin,
    this.loginText,
    this.title,
    this.background,
    this.padding,
    this.paddingFooter,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double heightHeader = height * 0.3;

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: heightHeader,
          automaticallyImplyLeading: false,
          primary: false,
          backgroundColor: background,
          flexibleSpace: Stack(
            children: [
              SizedBox(
                height: heightHeader,
                width: width,
                child: header,
              ),
              Positioned(
                bottom: -1,
                left: 0,
                right: 0,
                child: Transform.rotate(
                  angle: -math.pi,
                  child: ClipPath(
                    clipper: CurveInConvex(),
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      color: background,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: padding!,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  children: [
                    title!,
                    const SizedBox(height: 24),
                    registerForm!,
                    const SizedBox(height: 32),
                    socialLogin!,
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          fillOverscroll: true,
          child: Container(
            padding: paddingFooter,
            alignment: Alignment.center,
            child: loginText,
          ),
        ),
      ],
    );
  }
}
