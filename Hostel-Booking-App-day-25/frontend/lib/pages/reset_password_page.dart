import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/base_url.dart';
import 'package:hotel_booking_app/utils/routes.dart';
import 'package:http/http.dart' as http; 

class ResetPage extends StatefulWidget {
  ResetPage({ Key? key }) : super(key: key);
  static String? userID;

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  String? userID = ResetPage.userID;
  TextEditingController passwordControl = TextEditingController();

  TextEditingController confirmPasswordControl = TextEditingController();
  String? username;
  String? userFName;
  String? userLName;
  String? userEmail;
  String? userPhone;
  String? userPassword;
  String? userCity;
  String? userStreet;
  bool? resetVerification;

  bool passwordNotEmpty = true;
  bool confirmNotEmpty = true;
  bool userValid = false;
  bool passwordValid = true;
  bool passwordsValid = true;

  void checkPasswords()
  {
    if(passwordControl.text == confirmPasswordControl.text)
    {
      passwordsValid = true;
    }
    else
    {
      passwordsValid = false;
    }
  }

  void isPasswordNotEmpty()
  {
    if(passwordControl.text.isNotEmpty)
    {
      passwordNotEmpty = true;
    }
    else
    {
      passwordNotEmpty = false;
    }
  }

  void isConfirmNotEmpty()
  {
    if(confirmPasswordControl.text.isNotEmpty)
    {
      confirmNotEmpty = true;
    }
    else
    {
      confirmNotEmpty = false;
    }
  }

  void resetPassword() async 
  {
    try
    {
      var userResponse = await http.put(Uri.parse('${BaseUrl.baseUrl}resetPassword/$userID'), body: {'userPassword': passwordControl.text});
      var userJsonData = json.decode(userResponse.body);
      
      if(userResponse.statusCode == 200)
      {
        setState(() {
          userValid = false;          
        });

        ScaffoldMessenger.of(context).showSnackBar
        (
          const SnackBar
          (
            content: Text('Password reset!'),
          )
        );
        Navigator.pushNamed(context, MyRoutes.loginRoute);
      }
    }
    catch(e)
    {
      print("no internet");
    }
    
  }

  Future getUserEmails() async 
  {
    try
    {
      var response = await http.get(Uri.parse('${BaseUrl.baseUrl}userDetails/'));
      var jsonData = json.decode(response.body);
      if(response.statusCode == 200)
      {
        for(var user in jsonData)
        {
          if(user["userEmail"] == userEmail.toString())
          {
            userID = user["id"];
            username = user["username"];
            userFName = user["userFName"];
            userLName = user["userLName"];
            userEmail = user["userEmail"];
            userPhone = user["userPhone"];
            userCity = user["userCity"];
            userStreet = user["userStreet"];
          }
        }
      }
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

  void isPasswordValid()
  {
    if(passwordControl.text.length < 6 || passwordControl.text.length > 16)
    {
      passwordValid = false;
    }
    else
    {
      passwordValid = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
      (
        leading: IconButton
        (
          icon: const Icon(CupertinoIcons.arrow_left),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Reset password"),
        centerTitle: true,
        foregroundColor: Colors.white
      ),
      body: SingleChildScrollView
      (
        child: Column
        (
          children: 
          [
            Container
            (
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(20.0,50.0,20.0,50.0),
                child: Image.asset("assets/images/logos/resetPassword.PNG"),
              ),
              height: 250,
              decoration: BoxDecoration
              (
                color: Colors.cyan,
                borderRadius: BorderRadius.vertical
                (
                  bottom: Radius.elliptical
                  (
                    MediaQuery.of(context).size.width, 60.0)
                  ),
              ),
            ),
            const SizedBox(height: 50),
            Center
            (
              child: Container
              (
                width: 325.0,
                height: 375,
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
                      const Text
                      (
                        "New password",
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
                        controller: passwordControl,
                        obscureText: true,
                        decoration: InputDecoration
                        (
                          hintText: "Enter your new password",
                          labelText: "New password",
                          errorText: passwordNotEmpty ? passwordValid ? null : 'Password must be in between 6 to 16\ncharacters in length' : 'Password cannot be empty!'
                        ),
                      ),
                      const SizedBox
                      (
                        height: 20.0,
                      ),
                      TextFormField
                      (
                        obscureText: true,
                        controller: confirmPasswordControl,
                        decoration: InputDecoration
                        (
                          hintText: "Re enter your password",
                          labelText: "Confirm password",
                          errorText: confirmNotEmpty ? passwordsValid ? null : 'Passwords did not match!' : 'Confirm password cannot be empty!'
                        ),
                      ),
                      const SizedBox
                      (
                        height: 40.0,
                      ),          
                      ElevatedButton.icon
                      (
                        onPressed: userValid ? () {} : () 
                        async 
                        {
                          await getUserEmails();
                          setState(() 
                          {
                            isPasswordNotEmpty();
                            isConfirmNotEmpty();
                            checkPasswords();
                            isPasswordValid();
                          });
                          if(passwordNotEmpty && confirmNotEmpty)
                          {
                            if(passwordValid == true)
                            {
                              if (passwordsValid)
                              {
                                setState(() 
                                {
                                  userValid = true;
                                });
                                resetPassword();
                              }
                            }
                          }
                        },    
                        label: userValid 
                        ? const SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2, ))
                        : const Text
                        (
                          "Reset",
                          style: TextStyle
                          (
                            color: Colors.white
                          ),
                        ),
                        icon: userValid ? const Icon(Icons.abc, color: Colors.cyan, size: 1,) : const Icon(CupertinoIcons.arrow_right, color: Colors.white),
                        style: ElevatedButton.styleFrom
                        (
                          primary: Colors.cyan,
                          minimumSize: const Size(165, 50),
                          side: const BorderSide(width: 2, color: Colors.cyan),
                        )
                      ),
                    ],
                  ),
                ),        
              ),
            )
          ]
        )
      ),
    );
  }
}