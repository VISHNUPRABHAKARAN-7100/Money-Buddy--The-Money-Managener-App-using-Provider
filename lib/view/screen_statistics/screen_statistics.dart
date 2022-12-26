import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../db/transactions/transaction_db.dart';
import '../../models/transactions/transaction_model.dart';
import 'expense_tab/expense_tab.dart';
import 'income_tab/income_tab.dart';

class ScreenStatistics extends StatelessWidget {
  ScreenStatistics({super.key});

  ValueNotifier<List<TransactionModel>> newIncomeTransactionNotaifier =
      ValueNotifier([]);

  List<TransactionModel> newTransactionList =
      TransactionDB.instance.transactionListNotifier.value;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TabBar(
            tabs: [
              Tab(
                child: Column(
                  children: const [
                    Icon(
                      FontAwesomeIcons.arrowDownLong,
                      color: Colors.purple,
                    ),
                    Text(
                      'Income',
                      style: TextStyle(color: Colors.purple),
                    )
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: const [
                    Icon(
                      FontAwesomeIcons.arrowUpLong,
                      color: Colors.purple,
                    ),
                    Text(
                      'Expense',
                      style: TextStyle(color: Colors.purple),
                    )
                  ],
                ),
              ),
            ],
          ),
          const Expanded(
            child: TabBarView(
              children: [
                IncomeTab(),
                ExpenseTab(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
