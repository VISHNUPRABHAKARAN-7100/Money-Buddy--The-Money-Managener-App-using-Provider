import 'package:flutter/material.dart';
import 'package:money_buddy/provider/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../db/transactions/transaction_db.dart';
import '../../../models/transactions/transaction_model.dart';

class IncomeTab extends StatelessWidget {
  const IncomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.newIncomeTransactionNotaifier,
      builder: (BuildContext context, List<TransactionModel> value, _) {
        return SfCircularChart(
          legend: Legend(
            isVisible: true,
            position: LegendPosition.right,
            backgroundColor: Colors.black12,
          ),
          series: <CircularSeries>[
            PieSeries<TransactionModel, String>(
              explode: true,
              dataSource:
                  Provider.of<TransactionProvider>(context).chartDataForIncome,
              xValueMapper: (TransactionModel data, _) {
                return data.category.name;
              },
              yValueMapper: (TransactionModel data, _) => data.amount,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
              ),
            ),
          ],
        );
      },
    );
  }
}
