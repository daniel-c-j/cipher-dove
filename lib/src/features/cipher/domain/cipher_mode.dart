// coverage:ignore-file
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cipher_dove/src/features/cipher/domain/cipher_action.dart';
import 'package:cipher_dove/src/features/cipher/domain/cipher_algorithm.dart';

/// Object model that acts as if a guide on what should the app do.
class CipherMode {
  const CipherMode({required this.action, required this.algorithm});
  final CipherAction action;
  final CipherAlgorithm algorithm;

  CipherMode copyWith({
    CipherAction? action,
    CipherAlgorithm? algorithm,
  }) {
    return CipherMode(
      action: action ?? this.action,
      algorithm: algorithm ?? this.algorithm,
    );
  }

  @override
  bool operator ==(covariant CipherMode other) {
    if (identical(this, other)) return true;

    return other.action == action && other.algorithm == algorithm;
  }

  @override
  int get hashCode => action.hashCode ^ algorithm.hashCode;
}
