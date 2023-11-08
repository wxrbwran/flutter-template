// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:live/app/core/base/base_controller.dart';
import 'package:live/app/core/enum/common_alert_enum.dart';

class CommonAlertModel {
  final String icon;
  final String title;
  final CommonAlertEnum alertEnum;
  final String? organizationProgramId;
  final BaseController? baseController;
  final bool? fromGame;

  /// 用于"游戏结束弹窗"是否隐藏下一个评测按钮
  final bool? finish;
  CommonAlertModel({
    required this.icon,
    required this.title,
    required this.alertEnum,
    this.organizationProgramId,
    this.baseController,
    this.finish,
    this.fromGame,
  });

  CommonAlertModel copyWith({
    String? icon,
    String? title,
    CommonAlertEnum? alertEnum,
    String? organizationProgramId,
    bool? finish,
  }) {
    return CommonAlertModel(
      icon: icon ?? this.icon,
      title: title ?? this.title,
      alertEnum: alertEnum ?? this.alertEnum,
      organizationProgramId:
          organizationProgramId ?? this.organizationProgramId,
      finish: finish ?? this.finish,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'icon': icon,
      'title': title,
      'alertEnum': alertEnum,
      'organizationProgramId': organizationProgramId,
      'finish': finish,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'CommonAlertModel(icon: $icon, title: $title, alertEnum: $alertEnum, organizationProgramId: $organizationProgramId, finish: $finish)';
  }

  @override
  bool operator ==(covariant CommonAlertModel other) {
    if (identical(this, other)) return true;

    return other.icon == icon &&
        other.title == title &&
        other.alertEnum == alertEnum &&
        other.organizationProgramId == organizationProgramId &&
        other.finish == finish;
  }

  @override
  int get hashCode {
    return icon.hashCode ^
        title.hashCode ^
        alertEnum.hashCode ^
        organizationProgramId.hashCode ^
        finish.hashCode;
  }

  factory CommonAlertModel.fromMap(Map<String, dynamic> map) {
    return CommonAlertModel(
      icon: map['icon'] as String,
      title: map['title'] as String,
      alertEnum: map['alertEnum'],
      organizationProgramId: map['organizationProgramId'] != null
          ? map['organizationProgramId'] as String
          : null,
      finish: map['finish'] != null ? map['finish'] as bool : null,
    );
  }

  factory CommonAlertModel.fromJson(String source) =>
      CommonAlertModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
