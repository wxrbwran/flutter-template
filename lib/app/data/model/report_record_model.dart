import 'dart:convert';

class ReportRecordModel {
  final int id;
  final int organizationProgramId;
  final String finishDate;
  final String organizationProgramName;
  final bool isSelected;
  ReportRecordModel({
    required this.id,
    required this.organizationProgramId,
    required this.finishDate,
    required this.organizationProgramName,
    required this.isSelected,
  });

  ReportRecordModel copyWith({
    int? id,
    int? organizationProgramId,
    String? finishDate,
    String? organizationProgramName,
    bool? isSelected,
  }) {
    return ReportRecordModel(
      id: id ?? this.id,
      organizationProgramId:
          organizationProgramId ?? this.organizationProgramId,
      finishDate: finishDate ?? this.finishDate,
      organizationProgramName:
          organizationProgramName ?? this.organizationProgramName,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'organizationProgramId': organizationProgramId,
      'finishDate': finishDate,
      'organizationProgramName': organizationProgramName,
      'isSelected': isSelected,
    };
  }

  factory ReportRecordModel.fromMap(Map<String, dynamic> map) {
    return ReportRecordModel(
      id: map['id']?.toInt() ?? 0,
      organizationProgramId: map['organizationProgramId']?.toInt() ?? 0,
      finishDate: map['finishDate'] ?? '',
      organizationProgramName: map['organizationProgramName'] ?? '',
      isSelected: map['isSelected'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportRecordModel.fromJson(String source) =>
      ReportRecordModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReportRecordModel(id: $id, organizationProgramId: $organizationProgramId, finishDate: $finishDate, organizationProgramName: $organizationProgramName, isSelected: $isSelected)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReportRecordModel &&
        other.id == id &&
        other.organizationProgramId == organizationProgramId &&
        other.finishDate == finishDate &&
        other.organizationProgramName == organizationProgramName &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        organizationProgramId.hashCode ^
        finishDate.hashCode ^
        organizationProgramName.hashCode ^
        isSelected.hashCode;
  }
}
