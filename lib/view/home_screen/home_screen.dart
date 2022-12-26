// ignore_for_file: no_leading_underscores_for_local_identifiers, depend_on_referenced_packages
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_buddy/provider/transaction_provider.dart';
import 'package:provider/provider.dart';
import '../../db/transactions/transaction_db.dart';
import '../../models/category/category_model.dart';
import '../../models/transactions/transaction_model.dart';
import '../add_transactions/add_transactions.dart';
import '../all_transactions/all_transactions.dart';
import '../screen_categories/screen_categories.dart';
import '../screen_statistics/screen_statistics.dart';
import 'drawer_widget/drawer_widger.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  PageController pageController = PageController();

  late String parsedAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 45, 77, 153),
        title: const Text('Money Buddy'),
      ),
      body: DoubleBackToCloseApp(snackBar: const SnackBar(
          content: Text(
            'Press again to exit',
            textAlign: TextAlign.center,
          ),
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 9),
          elevation: 0,
          dismissDirection: DismissDirection.horizontal,
          duration: Duration(seconds: 2),
        ),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 130,
                    child: Card(
                      color: const Color.fromARGB(255, 152, 192, 245),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
// Top Card For Details
                      child: ValueListenableBuilder(
                        valueListenable:
                            TransactionDB.instance.transactionListNotifier,
                        builder: (BuildContext context,
                            List<TransactionModel> newList, _) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(''),
                                  const Text(
                                    'Income',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    amountParseToTwoDecimal(TransactionDB
                                        .instance
                                        .amountCalculation()[0]
                                        .toString()),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 74, 201, 42),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(''),
                                  const Text(
                                    'Balance',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    amountParseToTwoDecimal(TransactionDB
                                        .instance
                                        .amountCalculation()[2]
                                        .toString()),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(''),
                                  const Text(
                                    'Expense',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    amountParseToTwoDecimal(TransactionDB
                                        .instance
                                        .amountCalculation()[1]
                                        .toString()),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 235, 82, 48),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Recent Transaction',
                      style: TextStyle(fontSize: 20)),
                  trailing: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllTransactions(),
                        ),
                      );
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                // Transaction Details
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable:
                        TransactionDB.instance.transactionListNotifier,
                    builder: (context, List<TransactionModel> newList, child) {
                      return (newList.isEmpty
                          ? Image.asset('assets\\no_transaction_found.png')
                          : ListView.builder(
                              itemCount:
                                  (newList.length >= 5 ? 5 : newList.length),
                              itemBuilder: (context, index) {
                                final _value = newList[index];
      
                                return Card(
                                  child: ListTile(
                                    subtitle: Text(
                                      parsedDate(_value.date),
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    title: Text(
                                      _value.category.name,
                                    ),
                                    trailing:
                                        (_value.type == CategoryType.Income
                                            ? Text(
                                                '+ ₹${_value.amount}',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.green,
                                                ),
                                              )
                                            : Text(
                                                '+ ₹${_value.amount}',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.red,
                                                ),
                                              )),
                                  ),
                                );
                              },
                            ));
                    },
                  ),
                ),
// Button To Navigate Add Transaction
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(90),
                        ),
                      ),
                      color: const Color.fromARGB(255, 45, 77, 153),
                      elevation: 6,
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  AddTransactions(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const ScreenCategories(),
            ScreenStatistics(),
          ],
        ),
      ),
      drawerScrimColor: Colors.grey.shade200,
      drawer: const DrawerWidget(),

// Bottom Nvigation Bar
      bottomNavigationBar: Consumer<TransactionProvider>(
        builder: (context, value, child) => BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          currentIndex: value.selectedIndexForBottomNavigationBar,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_filled,
                ),
                label: '________',
                tooltip: 'Home'),
            BottomNavigationBarItem(
                backgroundColor: Color.fromARGB(255, 248, 243, 243),
                icon: Icon(
                  Icons.category_rounded,
                ),
                label: '________',
                tooltip: 'Categories'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.align_vertical_bottom,
                ),
                label: '________',
                tooltip: 'Statistics'),
          ],
          onTap: (value) {
            Provider.of<TransactionProvider>(context, listen: false)
                .bottomNavigationValueController(value);
            pageController.animateToPage(value,
                duration: const Duration(seconds: 1), curve: Curves.ease);
          },
        ),
      ),
    );
  }

  parsedDate(data) {
    final formatedDate = DateFormat.yMMMd().format(data);
    final splitedDate = formatedDate.split(' ');
    return '${splitedDate[1]} ${splitedDate.first} ${splitedDate.last} ';
  }

  String amountParseToTwoDecimal(String amount) {
    return parsedAmount = double.parse(amount).toStringAsFixed(2);
  }
}
