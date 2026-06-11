import 'dart:convert';
import 'package:dio/dio.dart';
import 'api_erro_model.dart';
import 'api_errors.dart';

enum DataSource {
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTORISED = 401; // failure, user is not authorised
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found
  static const int API_LOGIC_ERROR = 422; // API, LOGIC ERROR

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String NO_CONTENT = ApiErrors.noContent;
  static const String BAD_REQUEST = ApiErrors.badRequestError;
  static const String UNAUTORISED = ApiErrors.unauthorizedError;
  static const String FORBIDDEN = ApiErrors.forbiddenError;
  static const String INTERNAL_SERVER_ERROR = ApiErrors.internalServerError;
  static const String NOT_FOUND = ApiErrors.notFoundError;

  // local status code
  static const String CONNECT_TIMEOUT = ApiErrors.timeoutError;
  static const String CANCEL = ApiErrors.defaultError;
  static const String RECIEVE_TIMEOUT = ApiErrors.timeoutError;
  static const String SEND_TIMEOUT = ApiErrors.timeoutError;
  static const String CACHE_ERROR = ApiErrors.cacheError;
  static const String NO_INTERNET_CONNECTION = ApiErrors.noInternetError;
  static const String DEFAULT = ApiErrors.defaultError;
}

extension DataSourceExtension on DataSource {
  ApiErroModel getFailure() {
    switch (this) {
      case DataSource.NO_CONTENT:
        return ApiErroModel(
          status: false,
          statusCode: ResponseCode.NO_CONTENT,
          message: ResponseMessage.NO_CONTENT,
          data: null,
        );
      case DataSource.BAD_REQUEST:
        return ApiErroModel(
          status: false,
          statusCode: ResponseCode.BAD_REQUEST,
          message: ResponseMessage.BAD_REQUEST,
          data: null,
        );
      case DataSource.FORBIDDEN:
        return ApiErroModel(
          status: false,
          statusCode: ResponseCode.FORBIDDEN,
          message: ResponseMessage.FORBIDDEN,
          data: null,
        );
      case DataSource.UNAUTORISED:
        return ApiErroModel(
          status: false,
          statusCode: ResponseCode.UNAUTORISED,
          message: ResponseMessage.UNAUTORISED,
          data: null,
        );
      case DataSource.NOT_FOUND:
        return ApiErroModel(
          status: false,
          statusCode: ResponseCode.NOT_FOUND,
          message: ResponseMessage.NOT_FOUND,
          data: null,
        );
      case DataSource.INTERNAL_SERVER_ERROR:
        return ApiErroModel(
          status: false,
          statusCode: ResponseCode.INTERNAL_SERVER_ERROR,
          message: ResponseMessage.INTERNAL_SERVER_ERROR,
          data: null,
        );
      case DataSource.CONNECT_TIMEOUT:
        return ApiErroModel(
          status: false,
          statusCode: ResponseCode.CONNECT_TIMEOUT,
          message: ResponseMessage.CONNECT_TIMEOUT,
          data: null,
        );
      case DataSource.CANCEL:
        return ApiErroModel(
          status: false,
          statusCode: ResponseCode.CANCEL,
          message: ResponseMessage.CANCEL,
          data: null,
        );
      case DataSource.RECIEVE_TIMEOUT:
        return ApiErroModel(
          status: false,
          statusCode: ResponseCode.RECIEVE_TIMEOUT,
          message: ResponseMessage.RECIEVE_TIMEOUT,
          data: null,
        );
      case DataSource.SEND_TIMEOUT:
        return ApiErroModel(
          status: false,
          statusCode: ResponseCode.SEND_TIMEOUT,
          message: ResponseMessage.SEND_TIMEOUT,
          data: null,
        );
      case DataSource.CACHE_ERROR:
        return ApiErroModel(
          status: false,
          statusCode: ResponseCode.CACHE_ERROR,
          message: ResponseMessage.CACHE_ERROR,
          data: null,
        );
      case DataSource.NO_INTERNET_CONNECTION:
        return ApiErroModel(
          status: false,
          statusCode: ResponseCode.NO_INTERNET_CONNECTION,
          message: ResponseMessage.NO_INTERNET_CONNECTION,
          data: null,
        );
      case DataSource.DEFAULT:
        return ApiErroModel(
          status: false,
          statusCode: ResponseCode.DEFAULT,
          message: ResponseMessage.DEFAULT,
          data: null,
        );
    }
  }
}

class ErrorHandler implements Exception {
  late ApiErroModel failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // dio error so its an error from response of the API or from dio itself
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

ApiErroModel _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFailure();
    case DioExceptionType.badResponse:
    case DioExceptionType.unknown:
      if (error.response != null && error.response?.data != null) {
        try {
          final dynamic rawData = error.response!.data;
          Map<String, dynamic> jsonMap = {};

          if (rawData is Map) {
            jsonMap = Map<String, dynamic>.from(rawData);
          } else if (rawData is String) {
            try {
              final decoded = jsonDecode(rawData);
              if (decoded is Map) {
                jsonMap = Map<String, dynamic>.from(decoded);
              }
            } catch (_) {}
          }

          if (jsonMap.isNotEmpty) {
            String message = 'Something went wrong, try again later';
            if (jsonMap['message'] != null && jsonMap['message'] is String) {
              message = jsonMap['message'];
            }

            if (jsonMap['errors'] != null && jsonMap['errors'] is Map) {
              final Map errors = jsonMap['errors'];
              if (errors.isNotEmpty) {
                final firstErr = errors.values.first;
                if (firstErr is List && firstErr.isNotEmpty) {
                  message = firstErr.first.toString();
                } else if (firstErr != null) {
                  message = firstErr.toString();
                }
              }
            } else if (jsonMap['error'] != null && jsonMap['error'] is String) {
              message = jsonMap['error'];
            }

            bool status = false;
            if (jsonMap['status'] is bool) {
              status = jsonMap['status'] as bool;
            } else if (jsonMap['status'] is String) {
              status = jsonMap['status'] == 'true';
            }

            int statusCode = error.response?.statusCode ?? 400;
            if (jsonMap['status_code'] is num) {
              statusCode = (jsonMap['status_code'] as num).toInt();
            } else if (jsonMap['status_code'] is String) {
              statusCode = int.tryParse(jsonMap['status_code']) ?? statusCode;
            }

            return ApiErroModel(
              status: status,
              statusCode: statusCode,
              message: message,
              data: jsonMap['data'],
            );
          }
          return DataSource.DEFAULT.getFailure();
        } catch (_) {
          String fallbackMessage = 'Something went wrong, try again later';
          try {
            final dynamic rawData = error.response?.data;
            if (rawData is Map && rawData['message'] != null) {
              fallbackMessage = rawData['message'].toString();
            } else if (rawData is String) {
              final decoded = jsonDecode(rawData);
              if (decoded is Map && decoded['message'] != null) {
                fallbackMessage = decoded['message'].toString();
              }
            }
          } catch (_) {}

          return ApiErroModel(
            status: false,
            statusCode: error.response?.statusCode ?? 400,
            message: fallbackMessage,
            data: null,
          );
        }
      } else {
        return DataSource.DEFAULT.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.DEFAULT.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.DEFAULT.getFailure();
  }
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
