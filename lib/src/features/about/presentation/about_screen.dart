import 'package:flutter/material.dart';

import '../../../constants/_constants.dart';
import '../../../core/_core.dart';
import '../../../util/context_shortcut.dart';
import 'components/contact_dev.dart';
import 'components/license_dev.dart';

// TODO icon image here
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppInfo.TITLE,
              textAlign: TextAlign.center,
              style: kTextStyle(context).titleLarge?.copyWith(
                    color: PRIMARY_COLOR_L0,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              'v${AppInfo.CURRENT_VERSION}',
              textAlign: TextAlign.center,
              style: kTextStyle(context).bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            GAP_H4,
            Text(
              AppInfo.DESCRIPTION,
              textAlign: TextAlign.center,
              style: kTextStyle(context).bodySmall,
            ),
            Divider(
              indent: kScreenWidth(context) * 0.1,
              endIndent: kScreenWidth(context) * 0.1,
            ),
            const ContactDev(),
            Divider(
              indent: kScreenWidth(context) * 0.1,
              endIndent: kScreenWidth(context) * 0.1,
            ),
            const LicenseDev(),
          ],
        ),
      ),
    );
  }
}
