import 'package:flutter/material.dart';

class CirillaPagination extends StatelessWidget {
  final int length;
  final int visit;
  final Color color;
  final Color colorActive;

  const CirillaPagination({
    super.key,
    this.length = 3,
    this.visit = 0,
    this.color = Colors.black,
    this.colorActive = Colors.black,
  })  : assert(length > 0),
        assert(visit >= 0);

  const factory CirillaPagination.vertical({
    Key? key,
    int? length,
    int? visit,
    Color? color,
    Color? colorActive,
  }) = _CirillaPaginationVertical;

  Widget buildDot() {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget buildActiveDot() {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: colorActive,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> dots = [];
    for (int i = 0; i < length; i++) {
      dots.add(Padding(
        padding: EdgeInsetsDirectional.only(end: i < length - 1 ? 9 : 0),
        child: i == visit ? buildActiveDot() : buildDot(),
      ));
    }
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: dots,
    );
  }
}

class _CirillaPaginationVertical extends CirillaPagination {
  const _CirillaPaginationVertical({
    super.key,
    int? length,
    int? visit,
    Color? color,
    Color? colorActive,
  }) : super(
          visit: visit ?? 0,
          length: length ?? 2,
          color: color ?? Colors.black,
          colorActive: colorActive ?? Colors.black,
        );

  @override
  Widget build(BuildContext context) {
    List<Widget> dots = [];
    for (int i = 0; i < length; i++) {
      dots.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.5),
        child: i == visit ? buildActiveDot() : buildDot(),
      ));
    }
    return Wrap(crossAxisAlignment: WrapCrossAlignment.center, direction: Axis.vertical, children: dots);
  }
}
