import 'dart:async';

import 'package:cipher_dove/src/constants/_constants.dart';
import 'package:cipher_dove/src/core/_core.dart';
import 'package:cipher_dove/src/exceptions/_exceptions.dart';
import 'package:cipher_dove/src/features/cipher/domain/cipher_mode.dart';
import 'package:cipher_dove/src/features/cipher/presentation/cipher_output_controller.dart';
import 'package:cipher_dove/src/features/version_check/data/version_repo_.dart';
import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:hive_ce/hive.dart';
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

class MockSharedPreferencesAsync extends Mock implements SharedPreferencesAsync {}

class MockHiveBox<T> extends Mock implements Box<T> {}

class MockCryptography extends Mock implements Cryptography {}

class MockSHA3 extends Mock implements SHA3 {}

class MockCipherMode extends Mock implements CipherMode {}

/// Force manual mocking, life is sad :(... but keep smile!
class MockCipherOutputController extends CipherOutputController {
  MockCipherOutputController({this.action});
  final Function()? action;

  @override
  FutureOr<void> build() {}

  @override
  Future<void> process(
    String input,
    String secretKey, {
    required CipherMode mode,
    required void Function(String value) onSuccess,
    required void Function(Object? e) onError,
  }) async {
    action;
  }
}

class MockCallback extends Mock {
  void call();
}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}
