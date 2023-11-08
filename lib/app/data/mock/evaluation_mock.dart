import 'dart:convert';

import 'package:flutter/foundation.dart';

class EvaluationMock {
  String title;
  String icon;
  bool finished;
  String type;
  bool isPlaceHolder;
  bool isLast;
  bool isSelected;
  EvaluationMock({
    required this.title,
    required this.icon,
    required this.finished,
    required this.type,
    required this.isPlaceHolder,
    required this.isLast,
    required this.isSelected,
  });

  EvaluationMock copyWith({
    String? title,
    String? icon,
    bool? finished,
    String? type,
    bool? isPlaceHolder,
    bool? isLast,
    bool? isSelected,
  }) {
    return EvaluationMock(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      finished: finished ?? this.finished,
      type: type ?? this.type,
      isPlaceHolder: isPlaceHolder ?? this.isPlaceHolder,
      isLast: isLast ?? this.isLast,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'icon': icon,
      'finished': finished,
      'type': type,
      'isPlaceHolder': isPlaceHolder,
      'isLast': isLast,
      'isSelected': isSelected,
    };
  }

  factory EvaluationMock.fromMap(Map<String, dynamic> map) {
    return EvaluationMock(
      title: map['title'] ?? '',
      icon: map['icon'] ?? '',
      finished: map['finished'] ?? false,
      type: map['type'] ?? '',
      isPlaceHolder: map['isPlaceHolder'] ?? false,
      isLast: map['isLast'] ?? false,
      isSelected: map['isSelected'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory EvaluationMock.fromJson(String source) =>
      EvaluationMock.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EvaluationMock(title: $title, icon: $icon, finished: $finished, type: $type, isPlaceHolder: $isPlaceHolder, isLast: $isLast, isSelected: $isSelected)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EvaluationMock &&
        other.title == title &&
        other.icon == icon &&
        other.finished == finished &&
        other.type == type &&
        other.isPlaceHolder == isPlaceHolder &&
        other.isLast == isLast &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        icon.hashCode ^
        finished.hashCode ^
        type.hashCode ^
        isPlaceHolder.hashCode ^
        isLast.hashCode ^
        isSelected.hashCode;
  }
}
