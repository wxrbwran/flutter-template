import 'dart:convert';

class ErrorModel {
  int? code;
  String? message;
  ErrorModel({
    this.code,
    this.message,
  });

  ErrorModel copyWith({
    int? code,
    String? message,
  }) {
    return ErrorModel(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'message': message,
    };
  }

  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    return ErrorModel(
      code: map['code'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorModel.fromJson(String source) =>
      ErrorModel.fromMap(json.decode(source));

  @override
  String toString() => 'ErrorModel(code: $code, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ErrorModel &&
        other.code == code &&
        other.message == message;
  }

  @override
  int get hashCode => code.hashCode ^ message.hashCode;
}
