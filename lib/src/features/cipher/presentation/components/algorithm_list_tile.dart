import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../../common_widgets/custom_button.dart';
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
          subtitle: Text(currentAlgorithm.detail),
          selected: cipherMode.algorithm == currentAlgorithm,
          selectedTileColor:
              (cipherMode.algorithm == currentAlgorithm) ? PRIMARY_COLOR_D0.withAlpha(50) : null,
          leading: Icon(currentAlgType.icon),
          trailing: AlgorithmListTileTrailing(currentAlgorithm: currentAlgorithm),
          tileColor: kColor(context).surfaceDim,
          dense: true,
          onTap: () {
            if (!currentAlgorithm.supported) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Sorry, not supported yet! :)".tr()),
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

class AlgorithmListTileTrailing extends ConsumerWidget {
  const AlgorithmListTileTrailing({super.key, required this.currentAlgorithm});
  final CipherAlgorithm currentAlgorithm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(cipherModeStateProvider.notifier).getDefault(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.star_border_rounded, size: 20),
          );
        }

        final defaultCipherMode = snapshot.data;

        return CustomButton(
          msg: "Set to default",
          buttonColor: Colors.transparent,
          padding: EdgeInsets.all(5),
          borderRadius: BorderRadius.circular(60),
          onTap: () async {
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

            if (defaultCipherMode == currentAlgorithm) return;

            // Set to default
            await ref.read(cipherModeStateProvider.notifier).setDefault(currentAlgorithm);
            ref.invalidate(cipherModeStateProvider);
          },
          child: Icon(
            (defaultCipherMode == currentAlgorithm) ? Icons.star_rounded : Icons.star_border_rounded,
            size: 20,
          ),
        );
      },
    );
  }
}
