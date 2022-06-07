import 'package:auto_size_text/auto_size_text.dart';
import 'package:bhandaram/db/transactions/transaction_db.dart';
import 'package:bhandaram/models/category/category_model.dart';
import 'package:bhandaram/models/transactions/transaction_model.dart';
import 'package:bhandaram/widgets/homescreen/display_income_expense.dart';
import 'package:bhandaram/widgets/homescreen/transaction_history.dart';
import 'package:bhandaram/widgets/homescreen/view_all.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? totalBalance;
  double? totalIncome;
  double? totalExpense;
  String name = "";

  @override
  // ignore: must_call_super
  void initState() {
    getPreferences();
    TransactionDB.instance.refresh();
  }

// ignore: prefer_typing_uninitialized_variables
  var namesharedpreferences;
  getPreferences() async {
    namesharedpreferences = await SharedPreferences.getInstance();
    name = namesharedpreferences.getString('name');
  }

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
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
        child: ValueListenableBuilder(
          valueListenable: TransactionDB.instance.transactionListNotifier,
          builder:
              (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
            displayValues(newList);
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 360,
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
                      colors: [
                        Color.fromARGB(255, 74, 189, 152),
                        Color(0x4c185a9d)
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 19, left: 19),
                        child: AutoSizeText(
                          "Welcome $name",
                          textAlign: TextAlign.start,
                          maxFontSize: 26,
                          minFontSize: 18,
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          height: 245,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x3f000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                  width: 330,
                                  padding: const EdgeInsets.only(top: 12),
                                  height: 95,
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x3f000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                    color: const Color.fromARGB(
                                        121, 104, 187, 235),
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          width: 265,
                                          height: 33,
                                          child: AutoSizeText(
                                            "Total Balance",
                                            minFontSize: 15,
                                            maxFontSize: 24,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 253,
                                          height: 35,
                                          child: AutoSizeText(
                                            '₹ $totalBalance',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 26,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w600,
                                            ),
                                            minFontSize: 1,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )), //Display Total Balance
                              const SizedBox(
                                height: 20,
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DisplayIncomeExpense(
                                    //Display income
                                    bgcolor: const Color.fromARGB(
                                        255, 220, 239, 221),
                                    bordercolor:
                                        const Color.fromARGB(255, 98, 213, 102),
                                    text: "Income 💰 ",
                                    amount: '₹$totalIncome',
                                    textcolor: const Color(0xff298a3e),
                                  ),
                                  DisplayIncomeExpense(
                                    //Display expense
                                    bgcolor: const Color.fromARGB(
                                        255, 235, 208, 205),
                                    bordercolor: const Color.fromARGB(
                                        255, 236, 165, 160),
                                    text: "Expense 💸",
                                    amount: "₹$totalExpense ",
                                    textcolor:
                                        const Color.fromARGB(255, 226, 79, 79),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                    top: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AutoSizeText(
                        'Recent Transactions',
                        maxFontSize: 21,
                        minFontSize: 15,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 22, 148, 161),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          if (TransactionDB.instance.transactionListNotifier
                              .value.isNotEmpty) {
                            selectedItem = 'All';
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const ViewAll();
                            }));
                          }
                        },
                        label: const AutoSizeText("View All",
                            maxFontSize: 18,
                            minFontSize: 14,
                            maxLines: 1,
                            style: TextStyle(
                                color: Color.fromARGB(255, 13, 108, 153),
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        icon: const Icon(Icons.remove_red_eye,
                            color: Color.fromARGB(255, 13, 108, 153)),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: TransactionDB
                            .instance.transactionListNotifier.value.isEmpty
                        ? Column(children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.height / 4,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/no_data.png'),
                                    // fit: BoxFit.contain,
                                  ),
                                  shape: BoxShape.rectangle),
                            ),
                          ])
                        : const TransactionHistory()),
                const SizedBox(
                  height: 5,
                ),
              ],
            );
          },
        ),
      ),
    ));
  }

  displayValues(List<TransactionModel> listDatas) async {
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;
    for (TransactionModel values in listDatas) {
      if (values.type == Categorytype.Income) {
        totalIncome = totalIncome! + values.amount;
      }
      if (values.type == Categorytype.Expense) {
        totalExpense = totalExpense! + values.amount;
      }
    }
    totalBalance = totalIncome! - totalExpense!;
    totalBalance! < 0 ? totalBalance = 0 : totalBalance;
  }
}
