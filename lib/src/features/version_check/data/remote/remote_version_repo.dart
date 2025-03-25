import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cipher_dove/src/constants/app_info.dart';
import 'package:cipher_dove/src/constants/network_constants.dart';
import 'package:cipher_dove/src/features/version_check/domain/version_check.dart';
import 'package:version/version.dart';

import '../../../../core/_core.dart';
import '../version_repo_.dart';

part 'remote_version_repo.g.dart';

class RemoteVersionCheckRepo implements VersionCheckRepo {
  RemoteVersionCheckRepo(this._apiService);

  final ApiService _apiService;

  @override
  late final VersionCheck versionCheck;

  // ! Fetched data is expected to be in this particular format:
  // ! {"requiredV": "1.2.0", "latestV": "1.2.5"}
  // ! See VERSION.json for example.
  @override
  Future<void> getVersionCheck() async {
    final response = await fetchLatestVersion();
    versionCheck = _parseVersionFromResponse(response);
  }

  Future<Response> fetchLatestVersion() {
    return _apiService.get(url: NetConsts.URL_CHECK_VERSION);
  }

  VersionCheck _parseVersionFromResponse(Response resp) {
    final latestVer = _parseToVersion(resp.data['latestV']);
    final currentVer = _parseToVersion(AppInfo.CURRENT_VERSION);
    final requiredToUpdateVer = _parseToVersion(resp.data['requiredV']);

    return VersionCheck(
      latestVersion: latestVer,
      canUpdate: latestVer > currentVer,
      mustUpdate: requiredToUpdateVer > currentVer,
      requiredToUpdateVer: requiredToUpdateVer,
    );
  }

  Version _parseToVersion(String raw) => Version.parse(raw);

  @visibleForTesting
  VersionCheck parseVersionFromResponse(Response resp) => _parseVersionFromResponse(resp);

  @visibleForTesting
  Version parseToVersion(String raw) => _parseToVersion(raw);
}

@riverpod
VersionCheckRepo versionCheckRepo(Ref ref) {
  final apiService = ref.watch(apiServiceProvider);
  return RemoteVersionCheckRepo(apiService);
}
