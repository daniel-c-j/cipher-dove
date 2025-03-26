import 'dart:core';

import 'package:cipher_dove/src/core/_core.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../constants/_constants.dart';

part 'brightness_mode_notifier.g.dart';

@Riverpod(keepAlive: true)
class PlatformBrightness extends _$PlatformBrightness {
  @override
  Brightness build() {
    final observer = _PlatformBrightnessObserver(
      onBrightnessChanged: (brightness) {},
    );

    // Listening to brightness changes.
    WidgetsBinding.instance.addObserver(observer);
    ref.onDispose(() => WidgetsBinding.instance.removeObserver(observer));

    return WidgetsBinding.instance.platformDispatcher.platformBrightness;
  }

  /// Used in early app initialization to remember configuration.
  Future<void> init() async {
    final isLightMode =
        await ref.read(sharedPrefProvider).getBool(DBKeys.BRIGHTNESS_LIGHT) ?? Default.BRIGHTNESS_LIGHT;
    if (isLightMode) return await light();
    return await dark();
  }

  /// Will directly remembers the configuration in order to maintain simplicity.
  Future<void> light() async {
    state = Brightness.light;
    await ref.read(sharedPrefProvider).setBool(DBKeys.BRIGHTNESS_LIGHT, true);
  }

  /// Will directly remembers the configuration in order to maintain simplicity.
  Future<void> dark() async {
    state = Brightness.dark;
    await ref.read(sharedPrefProvider).setBool(DBKeys.BRIGHTNESS_LIGHT, false);
  }
}

/// Observes platform brightness changes and notifies the listener.
class _PlatformBrightnessObserver with WidgetsBindingObserver {
  const _PlatformBrightnessObserver({
    required this.onBrightnessChanged,
  });

  final ValueChanged<Brightness> onBrightnessChanged;

  @override
  void didChangePlatformBrightness() {
    onBrightnessChanged(
      WidgetsBinding.instance.platformDispatcher.platformBrightness,
    );
  }
}
