import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_buddy/models/category/category_model.dart';
import '../db/category/category_db.dart';
import '../db/transactions/transaction_db.dart';
import 'package:intl/intl.dart';
import '../models/transactions/transaction_model.dart';
import '../view/splash_screen/splash_screen.dart';

class TransactionProvider with ChangeNotifier {
  late List<TransactionModel> chartDataForIncome =
      TransactionDB.instance.newIncomeTransactionNotaifier.value;
  late List<TransactionModel> chartDataForExpenses =
      TransactionDB.instance.newExpeneseTransactionNotifier.value;

  List<TransactionModel> valueFounded =
      TransactionDB.instance.transactionListNotifier.value;
  int selectedIndexForBottomNavigationBar = 0;

  CategoryType selectedCategoryType = CategoryType.Income;

  String? categoryID;
  DateTime? selectDate;
  DateTime? newDate;
  String? dateSelected;

  bottomNavigationValueController(int value) {
    selectedIndexForBottomNavigationBar = value;
    notifyListeners();
  }

  filterForAllTransaction(List<TransactionModel> value) {
    valueFounded = value;
    notifyListeners();
  }

  functionOfDropdownButtonForTransactionCategory(int value) {
    return value;
  }

  functionOfDropdownButtonForDateCategory(int value) {
    return value;
  }

  functionForDeleteATransaction(String value, BuildContext context) {
    TransactionDB.instance.deleteTransaction(value);
    Navigator.pop(context);
    notifyListeners();
  }

  functionForRadioButtonOfCategory(CategoryType value) {
    selectedCategoryType = value;
    notifyListeners();
  }

  categoryIdFunction(String value) {
    categoryID = value;
    notifyListeners();
  }

  dateFormeter(DateTime value, String dateController) {
    dateController = DateFormat.yMMMd().format(value);
    notifyListeners();
  }

  searchTransaction(String enteredValue) {
    List<TransactionModel> results = [];
    if (enteredValue.isEmpty) {
      results = TransactionDB.instance.transactionListNotifier.value;
    } else {
      results = TransactionDB.instance.transactionListNotifier.value
          .where((element) => element.category.name
              .trim()
              .toLowerCase()
              .contains(enteredValue.trim().toLowerCase()))
          .toList();
    }
    valueFounded = results;
    notifyListeners();
  }

  setDate(DateTime value) {
    selectDate = value;
    // newDate.toString()> = selectDate?.day;
    dateSelected = DateFormat.yMMMd().format(selectDate!);
    notifyListeners();
  }

  refreshUII() {
    CategoryDB.instance.refreshUI();
    notifyListeners();
  }

  resetApp() {
    CategoryDB.instance.resetAll();
    TransactionDB.instance.resetTransactions();
    notifyListeners();
  }
}
