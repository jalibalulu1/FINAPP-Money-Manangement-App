import 'package:bhandaram/db/transactions/transaction_db.dart';
import 'package:bhandaram/splash_screen.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatefulWidget {
  final String tilename;

  const SettingsTile({
    Key? key,
    required this.tilename,
  }) : super(key: key);

  @override
  State<SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 375,
        height: 69,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3f000000),
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [Color(0x6b6da69c), Color(0xc665a1c3)],
          ),
        ),
        child: InkWell(
          child: ListTile(
              title: Text(widget.tilename,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.92,
                  )),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Row(
                            children: const [Center(child: Text('Reset App'))]),
                        content:
                            const Text("Are you sure, want to reset the app?"),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("YES"),
                            onPressed: () {
                              resetapp();
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SplashScreen(),
                              ));
                            },
                          ),
                          TextButton(
                            child: const Text("CANCEL"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              }),
        ));
  }
  // resetApp(){
  //                 TransactionDB.instance.transactionListNotifier.value.clear();
  //                 CategoryDB.instance.expenseCategoryListListener.value.clear();
  //                   CategoryDB.instance.incomeCategoryListListener.value.clear();
  // }
}
