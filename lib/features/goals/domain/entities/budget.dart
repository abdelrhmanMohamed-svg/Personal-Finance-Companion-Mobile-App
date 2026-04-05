import 'package:equatable/equatable.dart';

class Budget extends Equatable {
  final String id;
  final String userId;
  final String? category;
  final double limitAmount;
  final double currentSpent;
  final DateTime periodStart;
  final DateTime periodEnd;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Budget({
    required this.id,
    required this.userId,
    this.category,
    required this.limitAmount,
    required this.currentSpent,
    required this.periodStart,
    required this.periodEnd,
    this.isDeleted = false,
    required this.createdAt,
    required this.updatedAt,
  });

  double get remainingAmount => limitAmount - currentSpent;
  double get spentPercentage =>
      limitAmount > 0 ? (currentSpent / limitAmount) : 0;
  bool get isOverBudget => currentSpent > limitAmount;
  bool get isAtWarning => spentPercentage >= 0.8 && !isOverBudget;
  bool get isTotalBudget => category == null;

  Budget copyWith({
    String? id,
    String? userId,
    String? category,
    double? limitAmount,
    double? currentSpent,
    DateTime? periodStart,
    DateTime? periodEnd,
    bool? isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Budget(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      category: category ?? this.category,
      limitAmount: limitAmount ?? this.limitAmount,
      currentSpent: currentSpent ?? this.currentSpent,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        category,
        limitAmount,
        currentSpent,
        periodStart,
        periodEnd,
        isDeleted,
        createdAt,
        updatedAt,
      ];
}
