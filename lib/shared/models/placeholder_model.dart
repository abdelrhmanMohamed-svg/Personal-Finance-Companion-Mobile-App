import 'package:equatable/equatable.dart';

class PlaceholderModel extends Equatable {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const PlaceholderModel({
    required this.id,
    required this.name,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, name, createdAt, updatedAt];

  factory PlaceholderModel.fromJson(Map<String, dynamic> json) {
    return PlaceholderModel(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
