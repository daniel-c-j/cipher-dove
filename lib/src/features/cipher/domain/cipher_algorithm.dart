import 'package:flutter/material.dart';

enum CipherAlgorithmType {
  symmetric(
    tag: "Symmetric Encryption",
    icon: Icons.arrow_forward_outlined,
  ),
  asymmetric(
    tag: "Asymmetric Encryption",
    icon: Icons.swap_horiz_rounded,
  ),
  hash(
    tag: "Hash",
    icon: Icons.tag_rounded,
  );

  const CipherAlgorithmType({required this.tag, required this.icon});

  final String tag;
  final IconData icon;
}

enum CipherAlgorithm {
  // * symmetric
  blowfish(
    name: "Blowfish",
    detail: "A symmetric-key block cipher designed to be fast and secure.",
    type: CipherAlgorithmType.symmetric,
  ),
  aes(
    name: "AES",
    detail: "Advanced Encryption Standard, a symmetric encryption algorithm.",
    type: CipherAlgorithmType.symmetric,
  ),
  chacha20(
    name: "ChaCha20",
    detail: "A stream cipher designed for high performance and security.",
    type: CipherAlgorithmType.symmetric,
  ),

  // TODO add asymmetric encryption.
  // * asymmetric
  rsa(
    name: "RSA",
    detail: "Rivest-Shamir-Adleman, an asymmetric encryption algorithm.",
    type: CipherAlgorithmType.asymmetric,
    supported: false,
  ),
  dsa(
    name: "DSA",
    detail: "Digital Signature Algorithm, used for digital signatures.",
    type: CipherAlgorithmType.asymmetric,
    supported: false,
  ),
  ecc(
    name: "ECC",
    detail: "Elliptic Curve Cryptography, an asymmetric encryption algorithm.",
    type: CipherAlgorithmType.asymmetric,
    supported: false,
  ),

  // * hash
  md5(
    name: "MD5",
    detail: "A widely used hash function producing a 128-bit hash value.",
    type: CipherAlgorithmType.hash,
  ),
  sha1(
    name: "SHA-1",
    detail: "A cryptographic hash function that produces a 160-bit hash value.",
    type: CipherAlgorithmType.hash,
  ),
  sha2(
    name: "SHA-2",
    detail: "A family of cryptographic hash functions, including SHA-256 and SHA-512.",
    type: CipherAlgorithmType.hash,
  ),
  sha3(
    name: "SHA-3",
    detail: "The latest member of the Secure Hash Algorithm family.",
    type: CipherAlgorithmType.hash,
  ),
  blake2(
    name: "BLAKE2",
    detail: "A cryptographic hash function faster than MD5, SHA-1, and SHA-2.",
    type: CipherAlgorithmType.hash,
  ),
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
}
