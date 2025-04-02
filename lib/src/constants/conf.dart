// coverage:ignore-file

// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/foundation.dart';

enum LocalDB {
  sharedPref,
  hive,
}

/// Data container containing default app configurations.
final class Default {
  // General uses
  static late LocalDB _LOCAL_DB; // Private so that it won't be changed during runtime.
  static LocalDB get LOCAL_DB => _LOCAL_DB; // Getters so that it won't directly touch the private var

  @visibleForTesting // So that it could be easily modified while testing.
  static set LOCAL_DB(LocalDB db) => _LOCAL_DB = db;

  // Used for settings.
  static late final bool BRIGHTNESS_LIGHT;
  static late final bool AUTO_UPDATE_CHECK_CONF;
  static late final int CIPHER_ALGORITHM_INDEX;

  /// Lazy Initialization exists for the ease of testing to manipulate certain properties of [Default].
  static void init() {
    _LOCAL_DB = LocalDB.sharedPref; // ? Maybe use environment variable instead?

    BRIGHTNESS_LIGHT = true; // false for dark mode.
    AUTO_UPDATE_CHECK_CONF = true;
    CIPHER_ALGORITHM_INDEX = 0;
  }
}
