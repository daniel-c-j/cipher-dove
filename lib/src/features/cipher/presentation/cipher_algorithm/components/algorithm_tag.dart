import 'package:flutter/material.dart';

import '../../../../../constants/_constants.dart';
import '../../../../../core/_core.dart';
import '../../../../../util/context_shortcut.dart';

class AlgorithmTag extends StatelessWidget {
  const AlgorithmTag({super.key, required this.tag, required this.icon});

  final String tag;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: PRIMARY_COLOR_L0,
            borderRadius: BorderRadius.circular(60),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(
              icon,
              size: 16,
              color: kColor(context).inverseSurface,
            ),
          ),
        ),
        GAP_W8,
        Text(
          tag,
          style: kTextStyle(context).bodyMedium?.copyWith(
                height: 0,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
