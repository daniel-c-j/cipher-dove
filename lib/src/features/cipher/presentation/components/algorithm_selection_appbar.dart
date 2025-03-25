import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/_constants.dart';
import '../../../../core/_core.dart';
import '../../../../util/context_shortcut.dart';

class AlgorithmSelectionAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AlgorithmSelectionAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: kColor(context).surface,
      actions: [
        Flexible(
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              GAP_W4,
              Text(
                "Algorithm Selection".tr(),
                style: kTextStyle(context).titleMedium?.copyWith(
                      color: PRIMARY_COLOR_L0,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              GAP_W12,
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 60);
}
