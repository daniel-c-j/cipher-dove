import 'package:cipher_dove/src/features/cipher/data/local/local_cipher_repo.dart';
import 'package:cipher_dove/src/features/cipher/domain/cipher_action.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/_constants.dart';
import '../domain/cipher_algorithm.dart';
import '../domain/cipher_mode.dart';

part 'cipher_mode_state.g.dart';

@Riverpod(keepAlive: true)
class CipherModeState extends _$CipherModeState {
  @override
  CipherMode build() {
    return CipherMode(
      action: CipherAction.encrypt,
      algorithm: CipherAlgorithm.values[Default.CIPHER_ALGORITHM_INDEX],
    );
  }

  /// Fetching config data from local repo.
  Future<void> init() async {
    final algorithm = await ref.watch(localCipherRepositoryProvider).getDefaultAlgorithm();
    state = state.copyWith(algorithm: algorithm);
  }

  set mode(CipherMode mode) => state = mode;
}
