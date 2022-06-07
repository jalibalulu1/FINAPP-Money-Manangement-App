// ignore_for_file: unnecessary_const

import 'package:bhandaram/bottomnavigation.dart';
import 'package:bhandaram/db/transactions/transaction_db.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String name = '';
  TransactionDB transactiondb = TransactionDB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xa84cc0a1), Color(0x4c7ab2c4)],
            ),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 1.2,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/welcome.png'),
                      fit: BoxFit.contain,
                    ),
                    shape: BoxShape.rectangle)),
            SizedBox(
              width: 277,
              height: 133,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 277,
                    child: Text(
                      "Gain total control \nof your money",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff212224),
                        fontSize: 32,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 17),
                  SizedBox(
                    width: 272,
                    child: Text(
                      "Become your own money manager and make every cent count",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xe514548f),
                        fontSize: 16,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: const Color.fromARGB(255, 18, 147, 134)),
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Enter your Name',
                  hintStyle: const TextStyle(fontSize: 18),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(const Radius.circular(7)),
                    borderSide: BorderSide(
                      width: 2,
                      color: Color.fromARGB(228, 20, 112, 143),
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(width: 1, color: Colors.black),
                  ),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                style: const TextStyle(fontSize: 20),
                onChanged: (val) {
                  name = val;
                },
              ),
            ),
            SizedBox(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(12, 143, 186, 100),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: const BorderSide(color: Colors.white)),
                      )),
                  onPressed: () async {
                    if (name.isNotEmpty) {
                      await transactiondb.addname(name);

                      checkLogin(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          action: SnackBarAction(
                              textColor: Colors.white,
                              label: "OK",
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              }),
                          content: const Text(
                            "Please enter your Name",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Next',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Icon(Icons.navigate_next_rounded)
                    ],
                  ),
                )),
          ]),
        )
      ])),
    );
  }

  void checkLogin(BuildContext ctx) async {
    final _sharedPreference = await SharedPreferences.getInstance();
    await _sharedPreference.setBool("Checkvisisted", true);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx1) => const BottomNavigation()));
//  print(name);
  }
}
