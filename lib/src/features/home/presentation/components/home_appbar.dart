import 'package:cipher_dove/src/constants/_constants.dart';
import 'package:cipher_dove/src/features/home/presentation/components/theme_icon_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/_core.dart';
import '../../../../util/context_shortcut.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kColor(context).surface,
      scrolledUnderElevation: 0,
      actions: [
        Expanded(
          child: Row(
            children: [
              GAP_W12,
              Text(
                "Cipher Dove",
                style: kTextStyle(context).titleLarge?.copyWith(
                      color: PRIMARY_COLOR_L0,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              const ThemeIconButton(),
              GAP_W4,
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 60);
}
