import 'package:cipher_dove/src/features/cipher/data/local/local_cipher_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/cipher_action.dart';
import '../domain/cipher_algorithm.dart';
import '../domain/cipher_mode.dart';

part 'cipher_output_controller.g.dart';

@Riverpod(keepAlive: true)
class CipherOutputController extends _$CipherOutputController {
  @override
  FutureOr<String> build() async {
    return "";
  }

  Future<void> process(
    String input,
    String secretKey, {
    required CipherMode mode,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      if (mode.action == CipherAction.encrypt) {
        //
        if (mode.algorithm.type == CipherAlgorithmType.symmetric) {
          return await ref.read(localCipherRepositoryProvider).encryptSymmetric(
                input,
                secretKey,
                algorithm: mode.algorithm,
              );
        }

        if (mode.algorithm.type == CipherAlgorithmType.asymmetric) {
          return await ref.read(localCipherRepositoryProvider).encryptAsymmetric(input, mode: mode);
        }

        if (mode.algorithm.type == CipherAlgorithmType.hash) {
          return await ref.read(localCipherRepositoryProvider).hash(input, mode: mode);
        }
      }

      // Expected to be CipherAction.decrypt
      if (mode.algorithm.type == CipherAlgorithmType.symmetric) {
        return await ref.read(localCipherRepositoryProvider).decryptSymmetric(
              input,
              secretKey,
              algorithm: mode.algorithm,
            );
      }

      if (mode.algorithm.type == CipherAlgorithmType.asymmetric) {
        return await ref.read(localCipherRepositoryProvider).decryptAsymmetric(input, mode: mode);
      }

      // Hash cannot be decrypted.

      return "";
    });
  }
}
