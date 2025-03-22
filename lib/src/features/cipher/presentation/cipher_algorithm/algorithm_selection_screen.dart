import 'package:cipher_dove/src/features/cipher/data/cipher_algorithm_detail.dart';
import 'package:cipher_dove/src/features/cipher/domain/cipher_algorithm.dart';
import 'package:cipher_dove/src/features/cipher/presentation/cipher_algorithm/components/algorithm_selection_appbar.dart';
import 'package:cipher_dove/src/features/cipher/presentation/cipher_mode_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/_constants.dart';
import '../../../../core/_core.dart';
import '../../../../util/context_shortcut.dart';

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
              itemBuilder: (context, index) {
                final content =
                    kAlgorithms.where((alg) => alg.type == CipherAlgorithmType.values[index]).toList();

                return Consumer(
                  builder: (context, ref, child) {
                    final cipherMode = ref.watch(cipherModeStateProvider);

                    return ExpansionTile(
                      title: kAlgorithmTags[index],
                      subtitle: (content.where((alg) => alg.algorithm == cipherMode.algorithm).isNotEmpty)
                          ? Text('Selected')
                          : null,
                      dense: true,
                      children: [
                        ListView.builder(
                          itemCount: content.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GAP_H2,
                                ListTile(
                                  title: Text(
                                    content[index].name,
                                    style: kTextStyle(context).titleSmall?.copyWith(
                                          color: PRIMARY_COLOR_L0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  selected: cipherMode.algorithm == content[index].algorithm,
                                  selectedTileColor: (cipherMode.algorithm == content[index].algorithm)
                                      ? PRIMARY_COLOR_D0.withAlpha(50)
                                      : null,
                                  subtitle: Text(content[index].detail),
                                  leading: Icon(switch (content[index].type) {
                                    (CipherAlgorithmType.symmetric) => Icons.arrow_forward_rounded,
                                    (CipherAlgorithmType.asymmetric) => Icons.swap_horiz_rounded,
                                    (_) => Icons.tag_rounded,
                                  }),
                                  tileColor: kColor(context).surfaceDim,
                                  dense: true,
                                  onTap: () {
                                    SchedulerBinding.instance.addPostFrameCallback((_) {
                                      ref.read(cipherModeStateProvider.notifier).mode =
                                          cipherMode.copyWith(algorithm: content[index].algorithm);
                                    });
                                  },
                                ),
                              ],
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
