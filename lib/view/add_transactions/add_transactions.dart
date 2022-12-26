// ignore_for_file: prefer_final_fields, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_buddy/view/add_transactions/widgets/radio_button_widget.dart';
import 'package:provider/provider.dart';
import '../../db/category/category_db.dart';
import '../../db/transactions/transaction_db.dart';
import '../../models/category/category_model.dart';
import '../../models/transactions/transaction_model.dart';
import '../../provider/transaction_provider.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.Income);

class AddTransactions extends StatelessWidget {
   AddTransactions({super.key});



  TextEditingController _amountTextConteoller = TextEditingController();
  TextEditingController _noteTextConteoller = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController _categoryEditing = TextEditingController();
  DateTime? _datePicked;

  CategoryModel? _selectedCategoryModel;

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  GlobalKey<FormState> _dateFormKey = GlobalKey<FormState>();

  List<CategoryModel> newIncomeList =
      CategoryDB.instance.incomeCategoaryListLisner.value;
  List<CategoryModel> newExpenseList =
      CategoryDB.instance.expensesCategoaryListLisner.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 77, 153),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: ListView(
          children: [
//Radio Button Of Income & Expenses
            Consumer<TransactionProvider>(
              builder: (context, value, child) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        activeColor: Colors.green,
                        value: CategoryType.Income,
                        groupValue: value.selectedCategoryType,
                        onChanged: (newValue) {
                          value.functionForRadioButtonOfCategory(
                              CategoryType.Income);

                          value.categoryID = null;
                        },
                      ),
                      const Text('Income'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: Colors.red,
                        value: CategoryType.Expenses,
                        groupValue: value.selectedCategoryType,
                        onChanged: (newValue) {
                          value.functionForRadioButtonOfCategory(
                              CategoryType.Expenses);
                          value.categoryID = null;
                        },
                      ),
                      const Text('Expenses'),
                    ],
                  )
                ],
              ),
            ),
//Select Date Icon, Calendar
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
// DropDown Button For Select Category
                  Consumer<TransactionProvider>(
                    builder: (context, value, child) => Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          isCollapsed: true,
                          enabledBorder: InputBorder.none,
                        ),
                        dropdownColor: Colors.grey.shade200,
                        value: value.categoryID,
                        hint: const Text('Select Category'),
                        items:
                            (value.selectedCategoryType == CategoryType.Income
                                    ? CategoryDB().incomeCategoaryListLisner
                                    : CategoryDB().expensesCategoaryListLisner)
                                .value
                                .map((e) {
                          return DropdownMenuItem(
                            onTap: () {
                              _selectedCategoryModel = e;
                            },
                            value: e.id,
                            child: Text(e.name),
                          );
                        }).toList(),
                        onChanged: (selectedValue) {
                          value.categoryIdFunction(selectedValue!);
                        },
                      ),
                    ),
                  ),
// Icon Button For Add Category
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) {
// Alert Dialouge For Add Category
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  RadioButton(
                                    title: 'Income',
                                    type: CategoryType.Income,
                                  ),
                                  RadioButton(
                                    title: 'Expenses',
                                    type: CategoryType.Expenses,
                                  ),
                                ],
                              ),
                              Form(
                                key: _formkey,
                                child: TextFormField(
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  controller: _categoryEditing,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '';
                                    } else {
                                      for (var i = 0;
                                          i < newIncomeList.length;
                                          i++) {
                                        if (value.trim().toLowerCase() ==
                                            newIncomeList[i]
                                                .name
                                                .toLowerCase()
                                                .toString()) {
                                          return 'Alredy exist';
                                        }
                                      }
                                      for (var i = 0;
                                          i < newExpenseList.length;
                                          i++) {
                                        if (value.trim().toLowerCase() ==
                                            newExpenseList[i]
                                                .name
                                                .toLowerCase()
                                                .toString()) {
                                          return 'Alredy exist';
                                        }
                                      }
                                    }
                                    return null;
                                  },
                                  maxLength: 15,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    labelText: 'Add Category',
                                  ),
                                ),
                              ),
// Text FormField For Add Category
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {
                                        final _categoryText =
                                            _categoryEditing.text;
                                        if (_categoryText.isEmpty) {
                                          return;
                                        }
                                        final _type =
                                            selectedCategoryNotifier.value;
                                        final _category = CategoryModel(
                                          id: DateTime.now()
                                              .millisecondsSinceEpoch
                                              .toString(),
                                          name: _categoryText,
                                          type: _type,
                                        );

                                        CategoryDB().addCategories(_category);
                                        _categoryEditing.clear();
                                        // setState(() {
                                        //   CategoryDB.instance.refreshUI();
                                        // });
                                        Provider.of<TransactionProvider>(
                                                context,listen: false)
                                            .refreshUII();

                                        Navigator.of(ctx).pop();
                                      }
                                    },
                                    child: const Text('Add'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _categoryEditing.clear();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),

// Text Form Field For Date Picker
            Consumer<TransactionProvider>(
              builder: (context, value, child) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Form(
                    key: _dateFormKey,
                    child: TextFormField(
                      readOnly: true,
                      controller: dateController,
                      onTap: () async {
                        _datePicked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime.now()
                                .add(const Duration(days: 365 * 2)));
                        if (_datePicked == null) {
                          return;
                        } else {
                          value.setDate(_datePicked!);
                          dateController.text = value.dateSelected!;
                        }
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Select Date',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
// TextFormField For Add Amount
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                  ],
                  controller: _amountTextConteoller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '₹',
                    hintStyle: TextStyle(
                      fontSize: 20,
                    ),
                    labelText: 'Amount',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
// TextFormField For Add Note

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white),
                color: Colors.grey[200],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: _noteTextConteoller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Note',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 45, 77, 153),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 50,
              width: 100,
              child: TextButton(
                onPressed: () {
                  if (_dateFormKey.currentState!.validate()) {
                    checkValidation(context);
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//  Validation For  Amount FormField And Note FormField
  void checkValidation(BuildContext context) {
    final parsedAmount = double.tryParse(_amountTextConteoller.text);

    if (_selectedCategoryModel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          margin: EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text(
            'Select Category',
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 2),
        ),
      );
    } else if (_amountTextConteoller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          margin: EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text(
            'Amount is Required',
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 2),
        ),
      );
    } else if (parsedAmount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          margin: EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text(
            'Enter a valid amount',
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      final _model = TransactionModel(
        note: _noteTextConteoller.text,
        amount: parsedAmount!,
        date: _datePicked!,
        type: Provider.of<TransactionProvider>(context, listen: false)
            .selectedCategoryType,
        category: _selectedCategoryModel!,
      );
      TransactionDB.instance.addTransaction(_model);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          margin: EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color.fromARGB(255, 111, 216, 115),
          content: Text(
            'Data Added Successefully',
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.of(context).pop();
      TransactionDB.instance.refresh();
      _amountTextConteoller.clear();
      _noteTextConteoller.clear();
    }
  }
}
