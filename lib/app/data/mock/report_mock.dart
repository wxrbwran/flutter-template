import 'dart:convert';

class ReportMock {
  String title;
  String icon;
  String type;
  bool isSelect;
  ReportMock({
    required this.title,
    required this.icon,
    required this.type,
    required this.isSelect,
  });

  ReportMock copyWith({
    String? title,
    String? icon,
    String? type,
    bool? isSelect,
  }) {
    return ReportMock(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      type: type ?? this.type,
      isSelect: isSelect ?? this.isSelect,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'icon': icon,
      'type': type,
      'isSelect': isSelect,
    };
  }

  factory ReportMock.fromMap(Map<String, dynamic> map) {
    return ReportMock(
      title: map['title'] ?? '',
      icon: map['icon'] ?? '',
      type: map['type'] ?? '',
      isSelect: map['isSelect'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportMock.fromJson(String source) =>
      ReportMock.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReportMock(title: $title, icon: $icon, type: $type, isSelect: $isSelect)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReportMock &&
        other.title == title &&
        other.icon == icon &&
        other.type == type &&
        other.isSelect == isSelect;
  }

  @override
  int get hashCode {
    return title.hashCode ^ icon.hashCode ^ type.hashCode ^ isSelect.hashCode;
  }
}
