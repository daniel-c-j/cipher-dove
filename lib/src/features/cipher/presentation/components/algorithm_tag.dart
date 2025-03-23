import 'package:flutter/material.dart';

import '../../../../constants/_constants.dart';
import '../../../../core/_core.dart';
import '../../../../util/context_shortcut.dart';
import '../../domain/cipher_algorithm.dart';

// TODO documentation
// TODO test
// TODO imports like above.
// TODO ReadME
// TODO logo
// TODO version check
// TODO Code-Review
class AlgorithmTag extends StatelessWidget {
  const AlgorithmTag({super.key, required this.type});

  final CipherAlgorithmType type;

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
              type.icon,
              size: 16,
              color: kColor(context).inverseSurface,
            ),
          ),
        ),
        GAP_W8,
        Text(
          type.tag,
          style: kTextStyle(context).bodyMedium?.copyWith(
                height: 0,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
