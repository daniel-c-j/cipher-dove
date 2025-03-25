import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cipher_dove/src/features/version_check/data/remote/remote_version_repo.dart';
import 'package:cipher_dove/src/features/version_check/domain/version_check.dart';

import '../../../exceptions/_exceptions.dart';

part 'version_check_controller.g.dart';

@riverpod
class VersionCheckController extends _$VersionCheckController {
  @override
  FutureOr<void> build() async {
    // Nothing.
  }

  // Be utilizing "state" in order to be responsive when ref.watch() in widgets, but not limited to only
  // ref.watch().
  Future<void> checkData({
    required void Function(VersionCheck val) whenSuccess,
    required void Function(Object e, StackTrace? st) whenError,
  }) async {
    final versionRepo = ref.read(versionCheckRepoProvider);
    late final VersionCheck versionCheck;

    state = const AsyncLoading();
    try {
      versionCheck = await versionRepo.getVersionCheck();
      state = AsyncValue.data(null);

      // Typically calls for a showDialog widget.
      return whenSuccess(versionCheck);
      //
    } catch (e) {
      // Throws custom exception.
      final error = state.asError?.error;
      return _handleErrors(error, whenError: whenError);
    }
  }

  void _handleErrors(
    Object? error, {
    required void Function(AppException e, StackTrace? st) whenError,
  }) {
    if (error is DioException) {
      final netError = ref.read(netErrorHandlerProvider).handle(error);
      return whenError(netError, state.stackTrace);
    }

    // Doesn't care what kind of exception, just return the formatted one.
    return whenError(UpdateCheckException(), state.stackTrace);
  }

  @visibleForTesting
  void handleErrors(Object? error, {required void Function(Object e, StackTrace? st) whenError}) =>
      _handleErrors(error, whenError: whenError);
}
