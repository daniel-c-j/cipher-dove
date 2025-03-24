import 'package:flutter/material.dart';

import '../../../../util/context_shortcut.dart';

class HomeTextfield extends StatelessWidget {
  const HomeTextfield({
    super.key,
    this.hintText,
    this.labelText,
    required this.maxLines,
    required this.readOnly,
    required this.controller,
    this.onChanged,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final bool readOnly;
  final int maxLines;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: kTextStyle(context).bodySmall,
      maxLines: maxLines,
      keyboardType: (maxLines > 1) ? TextInputType.multiline : null,
      readOnly: readOnly,
      autofocus: false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(gapPadding: 0),
        hintText: hintText,
        hintStyle: kTextStyle(context).bodySmall,
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.only(top: 8, bottom: 8, right: 12, left: 12),
        isDense: true,
      ),
      onChanged: onChanged,
    );
  }
}
