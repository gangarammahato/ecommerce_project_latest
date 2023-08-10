import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Widget? child;
  final String? image;
  final IconData? icon;
  final Color colors;
  final Color? iconColor;
  final double iconSize;
  final double horizontalPadding;
  final void Function()? onPressed;
  const CustomIconButton({
    super.key,
    required this.colors,
    this.icon,
    this.onPressed,
    this.iconColor,
    this.iconSize = 100,
    this.horizontalPadding = 8,
    this.child,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Material(
        color: colors,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: iconSize,
              color: iconColor ?? Colors.grey.shade100,
            ),
          ),
        ),
      ),
    );
  }
}
