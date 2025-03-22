// ignore_for_file: non_constant_identifier_names, constant_identifier_names
import 'package:package_info_plus/package_info_plus.dart';

/// Basic app identity informations.
class AppInfo {
  static const unknown = "UNKNOWN";

  // These two are crucial and should not depend on the packageInfo.
  static const String TITLE = "Cipher Dove"; // TODO change this.
  // TODO change this.
  static const String DESCRIPTION = "An open-source, offline, zero-ads, encryption and decryption tool.";

  static late final String CURRENT_VERSION;
  static late final String PACKAGE_NAME;
  static late final String BUILD_NUMBER;
  static late final String BUILD_SIGNATURE;

  static Future<void> init(PackageInfoWrapper info) async {
    try {
      final PackageInfo packageInfo = await info.fromPlatform();

      // Making all of these variables accessible synchronously.
      CURRENT_VERSION = packageInfo.version;
      PACKAGE_NAME = packageInfo.packageName;
      BUILD_NUMBER = packageInfo.buildNumber;
      BUILD_SIGNATURE = packageInfo.buildSignature;
      //
    } catch (e) {
      CURRENT_VERSION = unknown;
      PACKAGE_NAME = unknown;
      BUILD_NUMBER = unknown;
      BUILD_SIGNATURE = unknown;
    }
  }
}

class PackageInfoWrapper {
  Future<PackageInfo> fromPlatform() async => await PackageInfo.fromPlatform();
}
