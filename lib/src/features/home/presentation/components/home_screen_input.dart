import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../common_widgets/custom_button.dart';
import '../../../../common_widgets/generic_title.dart';
import '../../../../constants/_constants.dart';
import '../../../../util/context_shortcut.dart';
import '../../../cipher/domain/cipher_algorithm.dart';
import '../../../cipher/presentation/cipher_mode_state.dart';
import '../input_output_form_state.dart';
import 'icon_buttons/clear_icon_button.dart';
import 'home_textfield.dart';

part 'home_screen_input.g.dart';

@riverpod
class ObscureSecretState extends _$ObscureSecretState {
  @override
  bool build() => true;
  void set(bool value) {
    state = value;
  }
}

class HomeScreenInput extends ConsumerWidget {
  const HomeScreenInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final input = ref.watch(inputTextFormStateProvider);
    final inputPass = ref.watch(inputPasswordTextFormStateProvider);
    final cipherMode = ref.watch(cipherModeStateProvider);

    final isSecretObscure = ref.watch(obscureSecretStateProvider);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            const GenericTitle(icon: Icons.input_outlined, title: "Input"),
            GAP_H8,
            HomeTextfield(
              hintText: "Type here...",
              maxLines: 6,
              readOnly: false,
              controller: input,
            ),
            GAP_H8,
            if (cipherMode.algorithm.type != CipherAlgorithmType.hash)
              Row(
                children: [
                  Expanded(
                    child: HomeTextfield(
                      hintText: "Secret Key here...",
                      labelText: " Secret ",
                      maxLines: 1,
                      readOnly: false,
                      controller: inputPass,
                      obscureText: isSecretObscure,
                    ),
                  ),
                  GAP_W4,
                  CustomButton(
                    onTap: () {
                      ref.read(obscureSecretStateProvider.notifier).set(!isSecretObscure);
                    },
                    msg: "Censor/Decensor secret",
                    isOutlined: true,
                    borderWidth: 1,
                    borderColor: kColor(context).primary,
                    borderRadius: BorderRadius.circular(6),
                    padding: const EdgeInsets.all(8),
                    margin: EdgeInsets.zero,
                    child:
                        Icon((isSecretObscure) ? Icons.visibility_rounded : Icons.visibility_off, size: 18),
                  ),
                ],
              ),
          ],
        ),
        // To autoupdate
        ValueListenableBuilder(
          valueListenable: input,
          builder: (context, value, child) {
            if (input.text.isNotEmpty) {
              return const Positioned(right: -2.5, top: -2.5, child: ClearInputIconButton());
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
