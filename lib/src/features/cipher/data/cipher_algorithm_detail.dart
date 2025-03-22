import 'package:cipher_dove/src/features/cipher/domain/cipher_algorithm.dart';
import 'package:cipher_dove/src/features/cipher/presentation/cipher_algorithm/components/algorithm_tag.dart';
import 'package:flutter/material.dart';

const List<AlgorithmTag> kAlgorithmTags = [
  AlgorithmTag(tag: "Symmetric Encryption", icon: Icons.arrow_forward_outlined),
  AlgorithmTag(tag: "Asymmetric Encryption", icon: Icons.swap_horiz_rounded),
  AlgorithmTag(tag: "Hash", icon: Icons.tag_rounded),
];

const List<AlgorithmDetail> kAlgorithms = [
  AlgorithmDetail(
    name: "DES",
    detail: "Data Encryption Standard.",
    algorithm: CipherAlgorithm.des,
    type: CipherAlgorithmType.symmetric,
  ),
  AlgorithmDetail(
    name: "Triple DES",
    detail: "Triple Data Encryption Standard.",
    algorithm: CipherAlgorithm.tripleDes,
    type: CipherAlgorithmType.symmetric,
  ),
  AlgorithmDetail(
    name: "Blowfish",
    detail: "A symmetric-key block cipher designed to be fast and secure.",
    algorithm: CipherAlgorithm.blowfish,
    type: CipherAlgorithmType.symmetric,
  ),
  AlgorithmDetail(
    name: "Twofish",
    detail: "A symmetric key block cipher that is a successor to Blowfish.",
    algorithm: CipherAlgorithm.twofish,
    type: CipherAlgorithmType.symmetric,
  ),
  AlgorithmDetail(
    name: "AES",
    detail: "Advanced Encryption Standard, a symmetric encryption algorithm.",
    algorithm: CipherAlgorithm.aes,
    type: CipherAlgorithmType.symmetric,
  ),
  AlgorithmDetail(
    name: "ChaCha20",
    detail: "A stream cipher designed for high performance and security.",
    algorithm: CipherAlgorithm.chacha20,
    type: CipherAlgorithmType.symmetric,
  ),
  AlgorithmDetail(
    name: "Serpent",
    detail: "A symmetric key block cipher that was a finalist in the AES competition.",
    algorithm: CipherAlgorithm.serpent,
    type: CipherAlgorithmType.symmetric,
  ),
  AlgorithmDetail(
    name: "RSA",
    detail: "Rivest-Shamir-Adleman, an asymmetric encryption algorithm.",
    algorithm: CipherAlgorithm.rsa,
    type: CipherAlgorithmType.asymmetric,
  ),
  AlgorithmDetail(
    name: "DSA",
    detail: "Digital Signature Algorithm, used for digital signatures.",
    algorithm: CipherAlgorithm.dsa,
    type: CipherAlgorithmType.asymmetric,
  ),
  AlgorithmDetail(
    name: "ECC",
    detail: "Elliptic Curve Cryptography, an asymmetric encryption algorithm.",
    algorithm: CipherAlgorithm.ecc,
    type: CipherAlgorithmType.asymmetric,
  ),
  AlgorithmDetail(
    name: "MD5",
    detail: "A widely used hash function producing a 128-bit hash value.",
    algorithm: CipherAlgorithm.md5,
    type: CipherAlgorithmType.hash,
  ),
  AlgorithmDetail(
    name: "SHA-1",
    detail: "A cryptographic hash function that produces a 160-bit hash value.",
    algorithm: CipherAlgorithm.sha1,
    type: CipherAlgorithmType.hash,
  ),
  AlgorithmDetail(
    name: "SHA-2",
    detail: "A family of cryptographic hash functions, including SHA-256 and SHA-512.",
    algorithm: CipherAlgorithm.sha2,
    type: CipherAlgorithmType.hash,
  ),
  AlgorithmDetail(
    name: "SHA-3",
    detail: "The latest member of the Secure Hash Algorithm family.",
    algorithm: CipherAlgorithm.sha3,
    type: CipherAlgorithmType.hash,
  ),
  AlgorithmDetail(
    name: "RIPEMD-160",
    detail: "A cryptographic hash function designed for high security.",
    algorithm: CipherAlgorithm.ripeMd160,
    type: CipherAlgorithmType.hash,
  ),
  AlgorithmDetail(
    name: "Whirlpool",
    detail: "A cryptographic hash function that produces a 512-bit hash value.",
    algorithm: CipherAlgorithm.whirlPool,
    type: CipherAlgorithmType.hash,
  ),
  AlgorithmDetail(
    name: "BLAKE2",
    detail: "A cryptographic hash function faster than MD5, SHA-1, and SHA-2.",
    algorithm: CipherAlgorithm.blake2,
    type: CipherAlgorithmType.hash,
  ),
  AlgorithmDetail(
    name: "Argon2",
    detail: "A password-hashing function that won the Password Hashing Competition.",
    algorithm: CipherAlgorithm.argon2,
    type: CipherAlgorithmType.hash,
  ),
];
