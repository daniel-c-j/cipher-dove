import 'package:cipher_dove/src/features/cipher/domain/cipher_algorithm.dart';
import 'package:cipher_dove/src/features/cipher/presentation/components/algorithm_list_tile.dart';
import 'package:cipher_dove/src/features/cipher/presentation/components/algorithm_selection_appbar.dart';
import 'package:cipher_dove/src/features/cipher/presentation/cipher_mode_state.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../util/context_shortcut.dart';
import 'components/algorithm_tag.dart';

/// A screen widget for user to pick their Cipher operations.
class AlgorithmSelectionScreen extends StatelessWidget {
  const AlgorithmSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColor(context).surface,
      appBar: const AlgorithmSelectionAppBar(),
      body: Column(
        children: [
          const Divider(height: 0.5, thickness: 0.5),
          Flexible(
            child: ListView.builder(
              itemCount: CipherAlgorithmType.values.length,
              itemBuilder: (context, idx) {
                // Sort the types
                final currentAlgType = CipherAlgorithmType.values[idx];
                final content = CipherAlgorithm.get(currentAlgType);

                return Consumer(
                  builder: (context, ref, child) {
                    final cipherMode = ref.watch(cipherModeStateProvider);

                    return ExpansionTile(
                      title: AlgorithmTag(type: CipherAlgorithmType.values[idx]),
                      subtitle: (content.firstWhereOrNull((alg) => alg == cipherMode.algorithm) != null)
                          ? Text(
                              '(Selected)'.tr(),
                              style: kTextStyle(context).bodySmall,
                            )
                          : null,
                      dense: true,
                      children: [
                        ListView.builder(
                          itemCount: content.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final currentAlgorithm = content[index];

                            return AlgorithmListTile(
                              currentAlgorithm: currentAlgorithm,
                              currentAlgType: currentAlgType,
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
