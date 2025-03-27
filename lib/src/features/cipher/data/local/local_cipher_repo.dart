import 'package:cipher_dove/src/constants/_constants.dart';
import 'package:cipher_dove/src/core/_core.dart';
import 'package:cipher_dove/src/features/cipher/data/cipher_repo.dart';
import 'package:cipher_dove/src/features/cipher/domain/cipher_action.dart';
import 'package:cipher_dove/src/features/cipher/domain/cipher_algorithm.dart';
import 'package:cipher_dove/src/features/cipher/domain/cipher_mode.dart';
import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sha3/sha3.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'local_cipher_repo.g.dart';

// TODO abstraction
class LocalCipherRepository extends CipherRepostitory {
  const LocalCipherRepository(
    this._sharedPref,
    this._crypt,
    this._sha3Factory,
  );

  final SharedPreferencesAsync _sharedPref;
  final Cryptography _crypt;
  final SHA3 _sha3Factory;

//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//

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

  String padKey(String key, int keyLength) {
    if (keyLength <= 0) throw ArgumentError('keyLength must be a positive value');
    if (key.length < keyLength) return key.padRight(keyLength, '0'); // Padding
    if (key.length > keyLength) return key.substring(0, keyLength); // Truncating
    return key; // Already the correct length
  }

//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//

// TODO more readable output encryption, by convert raw to hex, and decrypt should then accept the hex and convert it
// back to raw bytes List<int>.
  @override
  Future<String> encryptSymmetric(
    String input,
    String secretKey, {
    required CipherAlgorithm algorithm,
  }) async {
    final key = SecretKey(padKey(secretKey, 32).codeUnits);

    return switch (algorithm) {
      // == CipherAlgorithm.blowfish => await blowfish(input, secretKey, action: CipherAction.encrypt),
      == CipherAlgorithm.aes => await aes(input, key, action: CipherAction.encrypt),
      == CipherAlgorithm.chacha20 => await chacha20(input, key, action: CipherAction.encrypt),
      _ => throw UnsupportedError("CipherAlgorithm not supported."),
    };
  }

  @override
  Future<String> decryptSymmetric(
    String input,
    String secretKey, {
    required CipherAlgorithm algorithm,
  }) async {
    final key = SecretKey(padKey(secretKey, 32).codeUnits);

    return switch (algorithm) {
      // == CipherAlgorithm.blowfish => await blowfish(input, secretKey, action: CipherAction.decrypt),
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
    final algorithm = _crypt.chacha20(macAlgorithm: MacAlgorithm.empty);
    final nonce = '0'.padRight(12, '0');

    if (action == CipherAction.encrypt) {
      final encrypted = await algorithm.encrypt(
        input.codeUnits,
        secretKey: secretKey,
        nonce: nonce.codeUnits.sublist(0, 12),
      );
      return String.fromCharCodes(encrypted.cipherText);
    }

    final decrypted = await algorithm.decrypt(
      SecretBox(input.codeUnits, nonce: nonce.codeUnits.sublist(0, 12), mac: Mac.empty),
      secretKey: secretKey,
    );
    return String.fromCharCodes(decrypted);
  }

//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//

  /// Will always decrypt if not encrypt.
  Future<String> aes(String input, SecretKey secretKey, {required CipherAction action}) async {
    final algorithm = _crypt.aesCbc(macAlgorithm: MacAlgorithm.empty);
    final nonce = '0'.padRight(16, '0');

    if (action == CipherAction.encrypt) {
      final encrypted = await algorithm.encrypt(
        input.codeUnits,
        secretKey: secretKey,
        nonce: nonce.codeUnits.sublist(0, 16),
      );
      return String.fromCharCodes(encrypted.cipherText);
    }

    final decrypted = await algorithm.decrypt(
      SecretBox(input.codeUnits, nonce: nonce.codeUnits.sublist(0, 16), mac: Mac.empty),
      secretKey: secretKey,
    );
    return String.fromCharCodes(decrypted);
  }

//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//

  // TODO asymmetric support
  Future<String> encryptAsymmetric(String input, {required CipherMode mode}) async {
    return "";
  }

  Future<String> decryptAsymmetric(String input, {required CipherMode mode}) async {
    return "";
  }

//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//

  @override
  Future<String> hash(String input, {required CipherMode mode}) async {
    return switch (mode.algorithm) {
      == CipherAlgorithm.md5 => md5.convert(input.codeUnits).toString(),
      == CipherAlgorithm.sha1 => await sha1(input),
      == CipherAlgorithm.sha2 => await sha2(input),
      == CipherAlgorithm.sha3 => await sha3(input),
      == CipherAlgorithm.blake2 => await blake2(input),
      _ => throw UnsupportedError("CipherAlgorithm not supported."),
    };
  }

//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//

  Future<String> sha1(String input) async {
    final algorithm = _crypt.sha1();
    final digest = await algorithm.hash(input.codeUnits);
    // Convert the digest to a hexadecimal string
    return digest.bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  Future<String> sha2(String input) async {
    final algorithm = _crypt.sha256();
    final digest = await algorithm.hash(input.codeUnits);
    // Convert the digest to a hexadecimal string
    return digest.bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  Future<String> sha3(String input) async {
    _sha3Factory.update(input.codeUnits);

    final digest = _sha3Factory.digest();
    // Convert the digest to a hexadecimal string
    return digest.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  }

  Future<String> blake2(String input) async {
    final algorithm = _crypt.blake2b();
    final digest = await algorithm.hash(input.codeUnits);
    // Convert the digest to a hexadecimal string
    return digest.bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
}

@riverpod
LocalCipherRepository localCipherRepository(Ref ref) {
  final sharedPref = ref.watch(sharedPrefProvider);
  final crypt = Cryptography.defaultInstance;
  final sha3Factory = SHA3(256, KECCAK_PADDING, 256);

  return LocalCipherRepository(sharedPref, crypt, sha3Factory);
}
