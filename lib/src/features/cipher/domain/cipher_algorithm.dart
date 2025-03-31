// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cipher_dove/src/constants/_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';

part 'cipher_algorithm.g.dart';

// TODO Localizations for those stringDetail.

@HiveType(typeId: DBKeys.CIPHER_ALROGITHM_TYPE)
enum CipherAlgorithmType {
  @HiveField(0)
  symmetric(
    tag: "Symmetric Encryption",
    icon: Icons.arrow_forward_outlined,
  ),
  @HiveField(1)
  asymmetric(
    tag: "Asymmetric Encryption",
    icon: Icons.swap_horiz_rounded,
  ),
  @HiveField(2)
  hash(
    tag: "Hash",
    icon: Icons.tag_rounded,
  );

  const CipherAlgorithmType({required this.tag, required this.icon});

  final String tag;
  final IconData icon;

  String get stringDetail => tag.tr();
}

@HiveType(typeId: DBKeys.CIPHER_ALROGITHM)
enum CipherAlgorithm {
  // * symmetric
  @HiveField(0)
  aes(
    name: "AES",
    detail: "Advanced Encryption Standard, a symmetric encryption algorithm.",
    type: CipherAlgorithmType.symmetric,
  ),
  @HiveField(1)
  chacha20(
    name: "ChaCha20",
    detail: "A stream cipher designed for high performance and security.",
    type: CipherAlgorithmType.symmetric,
  ),

  // TODO add asymmetric encryption. (supported: true)
  // * asymmetric
  @HiveField(2)
  rsa(
    name: "RSA",
    detail: "Rivest-Shamir-Adleman, an asymmetric encryption algorithm.",
    type: CipherAlgorithmType.asymmetric,
    supported: false,
  ),
  @HiveField(3)
  dsa(
    name: "DSA",
    detail: "Digital Signature Algorithm, used for digital signatures.",
    type: CipherAlgorithmType.asymmetric,
    supported: false,
  ),
  @HiveField(4)
  ecc(
    name: "ECC",
    detail: "Elliptic Curve Cryptography, an asymmetric encryption algorithm.",
    type: CipherAlgorithmType.asymmetric,
    supported: false,
  ),

  // * hash
  @HiveField(5)
  md5(
    name: "MD5",
    detail: "A widely used hash function producing a 128-bit hash value.",
    type: CipherAlgorithmType.hash,
  ),
  @HiveField(6)
  sha1(
    name: "SHA-1",
    detail: "A cryptographic hash function that produces a 160-bit hash value.",
    type: CipherAlgorithmType.hash,
  ),
  @HiveField(7)
  sha2(
    name: "SHA-2",
    detail: "A family of cryptographic hash functions, including SHA-256 and SHA-512.",
    type: CipherAlgorithmType.hash,
  ),
  @HiveField(8)
  sha3(
    name: "SHA-3",
    detail: "The latest member of the Secure Hash Algorithm family.",
    type: CipherAlgorithmType.hash,
  ),
  @HiveField(9)
  blake2(
    name: "BLAKE2",
    detail: "A cryptographic hash function faster than MD5, SHA-1, and SHA-2.",
    type: CipherAlgorithmType.hash,
  ),
  @HiveField(10)
  argon2(
    name: "Argon2",
    detail: "A password-hashing function that won the Password Hashing Competition.",
    type: CipherAlgorithmType.hash,
    supported: false, // Not yet.
  );

  const CipherAlgorithm({
    required this.name,
    required this.detail,
    required this.type,
    this.supported = true,
  });

  final String name;
  final String detail;
  final CipherAlgorithmType type;
  final bool supported;

  static List<CipherAlgorithm> get(CipherAlgorithmType type) {
    return CipherAlgorithm.values.where((CipherAlgorithm alg) => alg.type == type).toList();
  }

  /// Exists for the sole purpose of maintaining the enum's const behaviour, while
  /// using method.
  String get stringDetail => detail.tr();
}
