// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/apis/api.dart';
import 'package:hotel_booking_app/utils/routes.dart';

class ManageHostelPage extends StatefulWidget {
  ManageHostelPage({Key key}) : super(key: key);

  @override
  State<ManageHostelPage> createState() => _ManageHostelPageState();
}

class _ManageHostelPageState extends State<ManageHostelPage> {
  @override
  void initState() 
  {
    myHostelDetails = getBookingDetails();
    super.initState();
  }
  Color fontColor = Colors.white;

  Color containerColor = Colors.white;

  Color buttonFontColor = Colors.cyan;

  Color backgroundColor = Colors.cyan;

  String currentlyHosting = "0";

  String arrivingSoon = "0";

  String checkingOut = "0";

  String allReservations = "0";

  bool hasData = true;
  Future myHostelDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
      (
        leading: IconButton
        (
          icon: const Icon(CupertinoIcons.arrow_left),
          onPressed: () => Navigator.pushNamed(context, MyRoutes.homeRoute),
        ),
        title: const Text("Your hostels"),
      ), 
      backgroundColor: backgroundColor,
      body: SingleChildScrollView
      (
        child: Column
        (
          children: 
          [
            Align
            (
              alignment: Alignment.centerLeft,
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(15, 45, 0, 0),
                child: Text("Your reservations", style: TextStyle(fontSize: 20, color: fontColor)),
              ),
            ),

            SingleChildScrollView
            (
              scrollDirection: Axis.horizontal,
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(15, 25, 15, 15),
                child: Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: 
                  [
                    Container
                    (
                      height: 45,
                      decoration: BoxDecoration
                      (
                        boxShadow: 
                        const [
                          BoxShadow
                          (
                            color: Colors.black54,
                            offset: Offset(1, 5),
                            blurRadius: 6,
                          )
                        ],
                        color: containerColor,
                        border: Border.all(color: containerColor, width: 2),
                        borderRadius: BorderRadius.circular(35)
                      ),
                      child: TextButton
                      (
                        style: TextButton.styleFrom
                        (
                          primary: buttonFontColor
                        ),
                        onPressed: () {},
                        child: Text("Currently hosting ($currentlyHosting)"),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container
                    (
                      height: 45,
                      decoration: BoxDecoration
                      (
                        boxShadow: 
                        const [
                          BoxShadow
                          (
                            color: Colors.black54,
                            offset: Offset(1, 5),
                            blurRadius: 6,
                          )
                        ],
                        color: containerColor,
                        border: Border.all(color: containerColor, width: 2),
                        borderRadius: BorderRadius.circular(35)
                      ),
                      child: TextButton
                      (
                        style: TextButton.styleFrom
                        (
                          primary: buttonFontColor
                        ),
                        onPressed: () {},
                        child: Text("Arriving soon ($arrivingSoon)"),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container
                    (
                      height: 45,
                      decoration: BoxDecoration
                      (
                        boxShadow: 
                        const [
                          BoxShadow
                          (
                            color: Colors.black54,
                            offset: Offset(1, 5),
                            blurRadius: 6,
                          )
                        ],
                        color: containerColor,
                        border: Border.all(color: containerColor, width: 2),
                        borderRadius: BorderRadius.circular(35)
                      ),
                      child: TextButton
                      (
                        style: TextButton.styleFrom
                        (
                          primary: buttonFontColor
                        ),
                        onPressed: () {},
                        child: Text("Checking out ($checkingOut)"),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container
                    (
                      height: 45,
                      decoration: BoxDecoration(
                        boxShadow: 
                        const [
                          BoxShadow
                          (
                            color: Colors.black54,
                            offset: Offset(1, 5),
                            blurRadius: 6,
                          )
                        ],
                        color: containerColor,
                        border: Border.all(color: containerColor, width: 2),
                        borderRadius: BorderRadius.circular(35)
                      ),
                      child: TextButton
                      (
                        style: TextButton.styleFrom
                        (
                          primary: buttonFontColor
                        ),
                        onPressed: () {},
                        child: Text("All reservations ($allReservations)"),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ),
            Padding
            (
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
              child: Container
              (
                width: 350,
                height: 300,
                color: containerColor,
                child: Center
                (
                  child: Container
                  (
                    width: 225,
                    child: hasData 
                    ? FutureBuilder
                    (
                      future: myHostelDetails,
                      builder: (context, snapshot) 
                      {
                        if(snapshot.data == null)
                        {
                          return const Text("loading...", style: TextStyle(fontSize: 18),);
                        }
                        else
                        {
                          allReservations = snapshot.data.length.toString();
                          return Text(allReservations);
                        }
                      }
                    )
                    : Text("You don't have any guests staying with you right now", textAlign: TextAlign.center, style: TextStyle(color: buttonFontColor))
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}