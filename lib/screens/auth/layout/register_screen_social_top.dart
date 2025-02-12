import 'package:flutter/material.dart';

class RegisterScreenSocialTop extends StatelessWidget {
  final EdgeInsetsDirectional? padding;
  final EdgeInsetsDirectional? paddingFooter;
  final Widget? header;
  final Widget? registerForm;
  final Widget? socialLogin;
  final Widget? loginText;

  const RegisterScreenSocialTop({
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
                    const SizedBox(height: 24),
                    socialLogin!,
                    const SizedBox(height: 56),
                    registerForm!,
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
