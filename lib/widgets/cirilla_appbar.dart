import 'package:flutter/material.dart';

class CirillaAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? child;
  final bool isScrolledToTop;
  final Color color;

  const CirillaAppbar({super.key, this.isScrolledToTop = false, this.child, this.color = Colors.transparent});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: isScrolledToTop ? color : Theme.of(context).appBarTheme.backgroundColor,
      duration: const Duration(milliseconds: 350),
      curve: Curves.linear,
      child: child,
    );
  }
}
