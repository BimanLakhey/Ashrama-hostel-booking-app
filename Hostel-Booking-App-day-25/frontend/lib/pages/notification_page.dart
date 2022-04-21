import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notifications
{
  String? title, hostelNameNotify, roomTypeNotify, bookingDateNotify;
  Notifications
  (
    this.title,
    this.hostelNameNotify,
    this.roomTypeNotify,
    this.bookingDateNotify,
  );
}

String? hostelNameNotify;
String? roomTypeNotify;
String? bookingDateNotify;

List<Notifications> notificationList = [];

void addNotification()
{
  Notifications bookingConfirmedNotification = Notifications
  (
    "Booked", 
    "$hostelNameNotify", 
    "$roomTypeNotify", 
    "$bookingDateNotify",
  );
  notificationList.add(bookingConfirmedNotification);
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        leading: IconButton
        (
          icon: const Icon(CupertinoIcons.arrow_left),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Notifications"),
        centerTitle: true,
      ),
      body: ListView.builder
      (
        itemCount: notificationList.length,
        itemBuilder: (context, i)
        {
          return Center
          (
            child: Padding
            (
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 30),
              child: Column
              (
                children: [
                  Align
                  (
                    alignment: Alignment.centerLeft,
                    child: RichText
                    (
                      text: TextSpan
                      (
                        text: "${Emojis.paper_bookmark}   ",
                        style: const TextStyle(color: Colors.black, fontSize: 30, height: 1.5),
                        children: <TextSpan>[
                          TextSpan(text: "${notificationList[i].title.toString()} ", style: const TextStyle(fontSize: 17)),
                          TextSpan(text: "${notificationList[i].roomTypeNotify}, " + notificationList[i].hostelNameNotify.toString(), style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                          TextSpan(text: "\n              for " + notificationList[i].bookingDateNotify.toString(), style: const TextStyle(fontSize: 17))
                        ]
                      )
                    ),
                  ),
                  const Padding
                  (
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child:  Divider(color: Colors.black54, thickness: 1)
                  ),
                ],
              ),
            ),
          );
        }
      )
    );
  }
}