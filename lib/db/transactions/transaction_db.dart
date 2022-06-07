// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:bhandaram/models/category/category_model.dart';
import 'package:bhandaram/models/transactions/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const Transaction_db_name = 'transaction-db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransactions();
  Future<void> deleteTransaction(String id);
  Future<void> updateTransaction(TransactionModel obj);
  Future<void> filterList(String selectedItem);
  // Future <void> statisticsFilterlist(selectedItem);

}

class TransactionDB implements TransactionDbFunctions {
  TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
    return instance;
  }
  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);

  ValueNotifier<List<TransactionModel>> incometransactionListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> expennsetransactionListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> filterListNotifier = ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> incomeFilterlist = ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> expenseFilterlist = ValueNotifier([]);
  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(Transaction_db_name);
    await _db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final _list = await getAllTransactions();
    incometransactionListNotifier.value.clear();
    expennsetransactionListNotifier.value.clear();
    _list.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();
    filterListNotifier.notifyListeners();
    Future.forEach(
      _list,
      (TransactionModel transaction) {
        if (transaction.type == Categorytype.Income) {
          incometransactionListNotifier.value.add(transaction);
        } else {
          expennsetransactionListNotifier.value.add(transaction);
        }
      },
    );

    incometransactionListNotifier.notifyListeners();

    expennsetransactionListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final _db = await Hive.openBox<TransactionModel>(Transaction_db_name);
    return _db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final _db = await Hive.openBox<TransactionModel>(Transaction_db_name);
    await _db.delete(id);

    refresh();
  }

  @override
  Future<void> updateTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(Transaction_db_name);
    _db.put(obj.id, obj);
    refresh();
  }

  @override
  filterList(String selected) async {
    DateTime now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    if (selected == 'Today') {
      return sortedList(today);
    } else if (selected == 'Yesterday') {
      return sortedList(yesterday);
    } else if (selected == 'This Month') {
      return sortedMonth(today);
    }
  }

  Future<void> sortedList(DateTime _selected) async {
    incomeFilterlist.value.clear();
    expenseFilterlist.value.clear();
    filterListNotifier.value.clear();
    for (TransactionModel data in transactionListNotifier.value) {
      if (data.date.day == _selected.day &&
          data.date.month == _selected.month &&
          // ignore: duplicate_ignore
          data.type == Categorytype.Income) {
        incomeFilterlist.value.add(data);
        filterListNotifier.value.add(data);

        filterListNotifier.notifyListeners();
        incomeFilterlist.notifyListeners();
      } else if (data.date.day == _selected.day &&
          data.date.month == _selected.month &&
          data.type == Categorytype.Expense) {
        expenseFilterlist.value.add(data);

        filterListNotifier.value.add(data);
        filterListNotifier.notifyListeners();
        expenseFilterlist.notifyListeners();
      }
    }
  }

  sortedMonth(DateTime _selected) async {
    incomeFilterlist.value.clear();
    expenseFilterlist.value.clear();
    filterListNotifier.value.clear();
    for (TransactionModel datas in transactionListNotifier.value) {
      if (datas.date.month == _selected.month &&
          datas.category.type == Categorytype.Income) {
        incomeFilterlist.value.add(datas);
        filterListNotifier.value.add(datas);

        incomeFilterlist.notifyListeners();

        filterListNotifier.notifyListeners();
      } else if (datas.date.month == _selected.month &&
          datas.category.type == Categorytype.Expense) {
        expenseFilterlist.value.add(datas);
        filterListNotifier.value.add(datas);
        filterListNotifier.notifyListeners();
        expenseFilterlist.notifyListeners();
      }
    }
  }

  sortedCustom(DateTime startDate, DateTime endDate) async {
    incomeFilterlist.value.clear();
    expenseFilterlist.value.clear();
    filterListNotifier.value.clear();
    for (TransactionModel data in transactionListNotifier.value) {
      if (data.date.isAfter(startDate) &&
          data.date.isBefore(endDate) &&
          data.category.type == Categorytype.Income) {
        incomeFilterlist.value.add(data);
        filterListNotifier.value.add(data);
      } else if (data.date.isAfter(startDate) &&
          data.date.isBefore(endDate) &&
          data.category.type == Categorytype.Expense) {
        expenseFilterlist.value.add(data);
        filterListNotifier.value.add(data);
      }
    }
  }

// Shared preference for setting a name of user
  addname(String name) async {
    SharedPreferences namesharedpreferences =
        await SharedPreferences.getInstance();
    namesharedpreferences.setString('name', name);
  }

  getname() async {
    SharedPreferences namesharedpreferences =
        await SharedPreferences.getInstance();
    return namesharedpreferences.getString('name');
  }
}

resetapp() async {
  final _db = await Hive.openBox<TransactionModel>(Transaction_db_name);
  final _categoryDB = await Hive.openBox<CategoryModel>('category-database');
  _db.clear();
  _categoryDB.clear();
}
