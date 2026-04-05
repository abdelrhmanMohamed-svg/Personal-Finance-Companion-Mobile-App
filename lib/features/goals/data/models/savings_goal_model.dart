import '../../domain/entities/savings_goal.dart';

class SavingsGoalModel {
  final String id;
  final String userId;
  final String name;
  final double targetAmount;
  final double currentSaved;
  final bool isDeleted;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SavingsGoalModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.targetAmount,
    required this.currentSaved,
    this.isDeleted = false,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SavingsGoalModel.fromMap(Map<String, dynamic> map) {
    return SavingsGoalModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      name: map['name'] as String,
      targetAmount: (map['target_amount'] as num).toDouble(),
      currentSaved: (map['current_saved'] as num).toDouble(),
      isDeleted: map['is_deleted'] as bool? ?? false,
      completedAt: map['completed_at'] != null
          ? DateTime.parse(map['completed_at'] as String)
          : null,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'target_amount': targetAmount,
      'current_saved': currentSaved,
      'is_deleted': isDeleted,
      'completed_at': completedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  SavingsGoal toEntity() {
    return SavingsGoal(
      id: id,
      userId: userId,
      name: name,
      targetAmount: targetAmount,
      currentSaved: currentSaved,
      isDeleted: isDeleted,
      completedAt: completedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory SavingsGoalModel.fromEntity(SavingsGoal entity) {
    return SavingsGoalModel(
      id: entity.id,
      userId: entity.userId,
      name: entity.name,
      targetAmount: entity.targetAmount,
      currentSaved: entity.currentSaved,
      isDeleted: entity.isDeleted,
      completedAt: entity.completedAt,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
