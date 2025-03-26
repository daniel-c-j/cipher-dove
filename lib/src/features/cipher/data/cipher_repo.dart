import '../domain/cipher_algorithm.dart';
import '../domain/cipher_mode.dart';

abstract class CipherRepostitory {
  const CipherRepostitory();

  Future<CipherAlgorithm> getDefaultAlgorithm();
  Future<void> setDefaultAlgorithm(CipherAlgorithm algorithm);

  Future<String> encryptSymmetric(String input, String secretKey, {required CipherAlgorithm algorithm});
  Future<String> decryptSymmetric(String input, String secretKey, {required CipherAlgorithm algorithm});

  Future<String> hash(String input, {required CipherMode mode});
}
