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
  static String? userAddress;
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

  String? otp = ConfirmationPage.otp;
  String? username = ConfirmationPage.username;
  String? userFName = ConfirmationPage.userFName;
  String? userLName = ConfirmationPage.userLName;
  String? userEmail = ConfirmationPage.userEmail;
  String? userPhone = ConfirmationPage.userPhone;
  String? userPassword = ConfirmationPage.userPassword;
  String? userAddress = ConfirmationPage.userAddress;

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

  void signUpUser() async {
    try
    {
      var response = await http.post(Uri.parse('${BaseUrl.baseUrl}registerUser/'), body: {'username': username!.toLowerCase(), 'userFName': userFName!.toLowerCase(), 'userLName': userLName!.toLowerCase(), 'userEmail': userEmail!.toLowerCase(), 'userPhone': userPhone!.toLowerCase(), 'userAddress': userAddress!.toLowerCase(), 'userPassword': userPassword!.toLowerCase()});
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
  
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: const Text("Confirm your number"),
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
                onSubmit: (enteredOTP)
                {
                  if (enteredOTP == otp)
                  {
                    signUpUser();
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

