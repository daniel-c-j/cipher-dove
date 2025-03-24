// ignore_for_file: constant_identifier_names, non_constant_identifier_names

/// Default app configurations.
class Default {
  /// Used for settings.
  static late final bool AUTO_UPDATE_CHECK_CONF;
  static late final int CIPHER_ALGORITHM_INDEX;

  /// Lazy Initialization exists for the ease of testing to manipulate certain properties of [Default].
  static void init() {
    AUTO_UPDATE_CHECK_CONF = true;
    CIPHER_ALGORITHM_INDEX = 1;
  }
}
