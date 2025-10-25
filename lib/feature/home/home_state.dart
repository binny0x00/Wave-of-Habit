import 'dart:convert';

import 'package:wave_of_habit/constants.dart';

class TodayModel {
  final String date;
  final bool washed;
  final bool packed;
  final List<String> extraActs;

  final int score;
  final double waterLevel;
  final String message;

  TodayModel({
    required this.date,
    this.washed = false,
    this.packed = false,
    this.extraActs = const [],
  })  : score = (washed ? 1 : 0) + (packed ? 1 : 0) + extraActs.length,
        waterLevel = waterLevels[(washed ? 1 : 0) + (packed ? 1 : 0) + extraActs.length] ?? 0.7,
        message = feedbackMessages[(washed ? 1 : 0) + (packed ? 1 : 0) + extraActs.length] ?? '';

  TodayModel copyWith({
    String? date,
    bool? washed,
    bool? packed,
    List<String>? extraActs,
  }) {
    return TodayModel(
      date: date ?? this.date,
      washed: washed ?? this.washed,
      packed: packed ?? this.packed,
      extraActs: extraActs ?? this.extraActs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'washed': washed,
      'packed': packed,
      'extraActs': extraActs,
    };
  }

  factory TodayModel.fromMap(Map<String, dynamic> map) {
    return TodayModel(
      date: map['date'] ?? '',
      washed: map['washed'] ?? false,
      packed: map['packed'] ?? false,
      extraActs: List<String>.from(map['extraActs'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory TodayModel.fromJson(String source) => TodayModel.fromMap(json.decode(source));
}
