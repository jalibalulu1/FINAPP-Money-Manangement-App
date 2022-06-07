// ignore_for_file: non_constant_identifier_names, unrelated_type_equality_checks

import 'package:auto_size_text/auto_size_text.dart';

import 'package:bhandaram/bottomnavigation.dart';

import 'package:bhandaram/widgets/settings/contact_me_tile.dart';
import 'package:bhandaram/widgets/settings/notification_service.dart';
import 'package:bhandaram/widgets/settings/settingstile.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

bool isSwitched = false;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TimeOfDay time = TimeOfDay.now();
  late FlutterLocalNotificationsPlugin Fltrnotification;
  @override
  void initState() {
    super.initState();
    NotificationWidget().init(sheduled: true);
    listenNotifications();
  }

  void listenNotifications() {
    NotificationWidget.onNotifications.stream.listen(null);
  }

  void onClickNotifications(String? payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return const BottomNavigation();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xa84cc0a1), Color(0x4c7ab2c4)],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    width: MediaQuery.of(context).size.width,
                    height: 90,
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
                        "Settings",
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(31, 7, 49, 109),
                        borderRadius: BorderRadius.circular(13),
                      ),

                      // width: MediaQuery.of(context).size.width / 1.1,
                      // height: MediaQuery.of(context).size.height / 1.5,

                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
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
                                    colors: [
                                      Color(0x6b6da69c),
                                      Color(0xc665a1c3)
                                    ],
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Notification',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 1.92,
                                                ),
                                              ),
                                              CupertinoSwitch(
                                                  value: isSwitched,
                                                  onChanged: (newvalue) {
                                                    setState(() {
                                                      isSwitched = newvalue;
                                                    });
                                                  }),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          isSwitched == true
                              ? Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
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
                                        colors: [
                                          Color(0x6b6da69c),
                                          Color(0xc665a1c3)
                                        ],
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: AutoSizeText(
                                            "Remainder : ${time.hour > 12 ? time.hour - 12 : time.hour}:${time.minute} ${time.hour >= 12 ? 'PM' : 'AM'}",
                                            maxFontSize: 22,
                                            minFontSize: 19,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              // fontSize: 20,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.92,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              await _selectTime(context);
                                            },
                                            icon: const Icon(
                                                Icons.lock_clock_rounded))
                                      ],
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(children: [
                                Container(
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
                                      colors: [
                                        Color(0x6b6da69c),
                                        Color(0xc665a1c3)
                                      ],
                                    ),
                                  ),
                                  child: InkWell(
                                      child: const ListTile(
                                          title: Text('About',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 1.92,
                                              ))),
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Developed by Jaliba lulu using Flutter'),
                                                content: const Text(
                                                  'FINAPP makes managing personal finances as easy as pie!. Now easily record your personal and business financial transactions, review your daily, weekly and monthly financial data and manage your precious money with FINAPP.Become your own money manager and make every cent count.',
                                                  style: TextStyle(height: 2),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text('Close'))
                                                ],
                                              );
                                            });
                                      }),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const ContactMeTile(),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SettingsTile(
                                  tilename: "Reset App",
                                ),
                              ]))
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: time,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (newTime != null && newTime != Time) {
      setState(() {
        time = newTime;
      });
      NotificationWidget.showsheduledNotification(
          title: 'FinApp',
          body: 'Add your transaction of today.',
          scheduleDate: Time(newTime.hour, newTime.minute, 0));
    }
  }
}
