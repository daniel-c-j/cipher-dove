// ignore_for_file: non_constant_identifier_names, constant_identifier_names

/// Network constants.
class NetConsts {
  /// [Dio] configuration.
  static const String APPLICATION_JSON = "application/json";
  static const String CONTENT_TYPE = "content-type";
  static const String AUTHORIZATION = "Authorization";
  static const String ACCEPT = "accept";
  static const int API_TIMEOUT = 60000;

  /// Used for [VersionCheck].
  static late final String URL_CHECK_LATEST_VERSION;

  /// Lazy Initialization exists for the ease of testing to manipulate certain properties of [NetConsts].
  static void init() {
    URL_CHECK_LATEST_VERSION = "https://myurlhere.com/version.txt"; // TODO change.
  }
}
