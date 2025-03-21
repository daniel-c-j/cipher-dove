import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '_exceptions.dart';

part 'error_logger.g.dart';

class ErrorLogger {
  final _log = Logger();

  void logError(Object error, StackTrace? stackTrace) {
    // * Optional to be replaced with a crash reporting tool. (Sentry, Crashlytics, etc.)
    if (kReleaseMode) {
      // TODO Watchout
    }

    _log.f('ERROR', error: error, stackTrace: stackTrace);
  }

  void logAppException(AppException exception) {
    // * Optional to be replaced with a crash reporting tool. (Sentry, Crashlytics, etc.)
    if (kReleaseMode) {
      // TODO Watchout
    }

    _log.w('', error: exception);
  }
}

// Basic usage would be:
// try {}
// catch (e, st) {
//    ref.read(errorLoggerProvider).logError(e, st);
// }

@riverpod
ErrorLogger errorLogger(Ref ref) {
  return ErrorLogger();
}
