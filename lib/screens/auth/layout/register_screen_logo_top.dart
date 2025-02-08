import 'package:flutter/material.dart';

class RegisterScreenLogoTop extends StatelessWidget {
  final Widget? header;
  final Widget? registerForm;
  final Widget? socialLogin;
  final Widget? loginText;
  final EdgeInsetsDirectional? padding;
  final EdgeInsetsDirectional? paddingFooter;

  const RegisterScreenLogoTop({
    super.key,
    this.header,
    this.registerForm,
    this.socialLogin,
    this.loginText,
    this.padding,
    this.paddingFooter,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: padding!,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  children: [
                    header!,
                    const SizedBox(height: 64),
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
            alignment: Alignment.center,
            child: Padding(
              padding: paddingFooter!,
              child: loginText,
            ),
          ),
        ),
      ],
    );
  }
}
