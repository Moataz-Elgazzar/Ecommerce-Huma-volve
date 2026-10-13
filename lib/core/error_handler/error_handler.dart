import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import 'failure.dart';

class ErrorHandler {
  ErrorHandler._();

  static Failure handle(Object error) {
    if (error is DioException) {
      return _handleDioError(error);
    }

    if (error is SocketException) {
      return const Failure('No internet connection', type: FailureType.noInternet);
    }

    if (error is TimeoutException) {
      return const Failure('The operation timed out', type: FailureType.connectionTimeout);
    }

    if (error is FormatException || error is TypeError) {
      return Failure('Invalid data format', type: FailureType.parsing, details: error);
    }

    return Failure('Something went wrong. Please try again.', details: error);
  }

  static Failure _handleDioError(DioException error) {
    final statusCode = error.response?.statusCode;

    // HTTP response errors take priority.
    if (statusCode != null) {
      return _handleStatusCode(statusCode, error.response?.data);
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Failure('Connection timed out', type: FailureType.connectionTimeout, details: error);

      case DioExceptionType.sendTimeout:
        return Failure('Sending the request timed out', type: FailureType.sendTimeout, details: error);

      case DioExceptionType.receiveTimeout:
        return Failure('Receiving the response timed out', type: FailureType.receiveTimeout, details: error);

      case DioExceptionType.connectionError:
        return Failure('Unable to connect to the server', type: FailureType.noInternet, details: error);

      case DioExceptionType.badCertificate:
        return Failure('Secure connection failed', type: FailureType.badCertificate, details: error);

      case DioExceptionType.cancel:
        return Failure('Request was cancelled', type: FailureType.cancelled, details: error);

      case DioExceptionType.badResponse:
        return Failure('Invalid server response', type: FailureType.unknown, details: error);

      case DioExceptionType.unknown:
        // Dio may wrap a SocketException in error.error.
        if (error.error is SocketException) {
          return Failure('No internet connection', type: FailureType.noInternet, details: error);
        }

        if (error.error is FormatException || error.error is TypeError) {
          return Failure('Invalid data format', type: FailureType.parsing, details: error);
        }

        return Failure('Something went wrong. Please try again.', details: error);
      case DioExceptionType.transformTimeout:
        return Failure('Response transformation timed out', type: FailureType.receiveTimeout, details: error);
    }
  }

  static Failure _handleStatusCode(int statusCode, Object? responseData) {
    final serverMessage = _extractMessage(responseData);

    switch (statusCode) {
      case 400:
        return Failure(serverMessage ?? 'Bad request', code: statusCode, type: FailureType.badRequest);

      case 401:
        return Failure('Unauthorized. Please sign in again.', code: statusCode, type: FailureType.unauthorized);

      case 403:
        return Failure('You do not have permission to perform this action.', code: statusCode, type: FailureType.forbidden);

      case 404:
        return Failure(serverMessage ?? 'Resource not found', code: statusCode, type: FailureType.notFound);

      case 408:
        return Failure('Request timed out', code: statusCode, type: FailureType.connectionTimeout);

      case 409:
        return Failure(serverMessage ?? 'A conflict occurred', code: statusCode, type: FailureType.conflict);

      case 422:
        return Failure(serverMessage ?? 'Please check the submitted data', code: statusCode, type: FailureType.validation);

      case 429:
        return Failure('Too many requests. Please try again later.', code: statusCode, type: FailureType.tooManyRequests);
    }

    if (statusCode >= 500 && statusCode <= 599) {
      return Failure('Server error. Please try again later.', code: statusCode, type: FailureType.server);
    }

    if (statusCode >= 400 && statusCode <= 499) {
      return Failure(serverMessage ?? 'Request failed', code: statusCode, type: FailureType.badRequest);
    }

    return Failure(serverMessage ?? 'Unexpected server response', code: statusCode, details: responseData);
  }

  static String? _extractMessage(Object? data) {
    if (data is! Map) return null;

    const messageKeys = ['message', 'error_description', 'error', 'detail'];

    for (final key in messageKeys) {
      final value = data[key];

      if (value is String && value.trim().isNotEmpty) {
        return value.trim();
      }
    }

    return null;
  }
}
