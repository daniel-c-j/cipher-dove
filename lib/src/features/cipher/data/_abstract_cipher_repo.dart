// coverage:ignore-file
import '../domain/cipher_algorithm.dart';
import '../domain/cipher_mode.dart';

abstract class CipherRepository {
  const CipherRepository();

  Future<String> encryptSymmetric(String input, String secretKey, {required CipherAlgorithm algorithm});
  Future<String> decryptSymmetric(String input, String secretKey, {required CipherAlgorithm algorithm});

  // TODO asymmetric

  Future<String> hash(String input, {required CipherMode mode});
}

abstract class DefaultCipherRepository {
  const DefaultCipherRepository();

  Future<CipherAlgorithm> getDefaultAlgorithm();
  Future<void> setDefaultAlgorithm(CipherAlgorithm algorithm);
}
