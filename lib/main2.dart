import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';
import 'package:cryptography_plus/cryptography_plus.dart';

void main() async {
  const input = "Hello Im Emu Otori";
  const sKey = "SuperSecretKeThatShouldBe32Bytes";

  // print(sha2.convert(utf8.encode(input)).toString());

  final crypt = Cryptography.defaultInstance;

  // final aes = await crypt.rsaPss(Sha1(), nonceLengthInBytes: 12);

  // final encrypted = await aes.encrypt(
  //   input.codeUnits,
  //   secretKey: SecretKey(sKey.codeUnits),
  //   nonce: input.codeUnits.sublist(0, 12),
  // );
  // final formatEnc = String.fromCharCodes(encrypted.cipherText);

  // print(formatEnc);

  // final decrypted = await aes.decrypt(
  //   SecretBox(formatEnc.codeUnits, nonce: input.codeUnits.sublist(0, 12), mac: Mac.empty),
  //   secretKey: SecretKey(sKey.codeUnits),
  // );
  // final formatDec = String.fromCharCodes(decrypted);
  // print(formatDec);

  final key = encrypt.Key.fromUtf8('your-32-char-key-here'); // Ensure it's 32 bytes for Twofish

  final iv = encrypt.IV.fromLength(16); // Initialization vector

  // Create an encrypter instance

  // final encrypter = encrypt.Encrypter(encrypt.RSA(key));

  // Encrypt the plain text

  final plainText = 'Hello, Twofish!';

  // final encrypted = encrypter.encrypt(plainText, iv: iv);

  // // Decrypt the encrypted text

  // final decrypted = encrypter.decrypt(encrypted, iv: iv);

  // print('Encrypted: ${encrypted.base64}');

  // print('Decrypted: $decrypted');
}

// Future<String> _calculateSHA256(String t) async {
//   final sha256 = Blake2b();

//   final digest = await sha256.hash(utf8.encode(t));

//   return digest.bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
// }
