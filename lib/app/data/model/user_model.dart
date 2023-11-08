import 'dart:convert';

class UserModel {
  final int id;
  final String? fullName;
  final int? gender;
  final String? dob;
  final String countryCallingCode;
  final String mobile;
  final String? diagnosis;
  final int type;
  final int? educationLevel;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String accessToken;
  final String refreshToken;
  UserModel({
    required this.id,
    this.fullName,
    this.gender,
    this.dob,
    required this.countryCallingCode,
    required this.mobile,
    this.diagnosis,
    required this.type,
    this.educationLevel,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.accessToken,
    required this.refreshToken,
  });

  UserModel copyWith({
    int? id,
    String? fullName,
    int? gender,
    String? dob,
    String? countryCallingCode,
    String? mobile,
    String? diagnosis,
    int? type,
    int? educationLevel,
    int? status,
    String? createdAt,
    String? updatedAt,
    String? accessToken,
    String? refreshToken,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      countryCallingCode: countryCallingCode ?? this.countryCallingCode,
      mobile: mobile ?? this.mobile,
      diagnosis: diagnosis ?? this.diagnosis,
      type: type ?? this.type,
      educationLevel: educationLevel ?? this.educationLevel,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'gender': gender,
      'dob': dob,
      'countryCallingCode': countryCallingCode,
      'mobile': mobile,
      'diagnosis': diagnosis,
      'type': type,
      'educationLevel': educationLevel,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt() ?? 0,
      fullName: map['fullName'],
      gender: map['gender']?.toInt(),
      dob: map['dob'],
      countryCallingCode: map['countryCallingCode'] ?? '',
      mobile: map['mobile'] ?? '',
      diagnosis: map['diagnosis'],
      type: map['type']?.toInt() ?? 0,
      educationLevel: map['educationLevel']?.toInt(),
      status: map['status']?.toInt() ?? 0,
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      accessToken: map['accessToken'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, fullName: $fullName, gender: $gender, dob: $dob, countryCallingCode: $countryCallingCode, mobile: $mobile, diagnosis: $diagnosis, type: $type, educationLevel: $educationLevel, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.fullName == fullName &&
        other.gender == gender &&
        other.dob == dob &&
        other.countryCallingCode == countryCallingCode &&
        other.mobile == mobile &&
        other.diagnosis == diagnosis &&
        other.type == type &&
        other.educationLevel == educationLevel &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        gender.hashCode ^
        dob.hashCode ^
        countryCallingCode.hashCode ^
        mobile.hashCode ^
        diagnosis.hashCode ^
        type.hashCode ^
        educationLevel.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        accessToken.hashCode ^
        refreshToken.hashCode;
  }
}
