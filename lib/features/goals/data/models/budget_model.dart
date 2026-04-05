import '../../domain/entities/budget.dart';

class BudgetModel {
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

  const BudgetModel({
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

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      category: map['category'] as String?,
      limitAmount: (map['limit_amount'] as num).toDouble(),
      currentSpent: (map['current_spent'] as num).toDouble(),
      periodStart: DateTime.parse(map['period_start'] as String),
      periodEnd: DateTime.parse(map['period_end'] as String),
      isDeleted: map['is_deleted'] as bool? ?? false,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'category': category,
      'limit_amount': limitAmount,
      'current_spent': currentSpent,
      'period_start': periodStart.toIso8601String(),
      'period_end': periodEnd.toIso8601String(),
      'is_deleted': isDeleted,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Budget toEntity() {
    return Budget(
      id: id,
      userId: userId,
      category: category,
      limitAmount: limitAmount,
      currentSpent: currentSpent,
      periodStart: periodStart,
      periodEnd: periodEnd,
      isDeleted: isDeleted,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory BudgetModel.fromEntity(Budget entity) {
    return BudgetModel(
      id: entity.id,
      userId: entity.userId,
      category: entity.category,
      limitAmount: entity.limitAmount,
      currentSpent: entity.currentSpent,
      periodStart: entity.periodStart,
      periodEnd: entity.periodEnd,
      isDeleted: entity.isDeleted,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
