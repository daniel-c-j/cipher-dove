import 'dart:typed_data';
import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:dart_pg/dart_pg.dart';
import 'package:encrypt/encrypt.dart';

void main() async {
  const input = "Hello Im Emu Otori";
  const sKey = "SuperSecretKeThatShouldBe32Bytes";

  // final crypt = Cryptography.defaultInstance;
  // final aes = crypt.aesCbc(macAlgorithm: MacAlgorithm.empty);

  // final encrypted = await aes.encrypt(
  //   input.codeUnits,
  //   secretKey: SecretKey(key.codeUnits),
  //   nonce: input.codeUnits.sublist(0, 16),
  // );
  // final formatEnc = String.fromCharCodes(encrypted.cipherText);

  // print(formatEnc);

  // final decrypted = await aes.decrypt(
  //   SecretBox(formatEnc.codeUnits, nonce: input.codeUnits.sublist(0, 16), mac: Mac.empty),
  //   secretKey: SecretKey(key.codeUnits),
  // );
  // final formatDec = String.fromCharCodes(decrypted);

  // print(formatDec);
  final hello = OpenPGP.encryptCleartext(
    input,
    symmetric: SymmetricAlgorithm.blowfish,
    passwords: [sKey],
  );

  final hell = String.fromCharCodes(hello.encryptedPacket.encrypted);
  print(hell);

  final menno = SymEncryptedDataPacket(Uint8List.fromList(hell.codeUnits),
          packets: PacketList([LiteralDataPacket.fromBytes(Uint8List.fromList(hell.codeUnits))]))
      .decrypt(
        Uint8List.fromList(sKey.codeUnits),
        SymmetricAlgorithm.blowfish,
      )
      .packets?[0]
      .data;

  // final menno = OpenPGP.decryptMessage(
  // EncryptedMessage(PacketList.decode(Uint8List.fromList(hell.codeUnits))),
  // passwords: [sKey],
  // )
  // .literalData
  // ;
  // final menno =
  //     hello.encryptedPacket.decrypt(Uint8List.fromList(sKey.codeUnits), SymmetricAlgorithm.blowfish);

  final menn = String.fromCharCodes(menno!);
  print("");
  print(menn);
}
