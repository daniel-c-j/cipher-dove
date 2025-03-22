import 'package:cipher_dove/src/features/cipher/data/cipher_algorithm_detail.dart';
import 'package:cipher_dove/src/features/cipher/domain/cipher_algorithm.dart';
import 'package:cipher_dove/src/features/cipher/presentation/cipher_algorithm/components/algorithm_selection_appbar.dart';
import 'package:flutter/material.dart';

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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("Results:"),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: kAlgorithms.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        kAlgorithms[index].name,
                        style: kTextStyle(context).titleSmall?.copyWith(
                              color: PRIMARY_COLOR_D0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      subtitle: Text(kAlgorithms[index].detail),
                      leading: Icon(switch (kAlgorithms[index].type) {
                        (CipherAlgorithmType.symmetric) => Icons.arrow_forward_rounded,
                        (CipherAlgorithmType.asymmetric) => Icons.swap_horiz_rounded,
                        (_) => Icons.tag_rounded,
                      }),
                      dense: true,
                      onTap: () {},
                    ),
                    const Divider(thickness: 0.75, height: 2.5),
                    if (index == kAlgorithms.length - 1) GAP_H64,
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
