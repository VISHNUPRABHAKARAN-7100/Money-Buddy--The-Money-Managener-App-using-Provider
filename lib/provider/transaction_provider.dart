import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../db/transactions/transaction_db.dart';
import '../models/transactions/transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  late List<TransactionModel> chartDataForIncome =
      TransactionDB.instance.newIncomeTransactionNotaifier.value;
  late List<TransactionModel> chartDataForExpenses =
      TransactionDB.instance.newExpeneseTransactionNotifier.value;

  List<TransactionModel> valueFounded =
      TransactionDB.instance.transactionListNotifier.value;

  filterForAllTransaction() {
    valueFounded = TransactionDB.instance.transactionListNotifier.value;
    notifyListeners();
  }

  filterForAllIncome() {
    valueFounded = TransactionDB.instance.newIncomeTransactionNotaifier.value;
    notifyListeners();
  }

  filterForAllExpenses() {
    valueFounded = TransactionDB.instance.newExpeneseTransactionNotifier.value;
    notifyListeners();
  }

  fileringForToday() {
    valueFounded = TransactionDB.instance.todayNotifier.value;
    notifyListeners();
  }

  filteringForMonthly() {
    valueFounded = TransactionDB.instance.monthlyNotifier.value;
    notifyListeners();
  }

  filteringForYearly() {
    valueFounded = TransactionDB.instance.yearlyNotifier.value;
    notifyListeners();
  }

  functionOfDropdownButtonForTransactionCategory(int value) {
    return value;
  }

  functionOfDropdownButtonForDateCategory(int value) {
    return value;
  }

  functionForDeleteATransaction(String value,BuildContext context) {
    TransactionDB.instance.deleteTransaction(value);
    notifyListeners();
    Navigator.pop(context);
  }
}
