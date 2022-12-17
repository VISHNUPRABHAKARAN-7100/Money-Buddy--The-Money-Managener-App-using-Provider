// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

import '../../models/category/category_model.dart';

const categoryDbName = 'category_database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> addCategories(CategoryModel value);
  Future<void> deletecategory(String categoryId);
}

class CategoryDB implements CategoryDbFunctions {
  
// Factory Method

  CategoryDB._internal();
  static CategoryDB instance = CategoryDB._internal();
  factory CategoryDB() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoaryListLisner =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expensesCategoaryListLisner =
      ValueNotifier([]);
//  Function for add category in category list
  @override
  Future<void> addCategories(CategoryModel value) async {
    final categoryDB = await Hive.openBox<CategoryModel>(categoryDbName);
    categoryDB.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final categoryDB = await Hive.openBox<CategoryModel>(categoryDbName);
    return categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final allCategories = await getCategories();
    incomeCategoaryListLisner.value.clear();
    expensesCategoaryListLisner.value.clear();
    await Future.forEach(
      allCategories,
      (CategoryModel category) => {
        if (category.type == CategoryType.Income)
          {incomeCategoaryListLisner.value.add(category)}
        else
          {expensesCategoaryListLisner.value.add(category)}
      },
    );
    incomeCategoaryListLisner.notifyListeners();
    expensesCategoaryListLisner.notifyListeners();
  }

// Function for deleting category item
  @override
  Future<void> deletecategory(String categoryId) async {
    final categoryDB = await Hive.openBox<CategoryModel>(categoryDbName);
    await categoryDB.delete(categoryId);
    refreshUI();
  }

// Function for reset or clear the datas in category list
  Future<void> resetAll() async {
    final categoryDB = await Hive.openBox<CategoryModel>(categoryDbName);
    categoryDB.clear();
    refreshUI();
  }
}
