import 'package:cipher_dove/src/core/_core.dart';
import 'package:cipher_dove/src/features/cipher/data/local/local_cipher_repo.dart';
import 'package:cipher_dove/src/features/cipher/presentation/cipher_mode_state.dart';
import 'package:cipher_dove/src/features/home/presentation/input_output_form_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../../common_widgets/custom_button.dart';
import '../../../../constants/_constants.dart';
import '../../../../util/context_shortcut.dart';

class ProcessButton extends ConsumerWidget {
  const ProcessButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomButton(
      onTap: () {
        final input = ref.read(inputTextFormStateProvider).text;
        final secret = ref.read(inputPasswordTextFormStateProvider).text;
        final cipherMode = ref.read(cipherModeStateProvider);
        // TODO use controller
        ref
            .read(localCipherRepositoryProvider)
            .encryptSymmetric(
              input,
              secret,
              algorithm: cipherMode.algorithm,
            )
            .then((value) {
          // Using notifier to also force update the corresponding widget.
          ref.read(outputTextFormStateProvider.notifier).text(value);
        });
      },
      buttonColor: PRIMARY_COLOR_D0,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_forward_rounded, size: 18, color: Colors.white),
          GAP_W4,
          Text(
            "Process",
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
