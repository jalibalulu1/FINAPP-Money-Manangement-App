// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactMeTile extends StatelessWidget {
  const ContactMeTile({Key? key}) : super(key: key);

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
              title: const Text('Contact Me',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.92,
                  )),
              onTap: () async {
                // ignore: await_only_futures
                if (!await launch(
                    "https://jalibalulu1.github.io/personal-website/ ")) {
                  throw 'Could not launch';
                }
              }),
        ));
  }
}
