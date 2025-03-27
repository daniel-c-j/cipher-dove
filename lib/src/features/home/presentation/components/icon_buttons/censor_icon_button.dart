import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../../../common_widgets/custom_button.dart';
import '../../../../../util/context_shortcut.dart';
import '../home_screen_input.dart';

/// Used to only just change the value of input text controller with output
/// text controller's value.
class CensorIconButton extends ConsumerWidget {
  const CensorIconButton({super.key});

  static const buttonKey = Key("CensorIconButton");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSecretObscure = ref.watch(obscureSecretStateProvider);

    return CustomButton(
      key: buttonKey,
      onTap: () {
        ref.read(obscureSecretStateProvider.notifier).set(!isSecretObscure);
      },
      msg: "Censor/Decensor secret".tr(),
      isOutlined: true,
      borderWidth: 1,
      borderColor: kColor(context).primary,
      borderRadius: BorderRadius.circular(6),
      padding: const EdgeInsets.all(8),
      margin: EdgeInsets.zero,
      child: Icon(
        (isSecretObscure) ? Icons.visibility_rounded : Icons.visibility_off,
        size: 18,
      ),
    );
  }
}
