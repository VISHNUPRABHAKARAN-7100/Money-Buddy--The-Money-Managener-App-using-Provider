// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_final_fields, depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_buddy/provider/transaction_provider.dart';
import 'package:provider/provider.dart';
import '../../db/transactions/transaction_db.dart';
import '../../models/category/category_model.dart';
import '../../models/transactions/transaction_model.dart';

class AllTransactions extends StatelessWidget {
  AllTransactions({super.key});

  int dropdownButtonForCategory = 1;
  int dropdownButtonForDateCategory = 1;

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('All Transactions'),
        backgroundColor: const Color.fromARGB(255, 45, 77, 153),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
// Drop down button For filtering
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: dropdownButtonForCategory,
                    items: [
                      DropdownMenuItem(
                        value: 1,
                        child: const Text('All'),
                        onTap: () {
                          Provider.of<TransactionProvider>(context,
                                  listen: false)
                              .filterForAllTransaction();
                        },
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: const Text('Income'),
                        onTap: () {
                          Provider.of<TransactionProvider>(context,
                                  listen: false)
                              .filterForAllIncome();
                        },
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: const Text('Expense'),
                        onTap: () {
                          Provider.of<TransactionProvider>(context,
                                  listen: false)
                              .filterForAllExpenses();
                        },
                      ),
                    ],
                    onChanged: (value) {
                      dropdownButtonForCategory =
                          Provider.of<TransactionProvider>(context,
                                  listen: false)
                              .functionOfDropdownButtonForTransactionCategory(
                                  value!);
                    },
                  ),
                ),
              ),
              trailing: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: dropdownButtonForDateCategory,
                    items: [
                      DropdownMenuItem(
                        value: 1,
                        child: const Text('All'),
                        onTap: () {
                          Provider.of<TransactionProvider>(context,
                                  listen: false)
                              .filterForAllTransaction();
                        },
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: const Text('Today'),
                        onTap: () {
                          Provider.of<TransactionProvider>(context,
                                  listen: false)
                              .fileringForToday();
                        },
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: const Text('Monthly'),
                        onTap: () {
                          Provider.of<TransactionProvider>(context,
                                  listen: false)
                              .filteringForMonthly();
                        },
                      ),
                      DropdownMenuItem(
                        value: 4,
                        child: const Text('Yearly'),
                        onTap: () {
                          Provider.of<TransactionProvider>(context,
                                  listen: false)
                              .filteringForYearly();
                        },
                      )
                    ],
                    onChanged: (value) {
                      dropdownButtonForDateCategory =
                          Provider.of<TransactionProvider>(context,
                                  listen: false)
                              .functionOfDropdownButtonForDateCategory(value!);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // FormField For Search
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
              ),
              child: TextFormField(
                controller: _searchController,
                onChanged: (value) =>
                    _searchTransaction(_searchController.text),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  hintText: 'Search',
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
// List Tile For All Transactions
            (Provider.of<TransactionProvider>(context).valueFounded.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: Provider.of<TransactionProvider>(context)
                          .valueFounded
                          .length,
                      itemBuilder: (context, index) {
                        final _value = Provider.of<TransactionProvider>(context)
                            .valueFounded[index];
                        return Slidable(
                          startActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            children: [
                              SlidableAction(
                                backgroundColor:
                                    const Color.fromARGB(255, 234, 81, 70),
                                icon: Icons.delete,
                                onPressed: (context) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SimpleDialog(
                                        title: const Text('Are you sure?'),
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Provider.of<TransactionProvider>(
                                                          context,listen: false)
                                                      .functionForDeleteATransaction(_value.id!,context);
                                                  // setState(() {
                                                  //   TransactionDB.instance
                                                  //       .deleteTransaction(
                                                  //           _value.id!);
                                                  //   TransactionDB.instance
                                                  //       .refresh();
                                                  //   Navigator.of(context).pop();
                                                  // });
                                                },
                                                child: const Text('Ok'),
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          key: Key(_value.id!),
                          child: Card(
                            elevation: 3,
                            child: ListTile(
                              title: Text(
                                _value.category.name,
                              ),
                              subtitle: Text(
                                parsedDate(_value.date),
                              ),
                              trailing: _value.type == CategoryType.Expenses
                                  ? Text(
                                      '₹${_value.amount}',
                                      style: const TextStyle(color: Colors.red),
                                    )
                                  : Text(
                                      '₹${_value.amount}',
                                      style:
                                          const TextStyle(color: Colors.green),
                                    ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SimpleDialog(
                                      title: Text(_value.type.name),
                                      children: [
                                        SimpleDialogOption(
                                          child: Text(
                                            'Date:- ${parsedDate(_value.date)}',
                                          ),
                                        ),
                                        SimpleDialogOption(
                                          child: Text(
                                            'Category:-${_value.category.name}',
                                          ),
                                        ),
                                        SimpleDialogOption(
                                          child: Text(
                                            'Amount:- ${_value.amount}',
                                          ),
                                        ),
                                        SimpleDialogOption(
                                          child: Text(
                                            'Note:- ${_value.note}',
                                          ),
                                        ),
                                        SimpleDialogOption(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Ok'),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Image.asset('assets\\no_transaction_found.png'),
                  )),
          ],
        ),
      ),
    );
  }

  parsedDate(data) {
    final formatedDate = DateFormat.yMMMd().format(data);
    final splitedDate = formatedDate.split(' ');
    return '${splitedDate[1]} ${splitedDate.first} ${splitedDate.last} ';
  }

// Function for search a transaction in all transaction
  void _searchTransaction(String enteredValue) {
    List<TransactionModel> results = [];
    if (enteredValue.isEmpty) {
      results = TransactionDB.instance.transactionListNotifier.value;
      ;
    } else {
      results = TransactionDB.instance.transactionListNotifier.value
          .where((element) => element.category.name
              .trim()
              .toLowerCase()
              .contains(enteredValue.trim().toLowerCase()))
          .toList();
    }
    // setState(() {
    //   valueFounded = results;
    // });
  }
}
