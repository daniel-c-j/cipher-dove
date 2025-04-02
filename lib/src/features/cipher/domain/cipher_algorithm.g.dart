// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cipher_algorithm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CipherAlgorithmTypeAdapter extends TypeAdapter<CipherAlgorithmType> {
  @override
  final int typeId = 1;

  @override
  CipherAlgorithmType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CipherAlgorithmType.symmetric;
      case 1:
        return CipherAlgorithmType.asymmetric;
      case 2:
        return CipherAlgorithmType.hash;
      default:
        return CipherAlgorithmType.symmetric;
    }
  }

  @override
  void write(BinaryWriter writer, CipherAlgorithmType obj) {
    switch (obj) {
      case CipherAlgorithmType.symmetric:
        writer.writeByte(0);
      case CipherAlgorithmType.asymmetric:
        writer.writeByte(1);
      case CipherAlgorithmType.hash:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CipherAlgorithmTypeAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

class CipherAlgorithmAdapter extends TypeAdapter<CipherAlgorithm> {
  @override
  final int typeId = 2;

  @override
  CipherAlgorithm read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CipherAlgorithm.aes;
      case 1:
        return CipherAlgorithm.chacha20;
      case 2:
        return CipherAlgorithm.rsa;
      case 3:
        return CipherAlgorithm.dsa;
      case 4:
        return CipherAlgorithm.ecc;
      case 5:
        return CipherAlgorithm.md5;
      case 6:
        return CipherAlgorithm.sha1;
      case 7:
        return CipherAlgorithm.sha2;
      case 8:
        return CipherAlgorithm.sha3;
      case 9:
        return CipherAlgorithm.blake2;
      case 10:
        return CipherAlgorithm.argon2;
      default:
        return CipherAlgorithm.aes;
    }
  }

  @override
  void write(BinaryWriter writer, CipherAlgorithm obj) {
    switch (obj) {
      case CipherAlgorithm.aes:
        writer.writeByte(0);
      case CipherAlgorithm.chacha20:
        writer.writeByte(1);
      case CipherAlgorithm.rsa:
        writer.writeByte(2);
      case CipherAlgorithm.dsa:
        writer.writeByte(3);
      case CipherAlgorithm.ecc:
        writer.writeByte(4);
      case CipherAlgorithm.md5:
        writer.writeByte(5);
      case CipherAlgorithm.sha1:
        writer.writeByte(6);
      case CipherAlgorithm.sha2:
        writer.writeByte(7);
      case CipherAlgorithm.sha3:
        writer.writeByte(8);
      case CipherAlgorithm.blake2:
        writer.writeByte(9);
      case CipherAlgorithm.argon2:
        writer.writeByte(10);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CipherAlgorithmAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
