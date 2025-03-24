import 'package:cipher_dove/src/features/cipher/presentation/components/cipher_action_switch.dart';
import 'package:cipher_dove/src/features/cipher/presentation/components/algorithm_selected.dart';
import 'package:cipher_dove/src/features/cipher/presentation/components/process_button.dart';
import 'package:cipher_dove/src/features/home/presentation/components/clear_icon_button.dart';
import 'package:cipher_dove/src/features/home/presentation/components/home_appbar.dart';
import 'package:cipher_dove/src/features/home/presentation/components/home_textfield.dart';
import 'package:cipher_dove/src/features/home/presentation/input_output_form_state.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/generic_title.dart';
import '../../../constants/_constants.dart';
import '../../cipher/domain/cipher_algorithm.dart';
import '../../cipher/presentation/cipher_mode_state.dart';
import 'components/swap_icon_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text("Tap again to exit."),
          dismissDirection: DismissDirection.horizontal,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GAP_H8,
              Consumer(
                builder: (context, ref, child) {
                  final input = ref.watch(inputTextFormStateProvider);
                  final inputPass = ref.watch(inputPasswordTextFormStateProvider);
                  final cipherMode = ref.watch(cipherModeStateProvider);

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        children: [
                          const GenericTitle(icon: Icons.input_outlined, title: "Input"),
                          GAP_H8,
                          HomeTextfield(
                            hintText: "Type here...",
                            maxLines: 5,
                            readOnly: false,
                            controller: input,
                          ),
                          GAP_H8,
                          if (cipherMode.algorithm.type != CipherAlgorithmType.hash)
                            // TODO add suffix icon to clear, and to set the content to be obscure ****** or not.
                            HomeTextfield(
                              hintText: "Secret Key here...",
                              labelText: " Secret ",
                              maxLines: 1,
                              readOnly: false,
                              controller: inputPass,
                            ),
                        ],
                      ),
                      // To autoupdate
                      ValueListenableBuilder(
                        valueListenable: input,
                        builder: (context, value, child) {
                          if (input.text.isNotEmpty) {
                            return const Positioned(right: -2.5, top: -2.5, child: ClearIconButton());
                          }

                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  );
                },
              ),
              GAP_H32,
              const CipherActionSwitch(),
              GAP_H12,
              const Row(children: [AlgorithmSelected(), Spacer(), ProcessButton()]),
              GAP_H32,
              Consumer(
                builder: (context, ref, child) {
                  final output = ref.watch(outputTextFormStateProvider);

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        children: [
                          const GenericTitle(icon: Icons.output_outlined, title: "Output"),
                          GAP_H8,
                          HomeTextfield(
                            hintText: "Result here",
                            maxLines: 5,
                            readOnly: true,
                            controller: output,
                          ),
                        ],
                      ),
                      if (output.text.isNotEmpty)
                        // TODO add iconbutton to clear and copy
                        const Positioned(right: -2.5, top: -2.5, child: SwapIconButton())
                    ],
                  );
                },
              ),
              GAP_H8,
            ],
          ),
        ),
      ),
    );
  }
}
