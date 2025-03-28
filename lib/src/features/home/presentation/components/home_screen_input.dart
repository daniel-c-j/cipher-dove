import 'package:cipher_dove/src/features/home/presentation/components/icon_buttons/censor_icon_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../common_widgets/generic_title.dart';
import '../../../../constants/_constants.dart';
import '../../../cipher/domain/cipher_algorithm.dart';
import '../../../cipher/presentation/cipher_mode_state.dart';
import '../input_output_form_state.dart';
import 'icon_buttons/clear_icon_button.dart';
import 'home_textfield.dart';

part 'home_screen_input.g.dart';

/// Set the secret textfield text mode.
@riverpod
class ObscureSecretState extends _$ObscureSecretState {
  @override
  bool build() => true;
  void set(bool value) {
    state = value;
  }
}

/// Containing input text field with its other options.
class HomeScreenInput extends ConsumerWidget {
  const HomeScreenInput({super.key});

  static const titleKey = Key("HomeScreenInputTitle");
  static const inputFieldKey = Key("HomeScreenInputFieldKey");
  static const inputPassFieldKey = Key("HomeScreenInputPassFieldKey");

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
            GenericTitle(key: titleKey, icon: Icons.input_outlined, title: "Input".tr()),
            GAP_H8,
            HomeTextfield(
              fieldKey: inputFieldKey,
              hintText: "Type here...".tr(),
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
                      fieldKey: inputPassFieldKey,
                      hintText: "Secret Key here...".tr(),
                      labelText: " Secret ".tr(),
                      maxLines: 1,
                      readOnly: false,
                      controller: inputPass,
                      obscureText: isSecretObscure,
                    ),
                  ),
                  GAP_W4,
                  const CensorIconButton(),
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
