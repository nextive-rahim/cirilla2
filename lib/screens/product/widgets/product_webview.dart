import 'dart:async';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/product/product.dart';
import 'package:cirilla/webview_flutter.dart';
import 'package:cirilla/widgets/cirilla_webview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cirilla/store/auth/auth_store.dart';

import 'product_advanced_custom_field.dart';

class ProductWebView extends StatefulWidget {
  final Product? product;
  final String? url;
  final bool? syncAuth;
  final EdgeInsetsDirectional padding;
  final double? height;

  const ProductWebView({
    super.key,
    this.product,
    this.url,
    this.syncAuth,
    this.padding = EdgeInsetsDirectional.zero,
    this.height,
  });

  @override
  ProductWebViewState createState() => ProductWebViewState();
}

class ProductWebViewState extends State<ProductWebView> with LoadingMixin {
  late AuthStore _authStore;
  final Completer<WebViewController> controller = Completer<WebViewController>();

  @override
  void didChangeDependencies() {
    _authStore = Provider.of<AuthStore>(context);
    super.didChangeDependencies();
  }

  String urlMerge(String url) {
    String newUrl = url;
    if (url.contains('{') && url.contains('}')) {
      Map acfs = getACFields(widget.product);
      for (String key in acfs.keys) {
        newUrl = newUrl.replaceAll('{$key}', '${get(acfs[key], ['value'], '')}');
      }
    }
    return newUrl;
  }

  @override
  Widget build(BuildContext context) {
    bool hasQuery = widget.url?.contains('?') == true;

    String url =
        urlMerge('${widget.url}${hasQuery ? '&' : '?'}url=${widget.product?.permalink}&app-builder-decode=true');
    Map<String, String> headers = {};

    if (_authStore.isLogin && widget.syncAuth == true) {
      headers = {"Authorization": "Bearer ${_authStore.token!}"};
    }

    return Visibility(
      visible: widget.url != '',
      child: Container(
        height: widget.height,
        padding: EdgeInsets.only(top: widget.padding.top, bottom: widget.padding.bottom),
        child: CirillaWebView(
          /// CookieManager
          uri: Uri.parse(url),
          headers: headers,
          loading: entryLoading(context),
        ),
      ),
    );
  }
}
