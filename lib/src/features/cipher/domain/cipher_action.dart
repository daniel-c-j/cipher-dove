import 'package:cipher_dove/src/constants/_constants.dart';
import 'package:hive_ce/hive.dart';

part 'cipher_action.g.dart';

@HiveType(typeId: DBKeys.CIPHER_ACTION)
enum CipherAction {
  @HiveField(0)
  encrypt,
  @HiveField(1)
  decrypt,
}
