// ignore_for_file: no_leading_underscores_for_local_identifiers, constant_identifier_names, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import '../../models/category/category_model.dart';
import '../../models/transactions/transaction_model.dart';
import '../category/category_db.dart';

const transactionDb_Name = 'transaction_db';

abstract class TransactionFunctions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransactions();
  Future<void> deleteTransaction(String id);
}

class TransactionDB implements TransactionFunctions {
// Factory Method

  TransactionDB.internal();
  static TransactionDB instance = TransactionDB.internal();

  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);

  ValueNotifier<List<TransactionModel>> newIncomeTransactionNotaifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> newExpeneseTransactionNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> todayNotifier = ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> monthlyNotifier = ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> yearlyNotifier = ValueNotifier([]);

// Function For Add Transaction

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(transactionDb_Name);
    await _db.put(obj.id, obj);
  }

// Function For Refresh UI
  Future<void> refresh() async {
    final _list = await getAllTransactions();
    _list.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();
    newExpeneseTransactionNotifier.value.clear();
    newIncomeTransactionNotaifier.value.clear();

    await Future.forEach(_list, (TransactionModel transaction) {
      if (transaction.type == CategoryType.Income) {
        newIncomeTransactionNotaifier.value.add(transaction);
      } else {
        newExpeneseTransactionNotifier.value.add(transaction);
      }
    });

// Function for notifyListeners
    newExpeneseTransactionNotifier.notifyListeners();
    newIncomeTransactionNotaifier.notifyListeners();

// Function for clear the corrent values in the notifier
    todayNotifier.value.clear();
    monthlyNotifier.value.clear();
    yearlyNotifier.value.clear();

    await Future.forEach(_list, (TransactionModel transaction) {
// Function for show today transactions only
      if (transaction.date ==
          DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)) {
        todayNotifier.value.add(transaction);
      }
    });

//  Function for show monthly transaction only
    await Future.forEach(_list, (TransactionModel transaction) {
      if (transaction.date.month == DateTime.now().month) {
        monthlyNotifier.value.add(transaction);
      }
    });

//  Function for show yearly transaction only
    await Future.forEach(_list, (TransactionModel transaction) {
      if (transaction.date.year == DateTime.now().year) {
        yearlyNotifier.value.add(transaction);
      }
    });

// Function for notifyListeners

    todayNotifier.notifyListeners();
    monthlyNotifier.notifyListeners();
    yearlyNotifier.notifyListeners();
  }

// Function For Get All the Transaction And View All Transaction

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final _db = await Hive.openBox<TransactionModel>(transactionDb_Name);
    return _db.values.toList();
  }

// Function For Delete Transaction

  @override
  Future<void> deleteTransaction(String id) async {
    final _db = await Hive.openBox<TransactionModel>(transactionDb_Name);
    await _db.delete(id);
    refresh();
  }

// Function For Reset List Of All Transactions
  Future<void> resetTransactions() async {
    final _db = await Hive.openBox<TransactionModel>(transactionDb_Name);
    _db.clear();
    refresh();
    CategoryDB.instance.refreshUI();
  }

// Function for calculating the values in the card of home screen
  List amountCalculation() {
    double newIncomeAmount = 0.0;
    double newExpenseAmount = 0.0;
    double balanceAmount = 0.0;

    for (int i = 0; i < transactionListNotifier.value.length; i++) {
      var values = transactionListNotifier.value[i];
      if (values.type == CategoryType.Income) {
        newIncomeAmount = newIncomeAmount + values.amount;
      } else {
        newExpenseAmount = newExpenseAmount + values.amount;
      }
      balanceAmount = newIncomeAmount - newExpenseAmount;
    }
    return [newIncomeAmount, newExpenseAmount, balanceAmount];
  }
}
