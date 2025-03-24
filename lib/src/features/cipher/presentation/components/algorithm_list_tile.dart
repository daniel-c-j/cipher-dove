import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../../constants/_constants.dart';
import '../../../../core/_core.dart';
import '../../../../util/context_shortcut.dart';
import '../../domain/cipher_action.dart';
import '../../domain/cipher_algorithm.dart';
import '../cipher_mode_state.dart';

class AlgorithmListTile extends ConsumerWidget {
  const AlgorithmListTile({super.key, required this.currentAlgorithm, required this.currentAlgType});

  final CipherAlgorithm currentAlgorithm;
  final CipherAlgorithmType currentAlgType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cipherMode = ref.watch(cipherModeStateProvider);
// TODO default set algorithm
    return Column(
      children: [
        GAP_H2,
        ListTile(
          title: Text(
            currentAlgorithm.name,
            style: kTextStyle(context).titleSmall?.copyWith(
                  color: PRIMARY_COLOR_L0,
                  fontWeight: FontWeight.bold,
                ),
          ),
          selected: cipherMode.algorithm == currentAlgorithm,
          selectedTileColor:
              (cipherMode.algorithm == currentAlgorithm) ? PRIMARY_COLOR_D0.withAlpha(50) : null,
          subtitle: Text(currentAlgorithm.detail),
          leading: Icon(currentAlgType.icon),
          tileColor: kColor(context).surfaceDim,
          dense: true,
          onTap: () {
            if (!currentAlgorithm.supported) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Sorry, not supported yet! :)"),
                  dismissDirection: DismissDirection.horizontal,
                ),
              );
              return;
            }

            ref.read(cipherModeStateProvider.notifier).mode = cipherMode.copyWith(
              algorithm: currentAlgorithm,
              // If hash, will always be encrypting.
              action: (currentAlgorithm.type == CipherAlgorithmType.hash) ? CipherAction.encrypt : null,
            );
          },
        ),
      ],
    );
  }
}
