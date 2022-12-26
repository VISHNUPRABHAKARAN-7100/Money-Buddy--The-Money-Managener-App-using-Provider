// ignore_for_file: unused_field, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'package:flutter/material.dart';
import 'package:money_buddy/models/category/category_model.dart';
import 'package:money_buddy/view/add_transactions/add_transactions.dart';

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  RadioButton({
    super.key,
    required this.title,
    required this.type,
  });

  CategoryType? _type;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedCategoryNotifier,
      builder: (context, newCategory, _) {
        return Row(
          children: [
            Radio<CategoryType>(
              value: type,
              activeColor:
                  (type == CategoryType.Expenses ? Colors.red : Colors.green),
              groupValue: newCategory,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                selectedCategoryNotifier.value = value;
                selectedCategoryNotifier.notifyListeners();
              },
            ),
            Text(title),
          ],
        );
      },
    );
  }
}
