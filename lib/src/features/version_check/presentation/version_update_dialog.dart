import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cipher_dove/src/features/version_check/domain/version_check.dart';

import '../../../constants/_constants.dart';

class VersionUpdateDialog extends ConsumerWidget {
  const VersionUpdateDialog(this.versionCheck, {super.key});

  final VersionCheck versionCheck;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO better UI
    return Column(
      children: [
        Text(
          "New update v${versionCheck.latestVersion} ${versionCheck.mustUpdate ? "is required" : ""}",
        ),
//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
        SizedBox(height: 20),
        Text(
          "There is a new improved version of this app.",
        ),
        SizedBox(height: 20),
        Text(
          "Make sure you synchronize all of your current collection to the cloud before updating the app "
          "if you still want to keep your data. Thank you for your attention! :D",
        ),
//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
        SizedBox(height: 20),
        TextButton.icon(
          icon: Icon(
            Icons.system_update_alt,
          ),
          label: Text("Take me to the download page"),
          onPressed: () async {
            final url = Uri.parse(NetConsts.URL_UPDATE_VERSION);
            await launchUrl(url);
          },
        ),
//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
      ],
    );
  }
}
