// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cipher_action.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CipherActionAdapter extends TypeAdapter<CipherAction> {
  @override
  final int typeId = 0;

  @override
  CipherAction read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CipherAction.encrypt;
      case 1:
        return CipherAction.decrypt;
      default:
        return CipherAction.encrypt;
    }
  }

  @override
  void write(BinaryWriter writer, CipherAction obj) {
    switch (obj) {
      case CipherAction.encrypt:
        writer.writeByte(0);
      case CipherAction.decrypt:
        writer.writeByte(1);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CipherActionAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
