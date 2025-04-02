import 'package:cipher_dove/src/features/cipher/data/local_algorithm_repo.dart';
import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sha3/sha3.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../mocks.dart';

void main() {
  LocalAlgorithmRepo makeLocalCipherRepo(
    SharedPreferencesAsync sharedPref,
    Cryptography crypt,
    SHA3 sha3Factory,
  ) =>
      LocalAlgorithmRepo(crypt, sha3Factory);

  group('padKey method', () {
    test('padKey throws ArgumentError for non-positive keyLength', () {
      // * Arrange
      final sharedPref = MockSharedPreferencesAsync();
      final crypt = MockCryptography();
      final sha3Factory = MockSHA3();
      final repo = makeLocalCipherRepo(sharedPref, crypt, sha3Factory);

      // * Action & Assert
      expect(() => repo.padKey('test', 0), throwsA(isA<ArgumentError>()));
      expect(() => repo.padKey('test', -1), throwsA(isA<ArgumentError>()));
    });

    test('padKey pads the key correctly', () {
      // * Arrange
      final sharedPref = MockSharedPreferencesAsync();
      final crypt = MockCryptography();
      final sha3Factory = MockSHA3();
      final repo = makeLocalCipherRepo(sharedPref, crypt, sha3Factory);

      // * Action & Assert
      expect(repo.padKey('test', 6), equals('test00'));
    });

    test('padKey truncates the key correctly', () {
      // * Arrange
      final sharedPref = MockSharedPreferencesAsync();
      final crypt = MockCryptography();
      final sha3Factory = MockSHA3();
      final repo = makeLocalCipherRepo(sharedPref, crypt, sha3Factory);

      // * Action & Assert
      expect(repo.padKey('testing', 5), equals('testi'));
    });

    test('padKey returns the key if length is correct', () {
      // * Arrange
      final sharedPref = MockSharedPreferencesAsync();
      final crypt = MockCryptography();
      final sha3Factory = MockSHA3();
      final repo = makeLocalCipherRepo(sharedPref, crypt, sha3Factory);

      // * Action & Assert
      expect(repo.padKey('test', 4), equals('test'));
    });
  });

  group('symmetric', () {
    // TODO complete this.
  });
}
