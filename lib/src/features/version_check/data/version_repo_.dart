import '../domain/version_check.dart';

abstract class VersionCheckRepo {
  Future<VersionCheck> getVersionCheck();
}
