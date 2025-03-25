import '../domain/version_check.dart';

abstract class VersionCheckRepo {
  late final VersionCheck versionCheck;
  Future<void> getVersionCheck();
}
