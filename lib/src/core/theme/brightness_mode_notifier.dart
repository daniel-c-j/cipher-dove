import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

  void dark() => state = Brightness.dark;
  void light() => state = Brightness.light;
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
