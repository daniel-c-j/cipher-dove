import 'package:flutter/material.dart';

import '../constants/_constants.dart';
import '../util/context_shortcut.dart';

class GenericTitle extends StatelessWidget {
  const GenericTitle({super.key, required this.title, this.icon});

  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) Icon(icon, size: 16),
        GAP_W8,
        Text(
          title,
          style: kTextStyle(context).bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
