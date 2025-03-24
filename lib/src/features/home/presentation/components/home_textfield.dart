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
    this.onTap,
    this.suffix,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final bool readOnly;
  final int maxLines;
  final Widget? suffix;
  final bool obscureText;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: kTextStyle(context).bodySmall?.copyWith(height: 0),
      maxLines: maxLines,
      keyboardType: (maxLines > 1) ? TextInputType.multiline : null,
      readOnly: readOnly,
      autofocus: false,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(gapPadding: 0),
        hintText: hintText,
        hintStyle: kTextStyle(context).bodySmall?.copyWith(height: 0),
        labelText: labelText,
        labelStyle: kTextStyle(context).bodyMedium?.copyWith(height: 0, fontWeight: FontWeight.bold),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.only(top: 8, bottom: 8, right: 12, left: 12),
        isDense: true,
        suffix: suffix,
      ),
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}
