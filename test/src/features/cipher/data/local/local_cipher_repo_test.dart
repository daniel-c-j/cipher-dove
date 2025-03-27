import 'package:cipher_dove/src/constants/_constants.dart';
import 'package:cipher_dove/src/features/cipher/data/local/local_cipher_repo.dart';
import 'package:cipher_dove/src/features/cipher/domain/cipher_algorithm.dart';
import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sha3/sha3.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../mocks.dart';

void main() {
  LocalCipherRepository makeLocalCipherRepo(
    SharedPreferencesAsync sharedPref,
    Cryptography crypt,
    SHA3 sha3Factory,
  ) =>
      LocalCipherRepository(sharedPref, crypt, sha3Factory);

  // Simulating values.
  const algorithmIndex = 1;
  Default.CIPHER_ALGORITHM_INDEX = 0;

  group('defaultAlgorithm', () {
    test('''
    Given calling getDefaultAlgorithm,
    When success,
    Then return CipherAlgorithm with the correct index.
  ''', () async {
      // * Arrange
      final sharedPref = MockSharedPreferences();
      final crypt = MockCryptography();
      final sha3Factory = MockSHA3();
      final repo = makeLocalCipherRepo(sharedPref, crypt, sha3Factory);

      when(() => sharedPref.getInt(DBKeys.CIPHER_ALGORITHM_INDEX))
          .thenAnswer((_) async => Future.value(algorithmIndex));

      // * Act
      final algorithm = await repo.getDefaultAlgorithm();

      // * Assert
      expect(algorithm, CipherAlgorithm.values[algorithmIndex]);
    });

    test('''
    Given calling getDefaultAlgorithm,
    When error,
    Then return CipherAlgorithm with the default index.
  ''', () async {
      // * Arrange
      final sharedPref = MockSharedPreferences();
      final crypt = MockCryptography();
      final sha3Factory = MockSHA3();
      final repo = makeLocalCipherRepo(sharedPref, crypt, sha3Factory);

      when(() => sharedPref.getInt(DBKeys.CIPHER_ALGORITHM_INDEX)).thenThrow(Exception());

      // * Act
      final algorithm = await repo.getDefaultAlgorithm();

      // * Assert
      expect(algorithm, CipherAlgorithm.values[Default.CIPHER_ALGORITHM_INDEX]);
    });

    test('''
    Given calling setDefaultAlgorithm,
    When success,
    Then getDefaultAlgorithm should return CipherAlgorithm with the right value.
  ''', () async {
      // * Arrange
      final sharedPref = MockSharedPreferences();
      final crypt = MockCryptography();
      final sha3Factory = MockSHA3();
      final repo = makeLocalCipherRepo(sharedPref, crypt, sha3Factory);

      when(() => sharedPref.setInt(DBKeys.CIPHER_ALGORITHM_INDEX, algorithmIndex))
          .thenAnswer((_) async => Future.value());
      when(() => sharedPref.getInt(DBKeys.CIPHER_ALGORITHM_INDEX))
          .thenAnswer((_) async => Future.value(algorithmIndex));

      // * Act
      await repo.setDefaultAlgorithm(CipherAlgorithm.values[algorithmIndex]);

      // * Assert
      final algorithm = await repo.getDefaultAlgorithm();
      expect(algorithm, CipherAlgorithm.values[algorithmIndex]);
    });
  });

  group('padKey method', () {
    test('padKey throws ArgumentError for non-positive keyLength', () {
      // * Arrange
      final sharedPref = MockSharedPreferences();
      final crypt = MockCryptography();
      final sha3Factory = MockSHA3();
      final repo = makeLocalCipherRepo(sharedPref, crypt, sha3Factory);

      // * Action & Assert
      expect(() => repo.padKey('test', 0), throwsA(isA<ArgumentError>()));
      expect(() => repo.padKey('test', -1), throwsA(isA<ArgumentError>()));
    });

    test('padKey pads the key correctly', () {
      // * Arrange
      final sharedPref = MockSharedPreferences();
      final crypt = MockCryptography();
      final sha3Factory = MockSHA3();
      final repo = makeLocalCipherRepo(sharedPref, crypt, sha3Factory);

      // * Action & Assert
      expect(repo.padKey('test', 6), equals('test00'));
    });

    test('padKey truncates the key correctly', () {
      // * Arrange
      final sharedPref = MockSharedPreferences();
      final crypt = MockCryptography();
      final sha3Factory = MockSHA3();
      final repo = makeLocalCipherRepo(sharedPref, crypt, sha3Factory);

      // * Action & Assert
      expect(repo.padKey('testing', 5), equals('testi'));
    });

    test('padKey returns the key if length is correct', () {
      // * Arrange
      final sharedPref = MockSharedPreferences();
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
