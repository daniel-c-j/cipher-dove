import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../../common_widgets/generic_title.dart';
import '../../../../constants/_constants.dart';
import 'icon_buttons/clear_icon_button.dart';
import 'home_textfield.dart';
import 'icon_buttons/swap_icon_button.dart';
import '../input_output_form_state.dart';

/// Containing output text field with its other options.
class HomeScreenOutput extends ConsumerWidget {
  const HomeScreenOutput({super.key});

  static const titleKey = Key("HomeScreenOutputTitle");
  static const outputFieldKey = Key("HomeScreenOutputFieldKey");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final output = ref.watch(outputTextFormStateProvider);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            GenericTitle(key: titleKey, icon: Icons.output_outlined, title: "Output".tr()),
            GAP_H8,
            HomeTextfield(
              key: outputFieldKey,
              hintText: "Result here".tr(),
              maxLines: 6,
              readOnly: true,
              controller: output,
              onTap: () {
                Clipboard.setData(ClipboardData(text: output.text));

                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Copied to clipboard.".tr()),
                    dismissDirection: DismissDirection.horizontal,
                  ),
                );
              },
            ),
          ],
        ),
        if (output.text.isNotEmpty)
          const Positioned(
            right: -2.5,
            top: -3.5,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SwapIconButton(),
                GAP_W4,
                ClearOutputIconButton(),
              ],
            ),
          )
      ],
    );
  }
}
