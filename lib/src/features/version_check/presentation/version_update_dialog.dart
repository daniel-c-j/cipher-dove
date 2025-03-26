import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common_widgets/custom_button.dart';
import '../../../constants/_constants.dart';
import '../../../core/_core.dart';
import '../../../util/context_shortcut.dart';
import '../domain/version_check.dart';

// TODO better UI

/// Content of the version update dialog.
class VersionUpdateDialog extends ConsumerWidget {
  const VersionUpdateDialog(this.versionCheck, {super.key});

  final VersionCheck versionCheck;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "${"New update".tr()} v${versionCheck.latestVersion} ${versionCheck.mustUpdate ? "is required".tr() : ""}",
          textAlign: TextAlign.center,
          style: kTextStyle(context).titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
        const Divider(),
        GAP_H4,
        Text(
          "There is a new improved version of this app.".tr(),
          textAlign: TextAlign.center,
          style: kTextStyle(context).bodyMedium,
        ),
//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
        GAP_H16,
        CustomButton(
          msg: "Go to download page".tr(),
          buttonColor: PRIMARY_COLOR_D0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          onTap: () async {
            final url = Uri.parse(NetConsts.URL_UPDATE_VERSION);
            await launchUrl(url);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.system_update_alt,
                size: 18,
                color: Colors.white,
              ),
              GAP_W8,
              Text(
                "Download".tr(),
                style: kTextStyle(context).bodyMedium?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
        GAP_H6,
        CustomButton(
          msg: "Later".tr(),
          isOutlined: true,
          borderWidth: 1.25,
          borderColor: PRIMARY_COLOR_D0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          onTap: () async {
            context.pop();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "No thanks".tr(),
                style: kTextStyle(context).bodyMedium?.copyWith(color: kColor(context).inverseSurface),
              ),
            ],
          ),
        ),
//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
      ],
    );
  }
}
