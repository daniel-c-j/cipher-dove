import 'package:flutter/material.dart';

import '../../../../util/context_shortcut.dart';

class HomeTextfield extends StatelessWidget {
  const HomeTextfield({super.key, this.hintText, required this.maxLines});

  final String? hintText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: kTextStyle(context).bodySmall,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: const OutlineInputBorder(gapPadding: 0),
        hintText: hintText,
        hintStyle: kTextStyle(context).bodySmall,
        contentPadding: const EdgeInsets.only(top: 8, bottom: 8, right: 12, left: 12),
        isDense: true,
      ),
    );
  }
}
