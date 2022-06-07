import 'package:auto_size_text/auto_size_text.dart';
import 'package:bhandaram/db/transactions/transaction_db.dart';
import 'package:bhandaram/models/category/category_model.dart';
import 'package:bhandaram/models/transactions/transaction_model.dart';
import 'package:bhandaram/widgets/edit_screen/edit_datasection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseDetails extends StatefulWidget {
  const ExpenseDetails({Key? key}) : super(key: key);

  @override
  State<ExpenseDetails> createState() => _ExpenseDetailsState();
}

class _ExpenseDetailsState extends State<ExpenseDetails> {
  DateTime selectedDate = DateTime.now();

  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionListNotifier,
        builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
          return ListView.builder(
            itemCount: newList.length,
            itemBuilder: (BuildContext context, int index) {
              final _value = newList[index];

              return _value.type == Categorytype.Expense
                  ? Slidable(
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
                                                setState(() {
                                                  TransactionDB.instance
                                                      .deleteTransaction(
                                                          _value.id!);

                                                  Navigator.of(context).pop();
                                                  // ignore: deprecated_member_use
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          1),
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          238,
                                                                          93,
                                                                          83),
                                                              content: Padding(
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
                                                });
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
                                  );
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
                          // swipe to delete and edit
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
                                maxLines: 1,
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
                    )
                  : const SizedBox(
                      height: 1,
                    );
            },
          );
        },
      ),
    );
  }
}
