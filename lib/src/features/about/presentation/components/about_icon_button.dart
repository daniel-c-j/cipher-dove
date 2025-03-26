import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/custom_button.dart';
import '../../../../routing/app_router.dart';
import '../../../../util/context_shortcut.dart';

/// Icon button to redirect user to about page.
class AboutIconButton extends StatelessWidget {
  const AboutIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      msg: "About".tr(),
      padding: const EdgeInsets.all(10),
      buttonColor: Colors.transparent,
      borderRadius: BorderRadius.circular(60),
      onTap: () {
        context.pushNamed(AppRoute.about.name);
      },
      child: Icon(
        Icons.info_outline,
        color: kColor(context).inverseSurface,
      ),
    );
  }
}
