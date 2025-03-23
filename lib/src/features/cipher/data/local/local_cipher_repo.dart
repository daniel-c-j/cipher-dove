import 'dart:typed_data';

import 'package:cipher_dove/src/features/cipher/domain/cipher_action.dart';
import 'package:cipher_dove/src/features/cipher/domain/cipher_algorithm.dart';
import 'package:cipher_dove/src/features/cipher/domain/cipher_mode.dart';
import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:dart_pg/dart_pg.dart';

// TODO abstraction
class LocalCipherRepository {
  final crypt = Cryptography.defaultInstance;
  static const keyLength = 32;

  // TODO warning user about key must be 32 char.
  String padKey(String key) {
    if (key.length < keyLength) return key.padRight(keyLength, '0'); // Padding
    if (key.length > keyLength) return key.substring(0, keyLength); // Truncating

    // Already the correct length
    return key;
  }

  Future<String> encryptSymmetric(dynamic input, String secretKey,
      {required CipherAlgorithm algorithm}) async {
    final key = SecretKey(padKey(secretKey).codeUnits);

    return switch (algorithm) {
      == CipherAlgorithm.aes => aes(input, key, action: CipherAction.encrypt),
      == CipherAlgorithm.blowfish => blowfish(input, secretKey, action: CipherAction.encrypt),
      _ => "",
    };
  }

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

  Future<String> blowfish(dynamic input, String secretKey, {required CipherAction action}) async {
    if (action == CipherAction.encrypt) {
      final encrypted = OpenPGP.encryptCleartext(
        input as String,
        symmetric: SymmetricAlgorithm.blowfish,
        passwords: [secretKey],
      );

      return String.fromCharCodes(encrypted.encryptedPacket.encrypted);
    }

    final decrypted = OpenPGP.decryptMessage(
      input,
      passwords: [secretKey],
    ).literalData;
    return String.fromCharCodes(decrypted.binary);
  }

  String decryptSymmetric(String input, {required CipherAlgorithm algorithm}) {
    return "";
  }

  String asymmetric(String input, {required CipherMode mode}) {
    return "";
  }

  String hash(String input, {required CipherMode mode}) {
    return "";
  }
}
