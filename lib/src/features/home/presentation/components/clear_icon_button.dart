import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../common_widgets/custom_button.dart';
import '../../../../util/context_shortcut.dart';

/// Used to only just clean the value of input text controller.
class ClearIconButton extends StatelessWidget {
  const ClearIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      msg: "Remove all Input",
      padding: const EdgeInsets.all(4),
      buttonColor: Colors.transparent,
      borderRadius: BorderRadius.circular(60),
      onTap: () {},
      child: Icon(
        BoxIcons.bxs_eraser,
        size: 20.5,
        color: kColor(context).inverseSurface,
      ),
    );
  }
}
