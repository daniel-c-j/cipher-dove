import 'dart:async';

import 'package:cipher_dove/src/constants/_constants.dart';
import 'package:cipher_dove/src/core/_core.dart';
import 'package:cipher_dove/src/exceptions/_exceptions.dart';
import 'package:cipher_dove/src/features/version_check/data/version_repo_.dart';
import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:sha3/sha3.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockDio extends Mock implements Dio {}

class MockApiService extends Mock implements ApiService {}

class MockDioException extends Mock implements DioException {}

class MockPackageInfo extends Mock implements PackageInfoWrapper {}

class MockTimer extends Mock implements Timer {}

class MockErrorLogger extends Mock implements ErrorLogger {}

class MockVersionCheckRepo extends Mock implements VersionCheckRepo {}

class MockInternetConnection extends Mock implements InternetConnection {}

class MockSharedPreferences extends Mock implements SharedPreferencesAsync {}

class MockCryptography extends Mock implements Cryptography {}

class MockSHA3 extends Mock implements SHA3 {}

class MockCallback extends Mock {
  void call();
}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}
