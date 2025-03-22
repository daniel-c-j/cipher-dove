import 'package:cipher_dove/src/features/cipher/data/cipher_action.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/cipher_algorithm.dart';
import '../domain/cipher_mode.dart';

part 'cipher_mode_state.g.dart';

@Riverpod(keepAlive: true)
class CipherModeState extends _$CipherModeState {
  @override
  CipherMode build() {
    return const CipherMode(
      action: CipherAction.encrypt,
      algorithm: CipherAlgorithm.aes,
    );
  }

  set mode(CipherMode mode) => state = mode;
}
