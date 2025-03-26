import 'package:cipher_dove/src/features/cipher/domain/cipher_action.dart';
import 'package:cipher_dove/src/features/cipher/presentation/cipher_mode_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../common_widgets/generic_title.dart';
import '../../../../core/_core.dart';
import '../../../../util/context_shortcut.dart';
import '../../domain/cipher_algorithm.dart';

/// Toggle-able switch for user to pick a [CipherAction] operation.
class CipherActionSwitch extends ConsumerWidget {
  const CipherActionSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cipherMode = ref.watch(cipherModeStateProvider);
    final cipherAction = cipherMode.action;
    final isHash = cipherMode.algorithm.type == CipherAlgorithmType.hash;

    return ToggleSwitch(
      initialLabelIndex: cipherAction.index,
      inactiveBgColor: kColor(context).surfaceDim,
      minHeight: 30,
      totalSwitches: 2,
      animationDuration: 500,
      animate: true,
      activeBorders: [Border.all(color: PRIMARY_COLOR_L0), Border.all(color: PRIMARY_COLOR_L0)],
      customWidths: [kScreenWidth(context) * 0.5, kScreenWidth(context) * 0.5],
      customWidgets: [
        Transform.scale(
          scale: 0.9,
          child: GenericTitle(
            title: "Encrypt ".tr(),
            titleColor: (cipherAction == CipherAction.encrypt) ? Colors.white : null,
            iconColor: (cipherAction == CipherAction.encrypt) ? Colors.white : null,
            icon: Icons.lock,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        Transform.scale(
          scale: 0.9,
          child: GenericTitle(
            title: "Decrypt ".tr(),
            titleColor: (cipherAction == CipherAction.decrypt) ? Colors.white : null,
            iconColor: (cipherAction == CipherAction.decrypt) ? Colors.white : null,
            icon: Icons.key,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ],
      onToggle: (index) {
        final cipherModeChange = ref.read(cipherModeStateProvider.notifier);
        if (isHash) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Hash is a One-way Encryption, so it cannot be decrypted.".tr()),
              dismissDirection: DismissDirection.horizontal,
            ),
          );

          // Force to encryption mode.
          cipherModeChange.mode = cipherMode.copyWith(action: CipherAction.values[0]);
          return;
        }

        cipherModeChange.mode = cipherMode.copyWith(action: CipherAction.values[index ?? 0]);
        return;
      },
    );
  }
}
