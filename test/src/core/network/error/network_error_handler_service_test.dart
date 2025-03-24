import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cipher_dove/src/exceptions/network_specific/network_error_handler_service.dart';
import 'package:cipher_dove/src/exceptions/app_exception.dart';

import '../../../../mocks.dart';

void main() {
  ProviderContainer makeProviderContainer() {
    final container = ProviderContainer(overrides: [
      // Placeholder
    ]);
    addTearDown(container.dispose);
    return container;
  }

  DioException mockNullResponse() => DioException(
        response: null,
        requestOptions: RequestOptions(),
      );

  DioException mock404Exception() => DioException(
        response: Response(
          statusCode: 404,
          requestOptions: RequestOptions(),
        ),
        requestOptions: RequestOptions(),
      );

  DioException mockNoConnectionException() => DioException(
        requestOptions: RequestOptions(),
        error: NoConnectionException(),
        type: DioExceptionType.connectionTimeout,
      );

  DioException mockUnknownStatCodeException() => DioException(
        response: Response(
          statusCode: 998,
          requestOptions: RequestOptions(),
        ),
        requestOptions: RequestOptions(),
      );

  group("NetworkErrorHandlerService", () {
    test(''''
      Given client request to server but there's an error.
      When error is identified as a NoConnectionException.
      Then get NoConnectionException back..
    ''', () {
      // * Arrange
      final container = makeProviderContainer();

      // * Act
      final exception = container.read(netErrorHandlerProvider).getFailure(mockNoConnectionException());

      // * Assert
      expect(exception, NoConnectionException());
    });

    test(''''
      Given client request to server.
      When throws a known network issue/exception by statuscode.
      Then get the identified exception.
    ''', () {
      // * Arrange
      final container = makeProviderContainer();

      // * Act
      final exception = container.read(netErrorHandlerProvider).getFailure(mock404Exception());

      // * Assert
      expect(exception, NotFoundException());
    });

    test(''''
      Given client request to server.
      When throws a network issue/exception with response of null.
      Then get the UnknownException.
    ''', () {
      // * Arrange
      final container = makeProviderContainer();

      // * Act
      final exception = container.read(netErrorHandlerProvider).getFailure(mockNullResponse());

      // * Assert
      expect(exception, UnknownException());
    });

    test(''''
      Given processing network issue.
      When an unknown error occured.
      Then return the UnknownException.
    ''', () {
      // * Arrange
      final container = makeProviderContainer();

      final mockException = MockDioException();
      when(() => mockException.error).thenThrow(Exception());

      // * Act
      final exception = container.read(netErrorHandlerProvider).getFailure(mockException);

      // * Assert
      expect(exception, UnknownException());
    });

    test(''''
      Given processing network issue.
      When an unknown statuscode.
      Then return CustomException.
    ''', () {
      // * Arrange
      final container = makeProviderContainer();

      // * Act
      final exception = container.read(netErrorHandlerProvider).getFailure(mockUnknownStatCodeException());

      // * Assert
      expect(exception, isA<CustomException>());
    });
  });
}
