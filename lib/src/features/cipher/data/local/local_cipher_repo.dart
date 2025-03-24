import 'package:blowfish/blowfish.dart';
import 'package:cipher_dove/src/features/cipher/domain/cipher_action.dart';
import 'package:cipher_dove/src/features/cipher/domain/cipher_algorithm.dart';
import 'package:cipher_dove/src/features/cipher/domain/cipher_mode.dart';
import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:sha3/sha3.dart';

// TODO abstraction
class LocalCipherRepository {
  final crypt = Cryptography.defaultInstance;
  static const keyLength = 32;

  // TODO warning user about key must be 32 char.
  String padKey(String key) {
    if (key.length < keyLength) return key.padRight(keyLength, '0'); // Padding
    if (key.length > keyLength) return key.substring(0, keyLength); // Truncating
    return key; // Already the correct length
  }

//
// ======================================================================================================
//

  Future<String> encryptSymmetric(
    String input,
    String secretKey, {
    required CipherAlgorithm algorithm,
  }) async {
    final key = SecretKey(padKey(secretKey).codeUnits);

    return switch (algorithm) {
      == CipherAlgorithm.blowfish => await blowfish(input, secretKey, action: CipherAction.encrypt),
      == CipherAlgorithm.aes => await aes(input, key, action: CipherAction.encrypt),
      == CipherAlgorithm.chacha20 => await chacha20(input, key, action: CipherAction.encrypt),
      _ => throw UnsupportedError("CipherAlgorithm not supported."),
    };
  }

  Future<String> decryptSymmetricc(
    String input,
    String secretKey, {
    required CipherAlgorithm algorithm,
  }) async {
    final key = SecretKey(padKey(secretKey).codeUnits);

    return switch (algorithm) {
      == CipherAlgorithm.blowfish => await blowfish(input, secretKey, action: CipherAction.decrypt),
      == CipherAlgorithm.aes => await aes(input, key, action: CipherAction.decrypt),
      == CipherAlgorithm.chacha20 => await chacha20(input, key, action: CipherAction.decrypt),
      _ => throw UnsupportedError("CipherAlgorithm not supported."),
    };
  }

//
// ======================================================================================================
//

  /// Will always decrypt if not encrypt.
  Future<String> chacha20(String input, SecretKey secretKey, {required CipherAction action}) async {
    final chacha20 = crypt.chacha20(macAlgorithm: MacAlgorithm.empty);

    if (action == CipherAction.encrypt) {
      final encrypted = await chacha20.encrypt(
        input.codeUnits,
        secretKey: secretKey,
        nonce: input.codeUnits.sublist(0, 12),
      );
      return String.fromCharCodes(encrypted.cipherText);
    }

    final decrypted = await chacha20.decrypt(
      SecretBox(input.codeUnits, nonce: input.codeUnits.sublist(0, 12), mac: Mac.empty),
      secretKey: secretKey,
    );
    return String.fromCharCodes(decrypted);
  }

//
// ======================================================================================================
//

  /// Will always decrypt if not encrypt.
  Future<String> aes(String input, SecretKey secretKey, {required CipherAction action}) async {
    final aes = crypt.aesCbc(macAlgorithm: MacAlgorithm.empty);

    if (action == CipherAction.encrypt) {
      final encrypted = await aes.encrypt(
        input.codeUnits,
        secretKey: secretKey,
        nonce: input.codeUnits.sublist(0, 16),
      );
      return String.fromCharCodes(encrypted.cipherText);
    }

    final decrypted = await aes.decrypt(
      SecretBox(input.codeUnits, nonce: input.codeUnits.sublist(0, 16), mac: Mac.empty),
      secretKey: secretKey,
    );
    return String.fromCharCodes(decrypted);
  }

//
// ======================================================================================================
//

  /// Will always decrypt if not encrypt.
  Future<String> blowfish(String input, String secretKey, {required CipherAction action}) async {
    final blowfish = Blowfish();

    if (action == CipherAction.encrypt) {
      final encrypted =
          blowfish.encryptCBC(input.codeUnits, input.codeUnits.sublist(0, 8), applyPadding: true);

      return String.fromCharCodes(encrypted);
    }

    final decrypted = blowfish.decryptCBC(input.codeUnits, input.codeUnits.sublist(0, 8), applyPadding: true);
    return String.fromCharCodes(decrypted);
  }

//
// ======================================================================================================
//

  // TODO asymmetric support
  String asymmetric(String input, {required CipherMode mode}) {
    return "";
  }

//
// ======================================================================================================
//

  Future<String> hash(String input, {required CipherMode mode}) async {
    return switch (mode.algorithm) {
      == CipherAlgorithm.md5 => md5.convert(input.codeUnits).toString(),
      == CipherAlgorithm.sha1 => await sha1(input),
      == CipherAlgorithm.sha2 => await sha2(input),
      == CipherAlgorithm.sha3 => await sha3(input),
      _ => throw UnsupportedError("CipherAlgorithm not supported."),
    };
  }

//
// ======================================================================================================
//

  Future<String> sha1(String input) async {
    final algorithm = Sha1();
    final digest = await algorithm.hash(input.codeUnits);
    // Convert the digest to a hexadecimal string
    return digest.bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  Future<String> sha2(String input) async {
    final algorithm = Sha256();
    final digest = await algorithm.hash(input.codeUnits);
    // Convert the digest to a hexadecimal string
    return digest.bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  Future<String> sha3(String input) async {
    final algorithm = SHA3(256, KECCAK_PADDING, 256);
    algorithm.update(input.codeUnits);

    final digest = algorithm.digest();
    // Convert the digest to a hexadecimal string
    return digest.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  }

  Future<String> blake2(String input) async {
    final algorithm = Blake2b();
    final digest = await algorithm.hash(input.codeUnits);
    // Convert the digest to a hexadecimal string
    return digest.bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

//
// ======================================================================================================
//
}
