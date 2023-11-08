import 'dart:convert';

import 'package:live/app/core/utils/model_factory.dart';

class ResponseModel<T> {
  bool success;
  ErrorModel? error;
  T? data;
  ResponseModel({
    required this.success,
    this.error,
    this.data,
  });

  ResponseModel<T> copyWith({
    bool? success,
    ErrorModel? error,
    T? data,
  }) {
    return ResponseModel<T>(
      success: success ?? this.success,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'error': error?.toMap(),
      'data': data,
    };
  }

  static ResponseModel? fromMap<T>(Map<String, dynamic>? map) {
    if (map == null) return null;
    ResponseModel res = ResponseModel(
      success: map['success'] ?? map['status'],
      error: map['error'],
    );
    if (res.success && map['data'] != null) {
      if (T.toString() == "Map<String, dynamic>" ||
          T.toString() == "Map<dynamic, dynamic>" ||
          T.toString() == "String") {
        res.data = map["data"];
      } else {
        if (map['data'] is List) {
          res.data = ModelFactory.generateObj<T>(map['data']);
        } else {
          // if (map['data']['list'] == null) {
          //   res.data = ModelFactory.generateObj<T>(map['data']);
          // } else {
          //   res.data = ModelFactory.generateObj<T>(map['data']['list']);
          // }
          if (map['data']['list'] != null && map['data']['list'] is List) {
            res.data = ModelFactory.generateObj<T>(map['data']['list']);
          } else {
            res.data = ModelFactory.generateObj<T>(map['data']);
          }
        }
      }
      return res;
    } else if ((res.success) && map['rows'] != null) {
      if (map['rows'] is List) {
        res.data = ModelFactory.generateObj<T>(map['rows']);
      }
      return res;
    } else if ((res.success) && map['transaction'] != null) {
      res.data = ModelFactory.generateObj<T>(map['transaction']);
      return res;
    } else {
      res.data = null;
      return res;
    }
  }

  String toJson() => json.encode(toMap());

  // factory ResponseModel.fromJson(String source) =>
  //     ResponseModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ResponseModel(success: $success, error: $error, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResponseModel<T> &&
        other.success == success &&
        other.error == error &&
        other.data == data;
  }

  @override
  int get hashCode => success.hashCode ^ error.hashCode ^ data.hashCode;
}

class ErrorModel {
  int code;
  String message;
  String? details;
  int status;
  ErrorModel({
    required this.code,
    required this.message,
    required this.details,
    required this.status,
  });

  ErrorModel copyWith({
    int? code,
    String? message,
    String? details,
    int? status,
  }) {
    return ErrorModel(
      code: code ?? this.code,
      message: message ?? this.message,
      details: details ?? this.details,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'message': message,
      'details': details,
      'status': status,
    };
  }

  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    return ErrorModel(
      code: map['code']?.toInt() ?? 0,
      message: map['message'] ?? '',
      details: map['details'],
      status: map['status']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorModel.fromJson(String source) =>
      ErrorModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ErrorModel(code: $code, message: $message, details: $details, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ErrorModel &&
        other.code == code &&
        other.message == message &&
        other.details == details &&
        other.status == status;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        message.hashCode ^
        details.hashCode ^
        status.hashCode;
  }
}
