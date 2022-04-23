import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/Model/user_model.dart';
import 'package:hotel_booking_app/apis/api.dart';
import 'package:hotel_booking_app/pages/profile_page.dart';
import 'package:hotel_booking_app/utils/base_url.dart';
import 'package:hotel_booking_app/utils/drawer.dart';
import 'package:hotel_booking_app/utils/routes.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserModel userModel = UserModel();
  TextEditingController userNameControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();

  
  @override
  void dispose() {
    super.dispose();
  }


  void getUserData() async 
  {
    try
    {
      var response = await http.post(Uri.parse('${BaseUrl.baseUrl}loginUser/'), body: {'username': userNameControl.text, 'userPassword': passwordControl.text});
      var jsonData = json.decode(response.body);
      if(response.statusCode == 200)
      {
        Cookie.cookieSession = response.headers['set-cookie'];
        Navigator.pushNamed(context, MyRoutes.homeRoute);
        loggedUserID = jsonData["user_id"].toString();
        loggedUserCity = jsonData["userCity"].toString();
        loggedUserStreet = jsonData["userStreet"].toString();
        loggedUserFName = jsonData["userFName"].toString();
        loggedUserEmail = jsonData["userEmail"].toString();
        loggedUserLName = jsonData["userLName"].toString();
      }
      else
      {
        showDialog
        (
          context: context,
          builder: (ctx) => AlertDialog
          (
            title: Text("Error"),
            content: Text("Invalid credentials!"),
            actions: <Widget>
            [
              FlatButton
              (
                onPressed: () 
                {
                  Navigator.of(ctx).pop();
                },
                child: Text("ok"),
              ),
            ],
          ),
        );
      }
      
      setState(() {
        userModel = UserModel.fromJson({"data": jsonData});
        DrawerPage.usernameHolder = jsonData["username"];
        DrawerPage.passwordHolder = jsonData["userPassword"];
        ProfilePage.usernameHolder = jsonData["username"];
        ProfilePage.passwordHolder = jsonData["userPassword"];
        
      });
    }
    catch(e)
    {
      ScaffoldMessenger.of(context).showSnackBar
      (
        const SnackBar
        (
          content: Text('Not connected to the internet!'),
        )
      );
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      body: SingleChildScrollView
      (
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
            SizedBox(height: 30,),
            SizedBox(
              height: 175,
              child: Image.asset
              (
                "assets/images/logos/login_image.png", 
              ),
            ),
            const SizedBox
            (
              height: 20.0,
            ),
            Container
            (
              height: 550.0,
              width: 325.0,
              decoration: BoxDecoration
              (
                border: Border.all
                (
                  color: Colors.cyan,
                  width: 3
                ),
                borderRadius: const BorderRadius.all(Radius.circular(15.0))
              ),
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: Column
                (
                  children: 
                  [
                    const SizedBox
                    (
                      height: 20.0,
                    ),
                    const Text
                    (
                      "User login",
                      style: TextStyle
                      (
                        fontSize: 28,
                        fontWeight:  FontWeight.bold,
                      ),
                    ),
                    const SizedBox
                    (
                      height: 20.0,
                    ),
                    TextFormField
                    (
                      controller: userNameControl,
                      decoration: const InputDecoration
                      ( 
                        hintText: "Enter your username",
                        labelText: "Username"
                      ),
                    ),
                    const SizedBox
                    (
                      height: 20.0,
                    ),
                    TextFormField
                    (
                      controller: passwordControl,
                      decoration: const InputDecoration
                      (
                        hintText: "Enter your password",
                        labelText: "password",
                      ),
                      obscureText: true,
                    ),
                    const SizedBox
                    (
                      height: 40.0,
                    ),
                    ElevatedButton
                    (
                      onPressed: () 
                      { 
                        getUserData();
                      }, 
                      child: const Text
                      (
                        "Login",
                        style: TextStyle
                        (
                          color: Colors.white
                        ),
                      ),
                      style: ElevatedButton.styleFrom
                      (
                        minimumSize: const Size(150, 40),
                        side: const BorderSide(width: 2, color: Colors.cyan),
                      )
                    ),
                    Padding
                    (
                      padding: const EdgeInsets.fromLTRB(15,35,0,0),
                      child: Row
                      (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: 
                        [
                          const Text
                          (
                            "Forgot Password?",
                          ),
                          TextButton
                          (
                            onPressed: () 
                            {
                              Navigator.pushNamed(context, MyRoutes.enterNumberRoute);
                            }, 
                            child: const Text
                            (
                              "Reset",
                              style: TextStyle
                              (
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          )
                        ]               
                      ),
                    ),
                  ],
                ),
              ),        
            ),
            const SizedBox
            (
              height: 20.0,
            ),
            Padding
            (
              padding: const EdgeInsets.fromLTRB(90,20,90,0),
              child: Row
              (
                children: 
                [
                  const Text
                  (
                    "Don't have an account?",
                  ),
                  TextButton
                  (
                    onPressed: () 
                    {
                      Navigator.pushNamed(context, MyRoutes.registerRoute);
                    }, 
                    child: const Text
                    (
                      "Sign up",
                      style: TextStyle
                      (
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )
                  )
                ]               
              ),
            )
          ],
        ),
      )
    );
  }
}