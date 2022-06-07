import 'package:bhandaram/models/category/category_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  final double amount;
  @HiveField(1)
  final DateTime date;
  @HiveField(2)
  final Categorytype type;
  @HiveField(3)
  final CategoryModel category;
  @HiveField(4)
  String? id;
  TransactionModel(
      {required this.amount,
      required this.date,
      required this.type,
      required this.category,
      this.id});
}
