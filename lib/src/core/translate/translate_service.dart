import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../_core.dart';

part 'translate_service.g.dart';

// TODO use this, or delete this, depends on using localizations or not, if yes, hardcoded, or thirdparty? If hardcoded, delete this.
/// Remote third-party translation service utility.
class TranslateService {
  const TranslateService(this._ref);

  final Ref _ref;

  static const String endpoint = "https://translate.google.com/translate_a/single";
  static const Duration _timeout = Duration(seconds: 10);

  Future<Translation> translate({
    required String text,
    required String to,
    String from = 'auto',
  }) async {
    final params = {
      'client': 'gtx',
      'sl': from,
      'tl': to,
      'dt': 't',
      'q': text,
      'ie': 'UTF-8',
      'oe': 'UTF-8',
    };

    return await _ref
        .read(apiServiceProvider)
        .get(url: endpoint, queryParameters: params)
        .timeout(_timeout)
        .then(_validateResponse)
        .then(_transformResponse);
  }

  Future<Response> _validateResponse(Response response) async {
    try {
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response;
      }

      return Future.error(response);
      //
    } catch (e) {
      return Future.error(response);
    }
  }

  Translation _transformResponse(Response response) {
    final body = jsonDecode(response.data) as List<dynamic>;

    final original = StringBuffer();
    final translated = StringBuffer();

    for (final translationText in body[0] as List<dynamic>) {
      original.write((translationText as List<dynamic>)[1]);
      translated.write(translationText[0]);
    }

    return Translation(
      original: original.toString(),
      text: translated.toString(),
      // ignore: avoid_dynamic_calls
      languageCode: body.last[0][0] as String?,
      // ignore: avoid_dynamic_calls
      language: kTranslateLanguages[body.last[0][0]],
    );
  }
}

@Riverpod(keepAlive: true)
TranslateService translateService(Ref ref) {
  return TranslateService(ref);
}
