// ignore_for_file: must_be_immutable, camel_case_types
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bhandaram/db/transactions/transaction_db.dart';

import 'package:bhandaram/models/transactions/transaction_model.dart';

import 'package:bhandaram/widgets/homescreen/view_all.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../viewall_statistics.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({Key? key}) : super(key: key);

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  final colorList = <Color>[Colors.greenAccent];

  @override
  void initState() {
    super.initState();
  }

  List<chartdata> connectedList =
      chartlogic(TransactionDB.instance.incometransactionListNotifier.value);

  @override
  Widget build(BuildContext context) {
    setState(() {});

    return TransactionDB.instance.incometransactionListNotifier.value.isEmpty
        ? Container(
            // width: MediaQuery.of(context).size.width/3,
            // height: MediaQuery.of(context).size.height / 3,
            // width: 200,
            // height: 200,

            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Frame (1).png'),
                
                ),
                shape: BoxShape.rectangle),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: AutoSizeText(
                    "No data available",
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
            // backgroundColor: Colors.white,
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
                              future: null,
                              builder: (BuildContext context,
                                  AsyncSnapshot<Object?> snapshot) {
                                return SfCircularChart(
                                    legend: Legend(
                                        isVisible: true,
                                        borderColor: Colors.black54,
                                        borderWidth: 1),
                                    title: ChartTitle(
                                      text: 'Income category analysis',
                                      textStyle: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
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
                            builder: ((context) => ViewAllStatistics())));
                        selectedItem = 'All';
                      },
                      icon: const Icon(
                        Icons.remove_red_eye,
                        color: Color.fromARGB(255, 13, 108, 153),
                      ),
                      label: const Text(
                        'View All',
                        style: TextStyle(
                            color: Color.fromARGB(255, 13, 108, 153),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          );
  }
}

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
  // thedata.clear();
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
