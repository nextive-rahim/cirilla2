import 'package:flutter/material.dart';

class ButtonSlidable extends StatelessWidget {
  final IconData icon;
  final Color? colorIcon;
  final VoidCallback onPressed;

  const ButtonSlidable({
    super.key,
    required this.icon,
    required this.onPressed,
    this.colorIcon,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: theme.colorScheme.surface,
          minimumSize: const Size(0, 0),
          shape: const RoundedRectangleBorder(),
        ),
        child: Icon(icon, size: 20, color: colorIcon ?? theme.primaryColor),
      ),
    );
  }
}
