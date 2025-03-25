import 'dart:async';

import 'package:cipher_dove/src/features/version_check/data/version_repo_.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:cipher_dove/src/constants/app_info.dart';
import 'package:cipher_dove/src/core/network/api_service.dart';

class MockDio extends Mock implements Dio {}

class MockApiService extends Mock implements ApiService {}

class MockDioException extends Mock implements DioException {}

class MockPackageInfo extends Mock implements PackageInfoWrapper {}

class MockTimer extends Mock implements Timer {}

class MockVersionCheckRepo extends Mock implements VersionCheckRepo {}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}
