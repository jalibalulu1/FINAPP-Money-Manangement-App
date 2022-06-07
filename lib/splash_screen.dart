// ignore_for_file: non_constant_identifier_names, must_call_super

import 'package:bhandaram/bottomnavigation.dart';
import 'package:bhandaram/db/transactions/transaction_db.dart';
import 'package:bhandaram/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

bool _isVisible = false;

class _SplashScreenState extends State<SplashScreen> {
  TransactionDB transactiondb = TransactionDB();

  @override
  void initState() {
    animateIcon();
    checkvisited();
  }

  final Shader linearGradient = const LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 8, 87, 82),
      Color.fromARGB(161, 32, 120, 171),
    ],
  ).createShader(const Rect.fromLTWH(0.0, 199.0, 300, 100.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: Color.fromARGB(156, 91, 180, 184),
      ),
      child: AnimatedOpacity(
        opacity: _isVisible ? 1 : 0,
        curve: Curves.easeIn,
        duration: const Duration(seconds: 1),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 250,
            height: 230,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/fin_app_logo.png"),
                    fit: BoxFit.fill)),
          ),
        ]),
      ),
    ));
  }

  goto_welcomescreen() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const WelcomeScreen()));
  }

  Future<void> checkvisited() async {
    final sharedpreference = await SharedPreferences.getInstance();
    final getvisited = sharedpreference.getBool("Checkvisisted");
    String? name = await transactiondb.getname();
    if ((getvisited != null || getvisited != false) && (name != null)) {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx1) => const BottomNavigation()));
    } else {
      goto_welcomescreen();
    }
  }

  animateIcon() {
    Future.delayed(
      const Duration(milliseconds: 700),
      (() {
        setState(() {
          _isVisible = !_isVisible;
        });
      }),
    );
  }
}
