import 'package:cipher_dove/src/features/home/presentation/input_output_form_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../../../common_widgets/custom_button.dart';
import '../../../../../util/context_shortcut.dart';

/// Used to only just change the value of input text controller with output
/// text controller's value.
class SwapIconButton extends ConsumerWidget {
  const SwapIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomButton(
      msg: "Set Output to Input".tr(),
      padding: const EdgeInsets.all(4),
      buttonColor: Colors.transparent,
      borderRadius: BorderRadius.circular(60),
      onTap: () {
        final output = ref.watch(outputTextFormStateProvider);
        if (output.text.isEmpty) return;

        ref.read(inputTextFormStateProvider).text = output.text;
        ref.read(outputTextFormStateProvider.notifier).clear();
      },
      child: Icon(
        Icons.arrow_circle_up_rounded,
        size: 22.5,
        color: kColor(context).inverseSurface,
      ),
    );
  }
}
