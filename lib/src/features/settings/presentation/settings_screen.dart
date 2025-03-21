import 'package:flutter/material.dart';
import 'package:cipher_dove/src/features/settings/presentation/layouts/mobile_layout.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SettingsScreenMobileLayout(),
    );
  }
}
