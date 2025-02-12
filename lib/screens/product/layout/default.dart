import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:flutter/material.dart';

class ProductLayoutDefault extends StatefulWidget {
  final ScrollController? controller;
  final bool isQuickView;
  final Product? product;
  final Widget? appbar;
  final Widget? bottomBar;
  final Widget? slideshow;
  final Widget? overlaySlideshow;
  final List<Widget>? productInfo;
  final bool? extendBodyBehindAppBar;

  final Widget? cartIcon;
  final String? cartIconType;
  final String? floatingActionButtonLocation;

  const ProductLayoutDefault({
    super.key,
    this.controller,
    this.isQuickView = false,
    this.product,
    this.appbar,
    this.bottomBar,
    this.slideshow,
    this.overlaySlideshow,
    this.productInfo,
    this.extendBodyBehindAppBar,
    this.cartIcon,
    this.cartIconType,
    this.floatingActionButtonLocation,
  });

  @override
  State<ProductLayoutDefault> createState() => _ProductLayoutDefaultState();
}

class _ProductLayoutDefaultState extends State<ProductLayoutDefault> with AppBarMixin, ScrollMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: ConvertData.floatingActionButtonLocation(widget.floatingActionButtonLocation),
      floatingActionButton: widget.cartIcon != null && widget.cartIconType == 'floating' ? widget.cartIcon : null,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar!,
      primary: true,
      bottomNavigationBar: widget.bottomBar,
      appBar: widget.appbar != null && !widget.isQuickView
          ? AppBar(
              automaticallyImplyLeading: false,
              title: widget.appbar,
              backgroundColor: isScrolledToTop ? Colors.transparent : Theme.of(context).appBarTheme.backgroundColor,
              shadowColor: isScrolledToTop ? Colors.transparent : Theme.of(context).appBarTheme.shadowColor,
              elevation: 1,
            )
          : null,
      body: CustomScrollView(
        controller: widget.controller,
        slivers: [
          if (widget.slideshow != null && !widget.isQuickView)
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  widget.slideshow!,
                  if (widget.overlaySlideshow != null)
                    Positioned.fill(
                      child: widget.overlaySlideshow!,
                    ),
                  if (widget.cartIcon != null && widget.cartIconType == 'pinned')
                    Positioned(bottom: 20, right: 20, child: widget.cartIcon!)
                ],
              ),
            ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return widget.productInfo![index];
              },
              childCount: widget.productInfo!.length,
            ),
          ),
        ],
      ),
    );
  }
}
