// ignore_for_file: unnecessary_const

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bhandaram/db/transactions/transaction_db.dart';
import 'package:bhandaram/models/transactions/transaction_model.dart';

import 'package:bhandaram/widgets/homescreen/view_all.dart';

import 'package:bhandaram/widgets/statistics/expense_viewall_statistics.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final colorList = <Color>[Colors.greenAccent];

  @override
  void initState() {
    super.initState();
  }

  List<chartdata> connectedList =
      chartlogic(TransactionDB.instance.expennsetransactionListNotifier.value);

  @override
  Widget build(BuildContext context) {
    return TransactionDB.instance.expennsetransactionListNotifier.value.isEmpty
        ? Container(
            // width: 200,
            // height: 200,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/b.png'),
                  //  fit: BoxFit.contain,
                ),
                shape: BoxShape.rectangle),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: AutoSizeText(
                    "🎊 No Expenses yet !",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                    maxFontSize: 16,
                    minFontSize: 3,
                  ),
                )
              ],
            ),
          )
        : Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xa84cc0a1), Color(0x4c7ab2c4)],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 0),
                          child: SizedBox(
                            width: 800,
                            height: 800,
                            child: FutureBuilder(
                              builder: (BuildContext context,
                                  AsyncSnapshot<Object?> snapshot) {
                                return SfCircularChart(
                                    legend: Legend(
                                        isVisible: true,
                                        borderColor: Colors.black54,
                                        borderWidth: 1),
                                    title: ChartTitle(
                                        text: 'Expense category analysis',
                                        textStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                    series: <CircularSeries>[
                                      PieSeries<chartdata, String>(
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                          isVisible: true,
                                        ),
                                        dataSource: connectedList,
                                        xValueMapper: (chartdata data, _) =>
                                            data.categories,
                                        yValueMapper: (chartdata data, _) =>
                                            data.amount,
                                      )
                                    ]);
                              },
                            ),
                          ),
                        ),
                      )),
                  TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) =>
                                const ExpenseViewAllStatistics())));
                        selectedItem = 'All';
                      },
                      icon: const Icon(
                        Icons.remove_red_eye,
                        color: Color.fromARGB(255, 13, 108, 153),
                      ),
                      label: const Text(
                        'View All',
                        style: const TextStyle(
                            color: const Color.fromARGB(255, 13, 108, 153),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          );
  }
}

// ignore: camel_case_types
class chartdata {
  String? categories;
  double? amount;
  chartdata({required this.categories, required this.amount});
}

List<chartdata> chartlogic(List<TransactionModel> model) {
  double value;
  String categoryname;
  List visited = [];
  List<chartdata> thedata = [];
  for (var i = 0; i < model.length; i++) {
    visited.add(0);
  }
  for (var i = 0; i < model.length; i++) {
    value = model[i].amount;
    categoryname = model[i].category.name;
    for (var j = i + 1; j < model.length; j++) {
      if (model[i].category.name == model[j].category.name) {
        value += model[j].amount;
        visited[j] = -1;
      }
    }
    if (visited[i] != -1) {
      thedata.add(chartdata(categories: categoryname, amount: value));
    }
  }
  return thedata;
}
