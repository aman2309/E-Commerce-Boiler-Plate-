import 'package:dio/dio.dart';

import 'package:flutter_boilerplate/core/exceptions/api_exception.dart';

class ExceptionHandler {
  ExceptionHandler._();

  static Exception handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return TimeoutException(
            message: getLocalizedMessage(error),
          );
        case DioExceptionType.connectionError:
          return NetworkException(
            message: 'No internet connection. Please check your network.',
          );
        case DioExceptionType.badResponse:
          return _handleBadResponse(error.response);
        case DioExceptionType.cancel:
          return ApiException(message: 'Request was cancelled.');
        case DioExceptionType.badCertificate:
          return ApiException(
            message: 'Bad certificate. Please try again later.',
          );
        case DioExceptionType.unknown:
          return ApiException(
            message: 'An unexpected error occurred. Please try again.',
          );
        default:
          return ApiException(
            message: 'An unexpected error occurred.',
          );
      }
    }

    if (error is Exception) return error;

    return ApiException(message: 'An unexpected error occurred.');
  }

  static Exception _handleBadResponse(Response? response) {
    if (response == null) {
      return ServerException(message: 'No response from server.');
    }

    final statusCode = response.statusCode;
    final data = response.data;
    final message = _extractMessage(data);

    switch (statusCode) {
      case 400:
        return BadRequestException(message: message ?? 'Bad request.');
      case 401:
        return UnauthorizedException(
          message: message ?? 'Session expired. Please login again.',
        );
      case 403:
        return UnauthorizedException(
          message: message ?? 'You do not have permission.',
        );
      case 404:
        return ApiException(
          message: message ?? 'Resource not found.',
          statusCode: statusCode,
        );
      case 422:
        final errors = data is Map<String, dynamic> ? data['errors'] : null;
        return ValidationException(
          message: message ?? 'Validation failed.',
          errors: errors is Map<String, dynamic> ? errors : null,
        );
      case 500:
        return ServerException(
          message: message ?? 'Internal server error.',
        );
      default:
        return ApiException(
          message: message ?? 'Something went wrong.',
          statusCode: statusCode,
        );
    }
  }

  static String? _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] as String? ?? data['error'] as String?;
    }
    return null;
  }

  static String getLocalizedMessage(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return 'Connection timed out. Please check your internet.';
        case DioExceptionType.connectionError:
          return 'No internet connection.';
        case DioExceptionType.cancel:
          return 'Request was cancelled.';
        case DioExceptionType.badCertificate:
          return 'Security certificate error.';
        case DioExceptionType.unknown:
          return 'An unexpected error occurred.';
        case DioExceptionType.badResponse:
          return _handleBadResponse(error.response).toString();
        default:
          return 'An unexpected error occurred.';
      }
    }

    if (error is ApiException) return error.message;
    if (error is NetworkException) return error.message;
    if (error is UnauthorizedException) return error.message;
    if (error is ValidationException) return error.message;
    if (error is ServerException) return error.message;
    if (error is TimeoutException) return error.message;
    if (error is CacheException) return error.message;
    if (error is BadRequestException) return error.message;

    return 'An unexpected error occurred.';
  }
}
