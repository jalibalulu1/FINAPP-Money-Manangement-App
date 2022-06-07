import 'package:bhandaram/widgets/add_screen/dataaddingsection.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  static const routeName = 'add-transaction';
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xa84cc0a1), Color(0x4c7ab2c4)],
            ),
          ),
          child: ListView(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 90,
                padding: const EdgeInsets.all(30),
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
                child: const SizedBox(
                  child: Text(
                    "Add your Transaction",
                    textAlign: TextAlign.center,
                    // ignore: unnecessary_const
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.60,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const DataAddingSection(),
            ],
          ),
        ),
      ),
    );
  }
}
