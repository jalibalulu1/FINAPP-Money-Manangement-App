import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DisplayIncomeExpense extends StatelessWidget {
  final Color bgcolor;
  final Color bordercolor;
  final String text;
  final String amount;
  final Color textcolor;

  const DisplayIncomeExpense(
      {Key? key,
      required this.bgcolor,
      required this.bordercolor,
      required this.text,
      required this.amount,
      required this.textcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width / 2.5,
        height: 94,
        child: Container(
          height: 94,
          decoration: BoxDecoration(
              border: Border.all(color: bordercolor),
              borderRadius: BorderRadius.circular(28),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3f000000),
                  blurRadius: 3,
                  offset: Offset(0, 4),
                ),
              ],
              color: bgcolor),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 120,
                height: 32.16,
                child: Text(
                  text,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: textcolor,
                    fontSize: 22,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 3),
              SizedBox(
                width: 100.16,
                height: 25.56,
                child: AutoSizeText(
                  amount,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter",
                      color: textcolor),
                  minFontSize: 1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ));
  }
}
