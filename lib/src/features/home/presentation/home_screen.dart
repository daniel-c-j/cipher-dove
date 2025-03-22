import 'package:cipher_dove/src/features/cipher/presentation/cipher_action/cipher_action_switch.dart';
import 'package:cipher_dove/src/features/cipher/presentation/cipher_algorithm/algorithm_selected.dart';
import 'package:cipher_dove/src/features/cipher/presentation/process_button.dart';
import 'package:cipher_dove/src/features/home/presentation/components/clear_icon_button.dart';
import 'package:cipher_dove/src/features/home/presentation/components/home_appbar.dart';
import 'package:cipher_dove/src/features/home/presentation/components/home_textfield.dart';
import 'package:flutter/material.dart';

import '../../../common_widgets/generic_title.dart';
import '../../../constants/_constants.dart';
import 'components/swap_icon_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GAP_H8,
            const Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    GenericTitle(icon: Icons.input_outlined, title: "Input"),
                    GAP_H8,
                    HomeTextfield(hintText: "Type here...", maxLines: 5, readOnly: false),
                  ],
                ),
                Positioned(right: -2.5, top: -2.5, child: ClearIconButton())
              ],
            ),
            GAP_H32,
            const CipherActionSwitch(),
            GAP_H8,
            const Row(
              children: [
                AlgorithmSelected(),
                Spacer(),
                ProcessButton(),
              ],
            ),
            GAP_H32,
            const Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    GenericTitle(icon: Icons.output_outlined, title: "Output"),
                    GAP_H8,
                    HomeTextfield(hintText: "Result here", maxLines: 5, readOnly: true),
                  ],
                ),
                Positioned(right: -2.5, top: -2.5, child: SwapIconButton())
              ],
            ),
            GAP_H8,
          ],
        ),
      ),
    );
  }
}
