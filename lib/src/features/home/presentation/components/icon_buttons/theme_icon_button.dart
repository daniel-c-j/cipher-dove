import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../../common_widgets/custom_button.dart';
import '../../../../../core/_core.dart';
import '../../../../../util/context_shortcut.dart';

class ThemeIconButton extends ConsumerWidget {
  const ThemeIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(platformBrightnessProvider);
    return CustomButton(
      msg: "Switch dark/light theme",
      padding: const EdgeInsets.all(10),
      buttonColor: Colors.transparent,
      borderRadius: BorderRadius.circular(60),
      onTap: () {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          (mode == Brightness.light)
              ? ref.read(platformBrightnessProvider.notifier).dark()
              : ref.read(platformBrightnessProvider.notifier).light();
        });
      },
      child: Icon(
        BoxIcons.bx_brightness_half,
        color: kColor(context).inverseSurface,
      ),
    );
  }
}
