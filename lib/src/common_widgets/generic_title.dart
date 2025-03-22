import 'package:flutter/material.dart';

import '../constants/_constants.dart';
import '../util/context_shortcut.dart';

class GenericTitle extends StatelessWidget {
  const GenericTitle({
    super.key,
    required this.title,
    this.icon,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.titleColor,
    this.iconColor,
    this.iconSize = 16,
  });

  final String title;
  final Color? titleColor;
  final Color? iconColor;
  final double iconSize;
  final IconData? icon;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        if (icon != null) Icon(icon, size: iconSize, color: iconColor),
        GAP_W8,
        Text(
          title,
          style: kTextStyle(context).bodyMedium?.copyWith(
                color: titleColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
