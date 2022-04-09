import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/routes.dart';

class MessagePage extends StatelessWidget 
{
  bool isBooked = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold
      (
        appBar: AppBar
        (
          leading: IconButton
          (
            icon: const Icon(CupertinoIcons.arrow_left),
            onPressed: () => Navigator.pushNamed(context, MyRoutes.homeRoute),
          ),
          title: const Text("Messages"),
          centerTitle: true,
          foregroundColor: Colors.white,
        ), 
        body: displayBooked()
      ),
    );
  }

  Widget displayBooked()
  {
    if(isBooked)
    {
      return Container();
    }
    else
    {
      return Container
      (
        alignment: Alignment.center,
        child: const Text
        (
          "Find your messages here",
          style: TextStyle
          (
            fontSize: 20
          ),
        ), 
      );
    }
  }
}