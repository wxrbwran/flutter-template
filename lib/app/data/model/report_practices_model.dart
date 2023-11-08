import 'dart:convert';

import 'package:flutter/foundation.dart';

class ReportPracticesModel {
  final int reportId;
  final List<String> practiceNames;
  final List<String> abilities;
  final List<dynamic> good;
  final List<String> bad;
  final int avgScore;
  final int age;
  final List<PracticesModel> practices;
  final String updateAt;
  ReportPracticesModel({
    required this.reportId,
    required this.practiceNames,
    required this.abilities,
    required this.good,
    required this.bad,
    required this.avgScore,
    required this.age,
    required this.practices,
    required this.updateAt,
  });

  ReportPracticesModel copyWith({
    int? reportId,
    List<String>? practiceNames,
    List<String>? abilities,
    List<dynamic>? good,
    List<String>? bad,
    int? avgScore,
    int? age,
    List<PracticesModel>? practices,
    String? updateAt,
  }) {
    return ReportPracticesModel(
      reportId: reportId ?? this.reportId,
      practiceNames: practiceNames ?? this.practiceNames,
      abilities: abilities ?? this.abilities,
      good: good ?? this.good,
      bad: bad ?? this.bad,
      avgScore: avgScore ?? this.avgScore,
      age: age ?? this.age,
      practices: practices ?? this.practices,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reportId': reportId,
      'practiceNames': practiceNames,
      'abilities': abilities,
      'good': good,
      'bad': bad,
      'avgScore': avgScore,
      'age': age,
      'practices': practices.map((x) => x.toMap()).toList(),
      'updateAt': updateAt,
    };
  }

  factory ReportPracticesModel.fromMap(Map<String, dynamic> map) {
    return ReportPracticesModel(
      reportId: map['reportId']?.toInt() ?? 0,
      practiceNames: List<String>.from(map['practiceNames']),
      abilities: List<String>.from(map['abilities']),
      good: List<dynamic>.from(map['good']),
      bad: List<String>.from(map['bad']),
      avgScore: map['avgScore']?.toInt() ?? 0,
      age: map['age']?.toInt() ?? 0,
      practices: List<PracticesModel>.from(
          map['practices']?.map((x) => PracticesModel.fromMap(x))),
      updateAt: map['updateAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportPracticesModel.fromJson(String source) =>
      ReportPracticesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReportPracticesModel(reportId: $reportId, practiceNames: $practiceNames, abilities: $abilities, good: $good, bad: $bad, avgScore: $avgScore, age: $age, practices: $practices, updateAt: $updateAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReportPracticesModel &&
        other.reportId == reportId &&
        listEquals(other.practiceNames, practiceNames) &&
        listEquals(other.abilities, abilities) &&
        listEquals(other.good, good) &&
        listEquals(other.bad, bad) &&
        other.avgScore == avgScore &&
        other.age == age &&
        listEquals(other.practices, practices) &&
        other.updateAt == updateAt;
  }

  @override
  int get hashCode {
    return reportId.hashCode ^
        practiceNames.hashCode ^
        abilities.hashCode ^
        good.hashCode ^
        bad.hashCode ^
        avgScore.hashCode ^
        age.hashCode ^
        practices.hashCode ^
        updateAt.hashCode;
  }
}

class PracticesModel {
  final String practiceName;
  final int practiceId;
  final String desc;
  final String practiceAbility;
  final String rawResult;
  final int score;
  final int level;
  PracticesModel({
    required this.practiceName,
    required this.practiceId,
    required this.desc,
    required this.practiceAbility,
    required this.rawResult,
    required this.score,
    required this.level,
  });

  PracticesModel copyWith({
    String? practiceName,
    int? practiceId,
    String? desc,
    String? practiceAbility,
    String? rawResult,
    int? score,
    int? level,
  }) {
    return PracticesModel(
      practiceName: practiceName ?? this.practiceName,
      practiceId: practiceId ?? this.practiceId,
      desc: desc ?? this.desc,
      practiceAbility: practiceAbility ?? this.practiceAbility,
      rawResult: rawResult ?? this.rawResult,
      score: score ?? this.score,
      level: level ?? this.level,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'practiceName': practiceName,
      'practiceId': practiceId,
      'desc': desc,
      'practiceAbility': practiceAbility,
      'rawResult': rawResult,
      'score': score,
      'level': level,
    };
  }

  factory PracticesModel.fromMap(Map<String, dynamic> map) {
    return PracticesModel(
      practiceName: map['practiceName'] ?? '',
      practiceId: map['practiceId']?.toInt() ?? 0,
      desc: map['desc'] ?? '',
      practiceAbility: map['practiceAbility'] ?? '',
      rawResult: map['rawResult'] ?? '',
      score: map['score']?.toInt() ?? 0,
      level: map['level']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PracticesModel.fromJson(String source) =>
      PracticesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PracticesModel(practiceName: $practiceName, practiceId: $practiceId, desc: $desc, practiceAbility: $practiceAbility, rawResult: $rawResult, score: $score, level: $level)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PracticesModel &&
        other.practiceName == practiceName &&
        other.practiceId == practiceId &&
        other.desc == desc &&
        other.practiceAbility == practiceAbility &&
        other.rawResult == rawResult &&
        other.score == score &&
        other.level == level;
  }

  @override
  int get hashCode {
    return practiceName.hashCode ^
        practiceId.hashCode ^
        desc.hashCode ^
        practiceAbility.hashCode ^
        rawResult.hashCode ^
        score.hashCode ^
        level.hashCode;
  }
}
