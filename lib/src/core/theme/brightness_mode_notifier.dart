import 'dart:core';

import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../constants/_constants.dart';
import '../_core.dart';

part 'brightness_mode_notifier.g.dart';

@Riverpod(keepAlive: true)
class PlatformBrightness extends _$PlatformBrightness {
  Box<bool>? _box;
  late bool _isLightMode;

  @override
  Brightness build() {
    final observer = _PlatformBrightnessObserver(
      onBrightnessChanged: (brightness) {},
    );

    // Listening to brightness changes.
    WidgetsBinding.instance.addObserver(observer);
    // Disposal
    ref.onDispose(() async {
      WidgetsBinding.instance.removeObserver(observer);
      await _box?.close();
    });

    return WidgetsBinding.instance.platformDispatcher.platformBrightness;
  }

  Future<bool> _getConf() async {
    if (Default.LOCAL_DB == LocalDB.sharedPref) {
      return await ref.read(sharedPrefProvider).getBool(DBKeys.BRIGHTNESS_LIGHT) ?? Default.BRIGHTNESS_LIGHT;
    }

    _box = Hive.box<bool>(DBKeys.BRIGHTNESS_BOX);
    return _box!.get(DBKeys.BRIGHTNESS_LIGHT, defaultValue: Default.BRIGHTNESS_LIGHT)!;
  }

  Future<void> _setConf(bool newValue) async {
    if (Default.LOCAL_DB == LocalDB.sharedPref) {
      return await ref.read(sharedPrefProvider).setBool(DBKeys.BRIGHTNESS_LIGHT, newValue);
    }

    _box!.put(DBKeys.BRIGHTNESS_LIGHT, newValue);
  }

  /// Used in early app initialization to remember configuration.
  Future<void> init() async {
    try {
      if (Default.LOCAL_DB == LocalDB.hive) _box = Hive.box<bool>(DBKeys.BRIGHTNESS_BOX);
      _isLightMode = await _getConf();
    } catch (e) {
      _isLightMode = false;
    }

    // False persistance since it's only an initialization.
    if (_isLightMode) return await light(persists: false);
    return await dark(persists: false);
  }

  /// Will directly remembers the configuration in order to maintain simplicity.
  Future<void> light({bool persists = true}) async {
    state = Brightness.light;
    if (persists) await _setConf(true);
  }

  /// Will directly remembers the configuration in order to maintain simplicity.
  Future<void> dark({bool persists = true}) async {
    state = Brightness.dark;
    if (persists) await _setConf(false);
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
