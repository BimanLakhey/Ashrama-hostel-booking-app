import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:hotel_booking_app/utils/base_url.dart';
import 'package:hotel_booking_app/utils/routes.dart';
import 'package:http/http.dart' as http;

class ConfirmationPage extends StatefulWidget {
  ConfirmationPage({ Key? key }) : super(key: key);
  static String? otp;
  static String? username;
  static String? userFName;
  static String? userLName;
  static String? userEmail;
  static String? userPhone;
  static String? userPassword;
  static String? userCity;
  static String? userStreet;
  static bool? resetVerification;
  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> 
{
  @override
  void dispose() {
    super.dispose();
  }
  
  final List _options = ["Send via SMS", "Send via Email"];

  late List<DropdownMenuItem<String>> _dropDownMenuItems;
  late String? _currentOption;
  bool isValid = true;
  bool emailTaken = false;

  String? otp = ConfirmationPage.otp;
  String? userID;
  String? username = ConfirmationPage.username;
  String? userFName = ConfirmationPage.userFName;
  String? userLName = ConfirmationPage.userLName;
  String? userEmail = ConfirmationPage.userEmail;
  String? userPhone = ConfirmationPage.userPhone;
  String? userPassword = ConfirmationPage.userPassword;
  String? userCity = ConfirmationPage.userCity;
  String? userStreet = ConfirmationPage.userStreet;
  bool? resetVerification = ConfirmationPage.resetVerification;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentOption = _dropDownMenuItems[0].value!;
    super.initState();
  }
  
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String option in _options) 
    {
      items.add
      ( 
        DropdownMenuItem
        (
          value: option,
          child: Text(option)
        )
      );
    }
    return items;
  }

  void signUpUser() async 
  {
    try
    {
      var response = await http.post(Uri.parse('${BaseUrl.baseUrl}registerUser/'), body: {'username': username!.toLowerCase(), 'userFName': userFName!.toLowerCase(), 'userLName': userLName!.toLowerCase(), 'userEmail': userEmail!.toLowerCase(), 'userPhone': userPhone!.toLowerCase(), 'userCity': userCity!.toLowerCase(), 'userStreet': userStreet!.toLowerCase(), 'userPassword': userPassword!.toLowerCase()});
      var jsonData = json.decode(response.body);
      if(response.statusCode == 201)
      {
        showDialog
        (
          context: context,
          builder: (ctx) => AlertDialog
          (
            title: const Text("Success"),
            content: const Text("User signed up!"),
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
      }
    }
    catch(e)
    {
      ScaffoldMessenger.of(context).showSnackBar
      (
        SnackBar
        (
          content: Text('$e'),
        )
      );
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
            emailTaken = true;
            userID = user["id"];
            username = user["username"];
            userFName = user["userFName"];
            userLName = user["userLName"];
            userEmail = user["userEmail"];
            userPhone = user["userPhone"];
            userCity = user["userCity"];
            userStreet = user["userStreet"];
          }
          else
          {
            emailTaken = false;
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

  void resetPassword() async 
  {
    try
    {
      var userResponse = await http.put(Uri.parse('${BaseUrl.baseUrl}updateUser/$userID'), body: {'username': username, 'userFName': userFName, 'userLName': userLName, 'userEmail':userEmail, 'userCity': userCity, 'userStreet': userStreet, 'userPhone': userPhone, 'userPassword': userPassword});
      var userJsonData = json.decode(userResponse.body);
      
      if(userResponse.statusCode == 200)
      {
        ScaffoldMessenger.of(context).showSnackBar
        (
          const SnackBar
          (
            content: Text('Password reset!'),
          )
        );
      }
    }
    catch(e)
    {
      print("no internet");
    }
    
  }
  
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: const Text("Confirm your email"),
      ),
      body: SingleChildScrollView
      (
        child: Center
        (
          child: Column
          (
            children: 
            [
              Padding
              (
                padding: EdgeInsets.all(40),
                child: _currentOption == "Send via SMS" 
                ? const Text
                (
                  "Enter the code we have sent by SMS to your number", 
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                  textAlign: TextAlign.center
                )
                : const Text
                (
                  "Enter the code we have sent to your email", 
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                  textAlign: TextAlign.center
                )
              ),
              OtpTextField
              (
                numberOfFields: 6,
                borderColor: Color(0xFF00BCD4),
                showFieldAsBox: true,
                focusedBorderColor: Colors.cyan,
                textStyle: TextStyle(fontSize: 13),
                onSubmit: resetVerification == true
                ? (enteredOTP)
                {
                  if (enteredOTP == otp.toString())
                  {
                    Navigator.pushNamed(context, MyRoutes.resetRoute);    
                  }
                  else
                  {
                    ScaffoldMessenger.of(context).showSnackBar
                    (
                      const SnackBar
                      (
                        content: Text('Invalid OTP!'),
                      )
                    );
                  }
                }
                : (enteredOTP)
                {
                  if (enteredOTP == otp.toString())
                  {
                    signUpUser();  
                    print("signed up!");          
                  }
                  else
                  {
                    ScaffoldMessenger.of(context).showSnackBar
                    (
                      const SnackBar
                      (
                        content: Text('Invalid OTP!'),
                      )
                    );
                  }
                },
              ),
              Padding
              (
                padding: const EdgeInsets.fromLTRB(20,40,0,0),
                child: Row
                (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: 
                  [
                    const Text
                    (
                      "Haven't received a code yet?",
                    ),
                    TextButton
                    (
                      onPressed: () => Navigator.pushNamed(context, MyRoutes.loginRoute),
                      child: const Text
                      (
                        "Send again",
                        style: TextStyle
                        (
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),
                      )
                    )
                  ]               
                ),
              ),
              DropdownButton
              (
                value: _currentOption,
                items: _dropDownMenuItems, 
                onChanged: changedDropDownItem
              )
            ],
          ),
        ),
      ),
    );
  }
  void changedDropDownItem(String? selectedOption)
  {
    setState(() {
      _currentOption = selectedOption;
    });
  }
}

