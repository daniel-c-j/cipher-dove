import 'package:cipher_dove/src/util/context_shortcut.dart';
import 'package:flutter/material.dart';
import 'package:cipher_dove/src/constants/screen_breakpoints.dart';

/// Multi screensizes layout support.
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    this.width,
    required this.desktop,
    required this.tablet,
    required this.mobile,
    required this.wearOS,
  });

  final double? width;
  final Widget desktop;
  final Widget tablet;
  final Widget mobile;
  final Widget wearOS;

  @override
  Widget build(BuildContext context) => switch (width ?? kScreenHeight(context)) {
        > Breakpoint.DESKTOP => desktop,
        > Breakpoint.TABLET => tablet,
        > Breakpoint.MOBILE => mobile,
        _ => wearOS
      };
}
