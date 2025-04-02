import 'dart:io';

import 'package:cipher_dove/src/constants/_constants.dart';
import 'package:cipher_dove/src/core/local_db/hive_adapters.dart';
import 'package:cipher_dove/src/core/local_db/hive_registrar.g.dart';
import 'package:cipher_dove/src/features/cipher/data/local_default_cipher_repo.dart';
import 'package:cipher_dove/src/features/cipher/domain/cipher_algorithm.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../mocks.dart';

void main() {
  SharedPreferencesDefaultCipherRepo makePrefDefaultCipherRepo(SharedPreferencesAsync sharedPref) =>
      SharedPreferencesDefaultCipherRepo(sharedPref);

  HiveDefaultCipherRepo makeHiveDefaultCipherRepo(Box<int> box) => HiveDefaultCipherRepo(box);

  // Simulating values.
  const algorithmIndex = 1;
  Default.CIPHER_ALGORITHM_INDEX = 0;

  setUpAll(() async {
    if (Default.LOCAL_DB != LocalDB.hive) return;
    Hive.init((Directory('/mock/path')).path);
    Hive.registerAdapters();
    await Hive.initBoxes();
  });

  group('defaultAlgorithm with SharedPref', () {
    Default.LOCAL_DB = LocalDB.sharedPref;

    test('''
    Given calling getDefaultAlgorithm
    When success,
    Then return CipherAlgorithm with the correct index.
  ''', () async {
      // * Arrange
      final sharedPref = MockSharedPreferencesAsync();
      final repo = makePrefDefaultCipherRepo(sharedPref);

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
      final sharedPref = MockSharedPreferencesAsync();
      final repo = makePrefDefaultCipherRepo(sharedPref);
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
      final sharedPref = MockSharedPreferencesAsync();
      final repo = makePrefDefaultCipherRepo(sharedPref);

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

  group('defaultAlgorithm with Hive', () {
    Default.LOCAL_DB = LocalDB.hive;

    test('''
    Given calling getDefaultAlgorithm
    When success,
    Then return CipherAlgorithm with the correct index.
  ''', () async {
      // * Arrange
      final box = MockHiveBox<int>();
      final repo = makeHiveDefaultCipherRepo(box);

      when(() => box.get(DBKeys.CIPHER_ALGORITHM_INDEX, defaultValue: Default.CIPHER_ALGORITHM_INDEX))
          .thenReturn(algorithmIndex);

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
      final box = MockHiveBox<int>();
      final repo = makeHiveDefaultCipherRepo(box);

      when(() => box.get(DBKeys.CIPHER_ALGORITHM_INDEX, defaultValue: Default.CIPHER_ALGORITHM_INDEX))
          .thenThrow(Exception());

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
      final box = MockHiveBox<int>();
      final repo = makeHiveDefaultCipherRepo(box);

      when(() => box.put(DBKeys.CIPHER_ALGORITHM_INDEX, algorithmIndex))
          .thenAnswer((_) async => Future.value());
      when(() => box.get(DBKeys.CIPHER_ALGORITHM_INDEX, defaultValue: Default.CIPHER_ALGORITHM_INDEX))
          .thenReturn(algorithmIndex);

      // * Act
      await repo.setDefaultAlgorithm(CipherAlgorithm.values[algorithmIndex]);

      // * Assert
      final algorithm = await repo.getDefaultAlgorithm();
      expect(algorithm, CipherAlgorithm.values[algorithmIndex]);
    });
  });
}
