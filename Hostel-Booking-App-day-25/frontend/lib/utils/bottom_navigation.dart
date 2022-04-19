import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/pages/booked_page.dart';
import 'package:hotel_booking_app/pages/home_page.dart';
import 'package:hotel_booking_app/pages/messages_page.dart';
import 'package:hotel_booking_app/pages/saved_page.dart';
import 'package:hotel_booking_app/utils/routes.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({ Key? key }) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> 
{
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomePage(),
    SavedPage(),
    BookedPage()
  ];

  void onTappedBar(int index)
  {
    setState(() 
    {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async 
      {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog
          (
            title: Text("Logout"),
            content: Text("Logout user?"),
            actions: <Widget>
            [
              FlatButton
              (
                onPressed: () 
                {
                  Navigator.pushNamed(context, MyRoutes.loginRoute);
                },
                child: Text("ok"),
              ),
            ],
          ),
        );
        return false;
      },
      child: Scaffold
      (
        body: _screens[_currentIndex],
        bottomNavigationBar: Container
        (
          decoration: const BoxDecoration
          (
            boxShadow: <BoxShadow> 
            [
              BoxShadow
              (
                color: Colors.black54,
                offset: Offset(3, 0),
                blurRadius: 6,
              )
            ],
          ),
          child: BottomNavigationBar
          (
            elevation: 10,
            onTap: onTappedBar,
            currentIndex: _currentIndex,
            items: const 
            [
              BottomNavigationBarItem
              (
                icon: Icon(CupertinoIcons.globe),
                label: "Explore",
              ),
              BottomNavigationBarItem
              (
                icon: Icon(CupertinoIcons.heart),
                label: "Saved",
              ),
              BottomNavigationBarItem
              (
                icon: Icon(CupertinoIcons.bookmark),
                label: "Bookings",
              ),
            ],
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            backgroundColor: Colors.cyan,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}