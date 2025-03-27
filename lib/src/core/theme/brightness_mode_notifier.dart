import 'dart:core';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../constants/_constants.dart';
import '../_core.dart';

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
    if (isLightMode) return await light(persists: false);
    return await dark(persists: false);
  }

  /// Will directly remembers the configuration in order to maintain simplicity.
  Future<void> light({bool persists = true}) async {
    state = Brightness.light;
    if (persists) await ref.read(sharedPrefProvider).setBool(DBKeys.BRIGHTNESS_LIGHT, true);
  }

  /// Will directly remembers the configuration in order to maintain simplicity.
  Future<void> dark({bool persists = true}) async {
    state = Brightness.dark;
    if (persists) await ref.read(sharedPrefProvider).setBool(DBKeys.BRIGHTNESS_LIGHT, false);
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
