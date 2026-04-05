import 'package:equatable/equatable.dart';

class SavingsGoal extends Equatable {
  final String id;
  final String userId;
  final String name;
  final double targetAmount;
  final double currentSaved;
  final bool isDeleted;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SavingsGoal({
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

  double get progressPercentage =>
      targetAmount > 0 ? (currentSaved / targetAmount).clamp(0.0, 1.0) : 0.0;
  double get remainingAmount => targetAmount - currentSaved;
  bool get isCompleted => currentSaved >= targetAmount;

  SavingsGoal copyWith({
    String? id,
    String? userId,
    String? name,
    double? targetAmount,
    double? currentSaved,
    bool? isDeleted,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SavingsGoal(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      targetAmount: targetAmount ?? this.targetAmount,
      currentSaved: currentSaved ?? this.currentSaved,
      isDeleted: isDeleted ?? this.isDeleted,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        targetAmount,
        currentSaved,
        isDeleted,
        completedAt,
        createdAt,
        updatedAt,
      ];
}
