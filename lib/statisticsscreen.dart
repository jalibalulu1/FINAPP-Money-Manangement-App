import 'package:bhandaram/bottomnavigation.dart';

import 'package:bhandaram/widgets/statistics/expense_screen/expensescreen.dart';
import 'package:bhandaram/widgets/statistics/income_screen/incomescreen.dart';

import 'package:flutter/material.dart';

// bool tabselected=false;
class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) {
          return const BottomNavigation();
        }), (route) => false);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
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
                    height: 165,
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(
                            width: 291,
                            height: 52,
                            child: Text(
                              "Over view",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w500,
                                letterSpacing: 2.10,
                              ),
                            ),
                          ),
                          // const DateSection(),
                          PreferredSize(
                            preferredSize: Size(
                              MediaQuery.of(context).size.width,
                              40,
                            ),
                            child: Column(
                              children: [
                                TabBar(
                                  labelColor: Colors.white,
                                  indicatorColor:
                                      const Color.fromARGB(255, 37, 138, 164),
                                  unselectedLabelColor:
                                      const Color.fromARGB(255, 104, 100, 100),
                                  labelStyle: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                  tabs: const [
                                    Tab(
                                      text: 'Income',
                                    ),
                                    Tab(
                                      text: 'Expense',
                                    )
                                  ],
                                  controller: tabController,
                                ),
                              ],
                            ),
                          ),
                        ])),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: const [IncomeScreen(), ExpenseScreen()],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
