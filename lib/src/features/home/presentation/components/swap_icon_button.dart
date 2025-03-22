import 'package:flutter/material.dart';

import '../../../../common_widgets/custom_button.dart';
import '../../../../util/context_shortcut.dart';

/// Used to only just change the value of input text controller with output
/// text controller's value.
class SwapIconButton extends StatelessWidget {
  const SwapIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      msg: "Set Output to Input",
      padding: const EdgeInsets.all(4),
      buttonColor: Colors.transparent,
      borderRadius: BorderRadius.circular(60),
      onTap: () {},
      child: Icon(
        Icons.arrow_circle_up_rounded,
        size: 22.5,
        color: kColor(context).inverseSurface,
      ),
    );
  }
}
