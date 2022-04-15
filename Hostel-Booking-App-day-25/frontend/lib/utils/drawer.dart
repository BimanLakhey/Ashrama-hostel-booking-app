// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:hotel_booking_app/Model/user_model.dart';
import 'package:hotel_booking_app/utils/routes.dart';
import 'package:hotel_booking_app/pages/profile_page.dart';

class DrawerPage extends StatefulWidget {
  static String? usernameHolder;
  static String? passwordHolder;
  DrawerPage({ Key? key }) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> 
{
  String? usernameHolder = DrawerPage.usernameHolder;
  String? passwordHolder = DrawerPage.passwordHolder;

  UserModel userModel = UserModel();
  bool profileLoaded = false;
  late String? profileImgUrl;
  late String? username;
  String defaultUsername = "Username";

  @override
  void initState()
  {
    super.initState();
    getUserData();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  void getUserData() async {
    var response = await http.post(Uri.parse( BaseUrl.baseUrl + 'loginUser/'), body: {'username': usernameHolder, 'userPassword': passwordHolder});
    var jsonData = json.decode(response.body);
    
    setState(() {
      userModel = UserModel.fromJson({"data": jsonData});
      profileLoaded = true;
    });
    profileImgUrl = jsonData["userPhoto"];
    username = jsonData["username"];
  }

  @override
  Widget build(BuildContext context) 
  {
    return Drawer
    (
        child: ListView
        (
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.zero,
          children: 
          [
            SizedBox
            (
              height: 150,
              child: DrawerHeader
              ( 
                decoration: const BoxDecoration(color: Colors.cyan),
                child: Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: 
                  [
                    Container
                      (
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration
                        (
                          boxShadow: 
                          // ignore: prefer_const_literals_to_create_immutables
                          [
                            BoxShadow(color: Colors.white, spreadRadius: 2, blurRadius: 4)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(50.0))
                        ),
                        width: 70,
                        height: 70,
                        child: profileLoaded
                        ? Image.network
                        (
                          profileImgUrl.toString(),
                          fit: BoxFit.contain,
                        )
                        : SizedBox(child: CircularProgressIndicator())
                      ),
                    Text
                    (
                      profileLoaded ? username.toString() : defaultUsername, 
                      style: TextStyle
                      (
                        fontSize: 20, 
                        color: Colors.white
                      ),
                    ),
                    IconButton
                    (
                      onPressed: () => Navigator.pushNamed(context, MyRoutes.profileRoute), 
                      icon: const Icon(CupertinoIcons.arrow_right),
                      iconSize: 30,
                      color: Colors.white
                    )
                  ],
                )
              ),
            ),
            const Padding
            (
              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text
              (
                "Hosting",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            ),
            ListTile
            (
              onTap: () => Navigator.pushNamed(context, MyRoutes.hostelDetailsRoute),
              horizontalTitleGap: 1,
              dense: true,
              leading: Icon(Icons.logout_outlined),
              title: Text("Register your hostel", style: TextStyle(fontSize: 16))
            ),
            ListTile
            (
              onTap: () => Navigator.pushNamed(context, MyRoutes.learnHostingRoute),
              horizontalTitleGap: 1,
              dense: true,
              leading: Icon(Icons.read_more_outlined),
              title: Text("Learn about hosting", style: TextStyle(fontSize: 16))
            ),
            ListTile
            (
              onTap: () => Navigator.pushNamed(context, MyRoutes.manageHostelRoute),
              horizontalTitleGap: 1,
              dense: true,
              leading: Icon(Icons.handyman_outlined),
              title: Text("Manage your hostel", style: TextStyle(fontSize: 16))
            ),
            const Padding
            (
              padding: EdgeInsets.symmetric(horizontal: 20),
              child:  Divider(color: Colors.black54, thickness: 1)
            ),
            const Padding
            (
              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text
              (
                "Support",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            ),
            ListTile
            (
              onTap: () => Navigator.pushNamed(context, MyRoutes.howAshramaWorksRoute),
              horizontalTitleGap: 1,
              dense: true,
              leading: Icon(CupertinoIcons.info),
              title: Text("How Ashrama works", style: TextStyle(fontSize: 16))
            ),
            const ListTile
            (
              horizontalTitleGap: 1,
              dense: true,
              leading: Icon(Icons.question_answer_outlined),
              title: Text("Customer care", style: TextStyle(fontSize: 16))
            ),
            const ListTile
            (
              horizontalTitleGap: 1,
              dense: true,
              leading: Icon(CupertinoIcons.pen),
              title: Text("Give us feedback", style: TextStyle(fontSize: 16))
            ),
            const Padding
            (
              padding: EdgeInsets.symmetric(horizontal: 20),
              child:  Divider(color: Colors.black54, thickness: 1)
            ),
            ListTile
            (
              onTap: () {
                
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
              },
              horizontalTitleGap: 1,
              dense: true,
              leading: Icon(Icons.logout_outlined),
              title: Text("Logout", style: TextStyle(fontSize: 16))
            ),
          ],
        ),
      );
  }
}