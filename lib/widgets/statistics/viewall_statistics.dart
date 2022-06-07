import 'package:auto_size_text/auto_size_text.dart';
import 'package:bhandaram/db/transactions/transaction_db.dart';
import 'package:bhandaram/models/category/category_model.dart';
import 'package:bhandaram/models/transactions/transaction_model.dart';

import 'package:bhandaram/widgets/edit_screen/edit_datasection.dart';
import 'package:bhandaram/widgets/homescreen/view_all.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewAllStatistics extends StatefulWidget {
  Categorytype? categorytypes;

  ViewAllStatistics({
    Key? key,
  }) : super(key: key);

  @override
  State<ViewAllStatistics> createState() => _ViewAllStatisticsState();
}

class _ViewAllStatisticsState extends State<ViewAllStatistics> {
  final items = ['All', 'Today', 'Yesterday', 'This Month', 'Custom'];

  static DateTimeRange? range;
  DateTime startDate = DateTime.now().add(const Duration(days: -5));
  DateTime endDate = DateTime.now();
  @override
  void initState() {
    TransactionDB.instance.refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xa84cc0a1), Color(0x4c7ab2c4)],
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            height: 170,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff43cea2), Color(0x4c185a9d)],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        selectedItem = 'All';
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 291,
                      height: 52,
                      child: Padding(
                        padding: EdgeInsets.all(9.0),
                        child: AutoSizeText(
                          "Income Transactions",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2.8,
                              fontFamily: "Inter"),
                          minFontSize: 1,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                      width: 135,
                      height: 29,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xd3eff5f9), Color(0xffc7ddea)],
                        ),
                      ),
                      child: DropdownButton<String>(
                          alignment: Alignment.center,
                          style: const TextStyle(
                             color: Colors.black),
                          dropdownColor: Colors.white,
                          elevation: 5,
                          value: selectedItem,
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                                  onTap: () async {},
                                  value: item,
                                  child: AutoSizeText(item,
                                        maxFontSize: 19,
                                        minFontSize: 16,
                                        maxLines: 1,
                                      )
                                  ))
                              .toList(),
                          onChanged: (item) async {
                            setState(() {
                              selectedItem = item!;
                            });

                            selectedItem == "Custom"
                                ? await dateRangePicker()
                                : await TransactionDB.instance
                                    .filterList(selectedItem);
                          })),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: selectedItem == 'All'
                  ? TransactionDB.instance.incometransactionListNotifier
                  : TransactionDB.instance.incomeFilterlist,
              builder: (BuildContext context, List<TransactionModel> newList,
                  Widget? child) {
                return ListView.builder(
                  itemCount: newList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final _value = newList[index];

                    return InkWell(
                      onTap: () {
                        // swipe to delete and edit
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                duration: Duration(seconds: 1),
                                content: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Go to Home page for edit and delete.",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: const [
                              //background color of box
                              BoxShadow(
                                color: Color.fromARGB(255, 139, 181, 204),
                                blurRadius: 1.0, // soften the shadow
                                spreadRadius: 1.0, //extend the shadow
                                offset: Offset(
                                  0.0, // Move to right 10  horizontally
                                  0.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color.fromARGB(255, 109, 106, 106),
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                          ),
                          child: ListTile(
                            leading: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.white, Color(0x00fdfcfc)],
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    (" ${_value.date.day}\n${months[_value.date.month - 1]}"),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.96,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            title: AutoSizeText(
                              '₹ ${_value.amount.toString()}',
                              style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Inter"),
                              minFontSize: 1,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: AutoSizeText(
                              _value.category.name,
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.80,
                                  fontFamily: "Inter"),
                              minFontSize: 1,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Text(
                              _value.type.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _value.type == Categorytype.Income
                                    ? const Color.fromARGB(255, 33, 128, 54)
                                    : const Color.fromARGB(255, 200, 44, 44),
                                fontSize: 17,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.96,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    )));
  }

  Future<void> dateRangePicker() async {
    final _initialDateRange = DateTimeRange(
        start: DateTime.now().add(const Duration(days: -2)),
        end: DateTime.now());
    final newdateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: DateTime.now(),
        initialDateRange: range ?? _initialDateRange);
    if (newdateRange == null) return;
    setState(() {
      range = newdateRange;
      startDate = range!.start;
      endDate = range!.end;
    });
    await TransactionDB.instance.sortedCustom(startDate, endDate);
  }
}
