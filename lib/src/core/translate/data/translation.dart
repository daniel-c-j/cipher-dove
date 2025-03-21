// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Translation {
  const Translation({
    required this.original,
    required this.text,
    required this.languageCode,
    required this.language,
  });

  final String original;
  final String text;
  final String? languageCode;
  final String? language;

  /// Whether the translated text differs from the original.
  ///
  /// This is not the case when the translation service is unable to translate
  /// the text.
  bool get isTranslated => original != text;

  Translation copyWith({
    String? original,
    String? text,
    String? languageCode,
    String? language,
  }) {
    return Translation(
      original: original ?? this.original,
      text: text ?? this.text,
      languageCode: languageCode ?? this.languageCode,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'original': original,
      'text': text,
      'languageCode': languageCode,
      'language': language,
    };
  }

  factory Translation.fromMap(Map<String, dynamic> map) {
    return Translation(
      original: map['original'] as String,
      text: map['text'] as String,
      languageCode: map['languageCode'] != null ? map['languageCode'] as String : null,
      language: map['language'] != null ? map['language'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Translation.fromJson(String source) =>
      Translation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Translation(original: $original, text: $text, languageCode: $languageCode, language: $language)';
  }

  @override
  bool operator ==(covariant Translation other) {
    if (identical(this, other)) return true;

    return other.original == original &&
        other.text == text &&
        other.languageCode == languageCode &&
        other.language == language;
  }

  @override
  int get hashCode {
    return original.hashCode ^ text.hashCode ^ languageCode.hashCode ^ language.hashCode;
  }
}
