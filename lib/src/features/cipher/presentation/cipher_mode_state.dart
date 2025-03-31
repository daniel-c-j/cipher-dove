import 'package:cipher_dove/src/features/cipher/domain/cipher_action.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/_constants.dart';
import '../data/local_default_cipher_repo.dart';
import '../domain/cipher_algorithm.dart';
import '../domain/cipher_mode.dart';

part 'cipher_mode_state.g.dart';

/// Controls the state of the operation configuration.
@Riverpod(keepAlive: true)
class CipherModeState extends _$CipherModeState {
  @override
  CipherMode build() {
    return CipherMode(
      action: CipherAction.encrypt,
      algorithm: CipherAlgorithm.values[Default.CIPHER_ALGORITHM_INDEX],
    );
  }

  /// Change the state of this provider.
  set mode(CipherMode mode) => state = mode;

  /// Fetching config data from local repo.
  Future<void> init() async {
    final algorithm = await getDefault();
    state = state.copyWith(algorithm: algorithm);
  }

  /// Talks to the repository to get the data.
  Future<CipherAlgorithm> getDefault() async {
    return await ref.read(defaultCipherRepoProvider).getDefaultAlgorithm();
  }

  /// Talks to the repository to set the data.
  Future<void> setDefault(CipherAlgorithm algorithm) async {
    await ref.read(defaultCipherRepoProvider).setDefaultAlgorithm(algorithm);
  }
}
