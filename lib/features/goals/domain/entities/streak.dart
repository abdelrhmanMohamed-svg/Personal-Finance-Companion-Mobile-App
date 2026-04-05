import 'package:equatable/equatable.dart';

class Streak extends Equatable {
  final String id;
  final String userId;
  final int currentStreak;
  final int longestStreak;
  final DateTime lastUpdated;
  final DateTime? streakStartDate;

  const Streak({
    required this.id,
    required this.userId,
    required this.currentStreak,
    required this.longestStreak,
    required this.lastUpdated,
    this.streakStartDate,
  });

  bool get hasActiveStreak => currentStreak > 0;

  Streak copyWith({
    String? id,
    String? userId,
    int? currentStreak,
    int? longestStreak,
    DateTime? lastUpdated,
    DateTime? streakStartDate,
  }) {
    return Streak(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      streakStartDate: streakStartDate ?? this.streakStartDate,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        currentStreak,
        longestStreak,
        lastUpdated,
        streakStartDate,
      ];
}
