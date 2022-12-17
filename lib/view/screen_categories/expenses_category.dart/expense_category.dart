import 'package:flutter/material.dart';
import '../../../db/category/category_db.dart';
import '../../../models/category/category_model.dart';

class ExpenseCategory extends StatelessWidget {
  const ExpenseCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().expensesCategoaryListLisner,
      builder: (context, List<CategoryModel> newlist, _) {
        return GridView.builder(
          itemCount: newlist.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (context, index) {
            final categorynew = newlist[index];
            return Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(categorynew.name),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            title: const Text('Are you sure?'),
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      CategoryDB.instance
                                          .deletecategory(categorynew.id);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Ok'),
                                  )
                                ],
                              )
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.delete),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
