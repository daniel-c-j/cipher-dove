import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../../common_widgets/custom_button.dart';
import '../../../../../core/_core.dart';
import '../../../../../util/context_shortcut.dart';

/// Change the theme of the app.
class ThemeIconButton extends ConsumerWidget {
  const ThemeIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(platformBrightnessProvider);
    return CustomButton(
      msg: "Switch dark/light theme".tr(),
      padding: const EdgeInsets.all(10),
      buttonColor: Colors.transparent,
      borderRadius: BorderRadius.circular(60),
      onTap: () {
        SchedulerBinding.instance.addPostFrameCallback((_) async {
          (mode == Brightness.light)
              ? await ref.read(platformBrightnessProvider.notifier).dark()
              : await ref.read(platformBrightnessProvider.notifier).light();
        });
      },
      child: Icon(
        BoxIcons.bx_brightness_half,
        color: kColor(context).inverseSurface,
      ),
    );
  }
}
