import 'package:flutter/material.dart';

class LoginScreenSocialTop extends StatelessWidget {
  final EdgeInsetsDirectional? padding;
  final EdgeInsetsDirectional? paddingFooter;
  final Widget? header;
  final Widget? loginForm;
  final Widget? socialLogin;
  final Widget? registerText;
  final Widget? termText;

  const LoginScreenSocialTop({
    super.key,
    this.header,
    this.loginForm,
    this.socialLogin,
    this.registerText,
    this.termText,
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
                    const SizedBox(height: 16),
                    termText!,
                    const SizedBox(height: 56),
                    loginForm!,
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ),
        if (registerText != null)
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: paddingFooter!,
                child: registerText,
              ),
            ),
          ),
      ],
    );
  }
}
