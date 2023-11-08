import 'dart:convert';

import 'package:flutter/foundation.dart';

class ReportListModel {
  final int pageNo;
  final int pageSize;
  final int total;
  final int reportable;

  final List<ReportModel> items;
  ReportListModel({
    required this.pageNo,
    required this.pageSize,
    required this.total,
    required this.reportable,
    required this.items,
  });

  ReportListModel copyWith({
    int? pageNo,
    int? pageSize,
    int? total,
    int? reportable,
    List<ReportModel>? items,
  }) {
    return ReportListModel(
      pageNo: pageNo ?? this.pageNo,
      pageSize: pageSize ?? this.pageSize,
      total: total ?? this.total,
      reportable: reportable ?? this.reportable,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pageNo': pageNo,
      'pageSize': pageSize,
      'total': total,
      'reportable': reportable,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory ReportListModel.fromMap(Map<String, dynamic> map) {
    return ReportListModel(
      pageNo: map['pageNo']?.toInt() ?? 0,
      pageSize: map['pageSize']?.toInt() ?? 0,
      total: map['total']?.toInt() ?? 0,
      reportable: map['reportable']?.toInt() ?? 1,
      items: List<ReportModel>.from(
          map['items']?.map((x) => ReportModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportListModel.fromJson(String source) =>
      ReportListModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReportListModel(pageNo: $pageNo, pageSize: $pageSize, total: $total, reportable: $reportable, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReportListModel &&
        other.pageNo == pageNo &&
        other.pageSize == pageSize &&
        other.total == total &&
        other.reportable == reportable &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode {
    return pageNo.hashCode ^
        pageSize.hashCode ^
        total.hashCode ^
        reportable.hashCode ^
        items.hashCode;
  }
}

class ReportModel {
  final String name;
  final int id;
  final String coverUrl;
  final int status;
  final int reportable;
  final int sortFinish;
  final int organizationProgramId;
  bool isSelected;
  ReportModel({
    required this.name,
    required this.id,
    required this.coverUrl,
    required this.status,
    required this.reportable,
    required this.sortFinish,
    required this.organizationProgramId,
    required this.isSelected,
  });

  ReportModel copyWith({
    String? name,
    int? id,
    String? coverUrl,
    int? status,
    int? reportable,
    int? sortFinish,
    int? organizationProgramId,
    bool? isSelected,
  }) {
    return ReportModel(
      name: name ?? this.name,
      id: id ?? this.id,
      coverUrl: coverUrl ?? this.coverUrl,
      status: status ?? this.status,
      reportable: reportable ?? this.reportable,
      sortFinish: sortFinish ?? this.sortFinish,
      organizationProgramId:
          organizationProgramId ?? this.organizationProgramId,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'coverUrl': coverUrl,
      'status': status,
      'reportable': reportable,
      'sortFinish': sortFinish,
      'organizationProgramId': organizationProgramId,
      'isSelected': isSelected,
    };
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      name: map['name'] ?? '',
      id: map['id']?.toInt() ?? 0,
      coverUrl: map['coverUrl'] ?? '',
      status: map['status']?.toInt() ?? 0,
      reportable: map['reportable']?.toInt() ?? 0,
      sortFinish: map['sortFinish']?.toInt() ?? 0,
      organizationProgramId: map['organizationProgramId']?.toInt() ?? 0,
      isSelected: map['isSelected'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportModel.fromJson(String source) =>
      ReportModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReportModel(name: $name, id: $id, coverUrl: $coverUrl, status: $status, reportable: $reportable, sortFinish: $sortFinish, organizationProgramId: $organizationProgramId, isSelected: $isSelected)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReportModel &&
        other.name == name &&
        other.id == id &&
        other.coverUrl == coverUrl &&
        other.status == status &&
        other.reportable == reportable &&
        other.sortFinish == sortFinish &&
        other.organizationProgramId == organizationProgramId &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        coverUrl.hashCode ^
        status.hashCode ^
        reportable.hashCode ^
        sortFinish.hashCode ^
        organizationProgramId.hashCode ^
        isSelected.hashCode;
  }
}
