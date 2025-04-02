import 'package:cipher_dove/src/features/cipher/data/_abstract_cipher_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/_constants.dart';
import '../domain/cipher_algorithm.dart';

part 'local_default_cipher_repo.g.dart';

class SharedPreferencesDefaultCipherRepo implements DefaultCipherRepository {
  const SharedPreferencesDefaultCipherRepo(this._sharedPref);
  final SharedPreferencesAsync _sharedPref;

  @override
  Future<CipherAlgorithm> getDefaultAlgorithm() async {
    try {
      final index = await _sharedPref.getInt(DBKeys.CIPHER_ALGORITHM_INDEX);
      return CipherAlgorithm.values[index!];
    } catch (e) {
      return CipherAlgorithm.values[Default.CIPHER_ALGORITHM_INDEX];
    }
  }

  @override
  Future<void> setDefaultAlgorithm(CipherAlgorithm algorithm) async {
    return await _sharedPref.setInt(DBKeys.CIPHER_ALGORITHM_INDEX, CipherAlgorithm.values.indexOf(algorithm));
  }
}

//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//

class HiveDefaultCipherRepo implements DefaultCipherRepository {
  HiveDefaultCipherRepo(this._box);

  final Box<int> _box;

  @override
  Future<CipherAlgorithm> getDefaultAlgorithm() async {
    try {
      final index = _box.get(DBKeys.CIPHER_ALGORITHM_INDEX, defaultValue: Default.CIPHER_ALGORITHM_INDEX);
      return CipherAlgorithm.values[index!];
    } catch (e) {
      return CipherAlgorithm.values[Default.CIPHER_ALGORITHM_INDEX];
    }
  }

  @override
  Future<void> setDefaultAlgorithm(CipherAlgorithm algorithm) async {
    return await _box.put(DBKeys.CIPHER_ALGORITHM_INDEX, CipherAlgorithm.values.indexOf(algorithm));
  }
}

//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//

@Riverpod(keepAlive: true)
DefaultCipherRepository defaultCipherRepo(Ref ref) {
  if (Default.LOCAL_DB == LocalDB.sharedPref) {
    final sharedPref = SharedPreferencesAsync();
    return SharedPreferencesDefaultCipherRepo(sharedPref);
  }

  // Will not touch Hive if sharedPref is used as local db.
  final box = Hive.box<int>(DBKeys.CIPHER_REPO_BOX);

  ref.onDispose(() async => await box.close());
  return HiveDefaultCipherRepo(box);
}
