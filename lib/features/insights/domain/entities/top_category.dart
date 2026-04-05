import 'package:equatable/equatable.dart';

class TopCategory extends Equatable {
  final String category;
  final double totalAmount;
  final double percentage;

  const TopCategory({
    required this.category,
    required this.totalAmount,
    required this.percentage,
  });

  @override
  List<Object?> get props => [category, totalAmount, percentage];
}
