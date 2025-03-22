// ignore_for_file: public_member_api_docs, sort_constructors_first
class AlgorithmDetail {
  const AlgorithmDetail(
      {required this.name, required this.detail, required this.algorithm, required this.type});

  final String name;
  final String detail;
  final CipherAlgorithm algorithm;
  final CipherAlgorithmType type;

  @override
  bool operator ==(covariant AlgorithmDetail other) {
    if (identical(this, other)) return true;

    return other.name == name && other.algorithm == algorithm && other.type == type;
  }

  @override
  int get hashCode => name.hashCode ^ algorithm.hashCode ^ type.hashCode;
}

enum CipherAlgorithm {
  // * symmetric
  des,
  tripleDes,
  blowfish,
  twofish,
  aes,
  chacha20,
  serpent,

  // * asymmetric
  rsa,
  dsa,
  ecc,

  // * hash
  md5,
  sha1,
  sha2,
  sha3,
  ripeMd160,
  whirlPool,
  blake2,
  argon2,
}

enum CipherAlgorithmType {
  symmetric,
  asymmetric,
  hash,
}
