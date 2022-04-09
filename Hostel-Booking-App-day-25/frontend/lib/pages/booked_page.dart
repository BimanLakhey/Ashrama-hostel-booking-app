import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/routes.dart';
import 'package:hotel_booking_app/utils/search.dart';

class BookedPage extends StatelessWidget 
{
  final bool isBooked = false;


  const BookedPage({Key? key}) : super(key: key);

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
          title: const Text("Booked"),
          centerTitle: true,
          foregroundColor: Colors.white,
        ), 
        body: isBooked 
          ? Container
            (
    
            )
          : Container
            (
              height: 800,
              alignment: Alignment.center,
              child: SingleChildScrollView
              (
                child: Column
                (
                  children:
                  [
                    const Text
                    (
                      "Start booking your preferred hostels",
                      style: TextStyle
                      (
                        fontSize: 20
              
                      ),
                    ),
                    const SizedBox
                    (
                      height: 20,
                    ),
                    ElevatedButton
                    (
                      onPressed: () => showSearch(context: context, delegate: Search()),
                      child: const Text
                      (
                        "Book now", 
                        style: TextStyle
                        (
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    )
                  ],
                ),
              ),   
            )
      ),
    );
  }
}