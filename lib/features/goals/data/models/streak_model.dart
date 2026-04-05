import '../../domain/entities/streak.dart';

class StreakModel {
  final String id;
  final String userId;
  final int currentStreak;
  final int longestStreak;
  final DateTime lastUpdated;
  final DateTime? streakStartDate;

  const StreakModel({
    required this.id,
    required this.userId,
    required this.currentStreak,
    required this.longestStreak,
    required this.lastUpdated,
    this.streakStartDate,
  });

  factory StreakModel.fromMap(Map<String, dynamic> map) {
    return StreakModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      currentStreak: map['current_streak'] as int,
      longestStreak: map['longest_streak'] as int,
      lastUpdated: DateTime.parse(map['last_updated'] as String),
      streakStartDate: map['streak_start_date'] != null
          ? DateTime.parse(map['streak_start_date'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'current_streak': currentStreak,
      'longest_streak': longestStreak,
      'last_updated': lastUpdated.toIso8601String(),
      'streak_start_date': streakStartDate?.toIso8601String(),
    };
  }

  Streak toEntity() {
    return Streak(
      id: id,
      userId: userId,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      lastUpdated: lastUpdated,
      streakStartDate: streakStartDate,
    );
  }

  factory StreakModel.fromEntity(Streak entity) {
    return StreakModel(
      id: entity.id,
      userId: entity.userId,
      currentStreak: entity.currentStreak,
      longestStreak: entity.longestStreak,
      lastUpdated: entity.lastUpdated,
      streakStartDate: entity.streakStartDate,
    );
  }
}
