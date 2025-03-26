import 'package:cipher_dove/src/common_widgets/hud_overlay.dart';
import 'package:cipher_dove/src/core/_core.dart';
import 'package:cipher_dove/src/features/cipher/presentation/cipher_output_controller.dart';
import 'package:cipher_dove/src/features/cipher/presentation/cipher_mode_state.dart';
import 'package:cipher_dove/src/features/home/presentation/input_output_form_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../../common_widgets/custom_button.dart';
import '../../../../constants/_constants.dart';
import '../../../../util/context_shortcut.dart';

/// Process button to start the operations and set the output value to the [OutputTextFormField].
class ProcessButton extends ConsumerWidget {
  const ProcessButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final output = ref.watch(cipherOutputControllerProvider);

    return CustomButton(
      msg: "Process".tr(),
      onTap: () async {
        // Flagging
        if (output.isLoading) return;

        final cipherMode = ref.read(cipherModeStateProvider);
        final input = ref.read(inputTextFormStateProvider).text;
        final secret = ref.read(inputPasswordTextFormStateProvider).text;

        if (input.isEmpty) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Input cannot be empty".tr()),
              dismissDirection: DismissDirection.horizontal,
            ),
          );
          return;
        }

        // Start operation.
        ref.read(showHudOverlayProvider.notifier).show(); // Shows overlay loading
        final outputValue = await ref.read(cipherOutputControllerProvider.notifier).process(
              input,
              secret,
              mode: cipherMode,
            );

        SchedulerBinding.instance.addPostFrameCallback((_) {
          // Using notifier to also force update the corresponding watching widget.
          ref
              .read(outputTextFormStateProvider.notifier)
              .text((output.hasError || outputValue.isEmpty) ? "Invalid".tr() : outputValue);
          ref.read(showHudOverlayProvider.notifier).hide(); // Hide overlay
        });
      },
      buttonColor: PRIMARY_COLOR_D0,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...(output.isLoading)
              ? const [
                  SizedBox.square(
                    dimension: 12,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  ),
                  GAP_W4,
                ]
              : const [Icon(Icons.arrow_forward_rounded, size: 18, color: Colors.white)],
          GAP_W4,
          Text(
            "Process".tr(),
            style: kTextStyle(context).bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}
