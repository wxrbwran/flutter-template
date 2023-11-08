import 'dart:convert';

import 'package:flutter/foundation.dart';

class EvaluationListModel {
  final String name;
  final int id;
  final List<EvaluationModel> practiceList;
  final int status;
  final int reportable;
  final int sortFinish;
  final int organizationProgramId;
  final bool history;
  EvaluationListModel({
    required this.name,
    required this.id,
    required this.practiceList,
    required this.status,
    required this.reportable,
    required this.sortFinish,
    required this.organizationProgramId,
    required this.history,
  });

  EvaluationListModel copyWith({
    String? name,
    int? id,
    List<EvaluationModel>? practiceList,
    int? status,
    int? reportable,
    int? sortFinish,
    int? organizationProgramId,
    bool? history,
  }) {
    return EvaluationListModel(
      name: name ?? this.name,
      id: id ?? this.id,
      practiceList: practiceList ?? this.practiceList,
      status: status ?? this.status,
      reportable: reportable ?? this.reportable,
      sortFinish: sortFinish ?? this.sortFinish,
      organizationProgramId:
          organizationProgramId ?? this.organizationProgramId,
      history: history ?? this.history,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'practiceList': practiceList.map((x) => x.toMap()).toList(),
      'status': status,
      'reportable': reportable,
      'sortFinish': sortFinish,
      'organizationProgramId': organizationProgramId,
      'history': history,
    };
  }

  factory EvaluationListModel.fromMap(Map<String, dynamic> map) {
    return EvaluationListModel(
      name: map['name'] ?? '',
      id: map['id']?.toInt() ?? 0,
      practiceList: List<EvaluationModel>.from(
          map['practiceList']?.map((x) => EvaluationModel.fromMap(x))),
      status: map['status']?.toInt() ?? 0,
      reportable: map['reportable']?.toInt() ?? 0,
      sortFinish: map['sortFinish']?.toInt() ?? 0,
      organizationProgramId: map['organizationProgramId']?.toInt() ?? 0,
      history: map['history'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory EvaluationListModel.fromJson(String source) =>
      EvaluationListModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EvaluationListModel(name: $name, id: $id, practiceList: $practiceList, status: $status, reportable: $reportable, sortFinish: $sortFinish, organizationProgramId: $organizationProgramId, history: $history)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EvaluationListModel &&
        other.name == name &&
        other.id == id &&
        listEquals(other.practiceList, practiceList) &&
        other.status == status &&
        other.reportable == reportable &&
        other.sortFinish == sortFinish &&
        other.organizationProgramId == organizationProgramId &&
        other.history == history;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        practiceList.hashCode ^
        status.hashCode ^
        reportable.hashCode ^
        sortFinish.hashCode ^
        organizationProgramId.hashCode ^
        history.hashCode;
  }
}

class EvaluationModel {
  final int organizationProgramPracticeId;
  final int gameId;
  final String name;
  bool completed;
  final String unselectedIcon;
  final String selectedIcon;
  final String gameUrl;
  bool isSelected;
  bool isLast;
  bool isPlaceHolder;

  /// 是否覆盖蒙版
  bool isMask;
  EvaluationModel({
    required this.organizationProgramPracticeId,
    required this.gameId,
    required this.name,
    required this.completed,
    required this.unselectedIcon,
    required this.selectedIcon,
    required this.gameUrl,
    required this.isSelected,
    required this.isLast,
    required this.isPlaceHolder,
    required this.isMask,
  });

  EvaluationModel copyWith({
    int? organizationProgramPracticeId,
    int? gameId,
    String? name,
    bool? completed,
    String? unselectedIcon,
    String? selectedIcon,
    String? gameUrl,
    bool? isSelected,
    bool? isLast,
    bool? isPlaceHolder,
    bool? isMask,
  }) {
    return EvaluationModel(
      organizationProgramPracticeId:
          organizationProgramPracticeId ?? this.organizationProgramPracticeId,
      gameId: gameId ?? this.gameId,
      name: name ?? this.name,
      completed: completed ?? this.completed,
      unselectedIcon: unselectedIcon ?? this.unselectedIcon,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      gameUrl: gameUrl ?? this.gameUrl,
      isSelected: isSelected ?? this.isSelected,
      isLast: isLast ?? this.isLast,
      isPlaceHolder: isPlaceHolder ?? this.isPlaceHolder,
      isMask: isMask ?? this.isMask,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'organizationProgramPracticeId': organizationProgramPracticeId,
      'gameId': gameId,
      'name': name,
      'completed': completed,
      'unselectedIcon': unselectedIcon,
      'selectedIcon': selectedIcon,
      'gameUrl': gameUrl,
      'isSelected': isSelected,
      'isLast': isLast,
      'isPlaceHolder': isPlaceHolder,
      'isMask': isMask,
    };
  }

  factory EvaluationModel.fromMap(Map<String, dynamic> map) {
    return EvaluationModel(
      organizationProgramPracticeId:
          map['organizationProgramPracticeId']?.toInt() ?? 0,
      gameId: map['gameId']?.toInt() ?? 0,
      name: map['name'] ?? '',
      completed: map['completed'] ?? false,
      unselectedIcon: map['unselectedIcon'] ?? '',
      selectedIcon: map['selectedIcon'] ?? '',
      gameUrl: map['gameUrl'] ?? '',
      isSelected: map['isSelected'] ?? false,
      isLast: map['isLast'] ?? false,
      isPlaceHolder: map['isPlaceHolder'] ?? false,
      isMask: map['isMask'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory EvaluationModel.fromJson(String source) =>
      EvaluationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EvaluationModel(organizationProgramPracticeId: $organizationProgramPracticeId, gameId: $gameId, name: $name, completed: $completed, unselectedIcon: $unselectedIcon, selectedIcon: $selectedIcon, gameUrl: $gameUrl, isSelected: $isSelected, isLast: $isLast, isPlaceHolder: $isPlaceHolder, isMask: $isMask)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EvaluationModel &&
        other.organizationProgramPracticeId == organizationProgramPracticeId &&
        other.gameId == gameId &&
        other.name == name &&
        other.completed == completed &&
        other.unselectedIcon == unselectedIcon &&
        other.selectedIcon == selectedIcon &&
        other.gameUrl == gameUrl &&
        other.isSelected == isSelected &&
        other.isLast == isLast &&
        other.isPlaceHolder == isPlaceHolder &&
        other.isMask == isMask;
  }

  @override
  int get hashCode {
    return organizationProgramPracticeId.hashCode ^
        gameId.hashCode ^
        name.hashCode ^
        completed.hashCode ^
        unselectedIcon.hashCode ^
        selectedIcon.hashCode ^
        gameUrl.hashCode ^
        isSelected.hashCode ^
        isLast.hashCode ^
        isPlaceHolder.hashCode ^
        isMask.hashCode;
  }
}
