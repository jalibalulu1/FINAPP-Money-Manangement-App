// ignore_for_file: avoid_unnecessary_containers, unnecessary_const

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bhandaram/db/transactions/transaction_db.dart';
import 'package:bhandaram/models/category/category_model.dart';
import 'package:bhandaram/models/transactions/transaction_model.dart';
import 'package:bhandaram/widgets/edit_screen/edit_datasection.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

String selectedItem = 'All';

class ViewAll extends StatefulWidget {
  const ViewAll({Key? key}) : super(key: key);

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  final items = ['All', 'Today', 'Yesterday', 'This Month', 'Custom'];

  static DateTimeRange? range;
  DateTime startDate = DateTime.now().add(const Duration(days: -5));
  DateTime endDate = DateTime.now();
  @override
  void initState() {
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  TransactionDB.instance.refresh();
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
                        child: Text(
                          "All Transactions",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            letterSpacing: 2.8,
                          ),
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
                                  child:AutoSizeText(item,
                                        maxFontSize: 19,
                                        minFontSize: 16,
                                        maxLines: 1,
                                      )))
                              .toList(),
                          onChanged: (item) async {
                            setState(() {
                              selectedItem = item!;
                            });
                            // TransactionDB.instance.refresh();
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
                  ? TransactionDB.instance.transactionListNotifier
                  : TransactionDB.instance.filterListNotifier,
              builder: (BuildContext context, List<TransactionModel> newList,
                  Widget? child) {
                return ListView.builder(
                  itemCount: newList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final _value = newList[index];
                    return Slidable(
                      key: Key(_value.id!),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (ctx) {
                              showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                        content: const Text(
                                            "Do you wanted to delete this transaction?"),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () {
                                                setState(
                                                  () {
                                                    TransactionDB.instance
                                                        .deleteTransaction(
                                                      _value.id!,
                                                    );
                                                    //  TransactionDB.instance.filterList(selectedItem);
                                                    //   TransactionDB.instance.refresh();
                                                      selectedItem='All';
                                                    Navigator.of(context).pop();
                                                    // ignore: deprecated_member_use
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                duration:
                                                                    Duration(
                                                                        seconds:
                                                                            1),
                                                                backgroundColor:
                                                                    Colors.red,
                                                                content:
                                                                    Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10.0),
                                                                  child: Text(
                                                                    "You have deleted the transaction",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            17),
                                                                  ),
                                                                )));
                                                  },
                                                );
                                                TransactionDB.instance
                                                    .refresh();
                                              },
                                              child: const Text("OK")),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Cancel"))
                                        ],
                                      ));
                            },
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                          SlidableAction(
                            onPressed: (ctx) {
                              SchedulerBinding.instance!.addPostFrameCallback(
                                (_) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) {
                                        return EditDataSection(
                                          amount: _value.amount,
                                          date: _value.date,
                                          category: _value.category,
                                          id: _value.id,
                                          type: _value.type,
                                        );
                                        
                                      },
                                      
                                    ),
                                  );selectedItem='All';
                                },
                              );
                            },
                            icon: Icons.edit,
                            label: 'Edit',
                            backgroundColor: Colors.green,
                          )
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                       
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  duration: Duration(seconds: 1),
                                  content: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      "Swipe for more features",
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
