// ignore_for_file: constant_identifier_names

import 'package:hive/hive.dart';
part 'category_model.g.dart';

@HiveType(typeId: 2)
enum Categorytype {
  @HiveField(0)
  Income,
  @HiveField(1)
  Expense,
}

@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final bool isDeleted;

  @HiveField(3)
  final Categorytype type;

  CategoryModel(
      {required this.id,
      required this.name,
      required this.type,
      this.isDeleted = false});

  @override
  String toString() {
    return '$name  $type';
  }
}
