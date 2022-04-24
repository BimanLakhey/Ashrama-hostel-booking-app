import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/pages/confirmation_page.dart';
import 'package:hotel_booking_app/utils/base_url.dart';
import 'package:hotel_booking_app/utils/routes.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class EnterEmailPage extends StatefulWidget {
  EnterEmailPage({ Key? key }) : super(key: key);

  @override
  State<EnterEmailPage> createState() => _EnterEmailPageState();
}

class _EnterEmailPageState extends State<EnterEmailPage> 
{
  TextEditingController emailControl = TextEditingController();
  var otp;
  String? finalOTP;

  bool emailValid = true;
  bool emailNotEmpty = true;
  bool emailTaken = true;
  bool userValid = false;

  void otpGenerator () 
  {
    var rnd = math.Random();
    otp = rnd.nextDouble() * 1000000;
    while (otp < 100000) {
      otp *= 10;
    }
  }

  void checkEmail()
  {
    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailControl.text))
    {
      emailValid = true;
    }
    else
    {
      emailValid = false;
    }
  }

  void isEmailNotEmpty()
  {
    if(emailControl.text.isNotEmpty)
    {
      emailNotEmpty = true;
    }
    else
    {
      emailNotEmpty = false;
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
          if(user["userEmail"] == emailControl.text)
          {
            emailTaken = true;
            userValid = false;
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

  sendOTP() async 
  {
    otpGenerator();
    String email = "Ashrama.hostels@gmail.com";
    String password = 'Hesoyam74';

    final smtpServer = gmail(email, password);

    final message = Message()
      ..from = Address(email, "Ashrama.hostels@gmail.com")
      ..recipients.add(emailControl.text)
      ..subject = "Reset password"
      ..text = "Your OTP is: ${otp.toString().substring(0, otp.toString().indexOf('.'))}";

    try 
    {
      finalOTP = otp.toString().substring(0, otp.toString().indexOf('.')).toString();
      final sendReport = await send(message, smtpServer);
      setState(() {
        userValid = false;
      });
      ScaffoldMessenger.of(context).showSnackBar
      (
        const SnackBar
        (
          content: Text('Sent and OTP to your email!'),
        )
      );
      ConfirmationPage.otp = finalOTP;
      ConfirmationPage.userEmail = emailControl.text;
      ConfirmationPage.resetVerification = true;
      Navigator.pushNamed(context, MyRoutes.confirmationRoute);
    } 
    on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView
      (
        child: Column
        (
          children: [
            Container
            (
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(20.0,100.0,20.0,50.0),
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
                    MediaQuery.of(context).size.width, 60.0
                  )
                ),
              ),
            ),
            SizedBox(height: 100),
            Container
            (
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
                    const Text
                    (
                      "Reset password",
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
                    const Text
                    (
                      "Enter the email\nassociated with your account",
                      textAlign: TextAlign.center,
                      style: TextStyle
                      (
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox
                    (
                      height: 20.0,
                    ),
                    TextFormField
                    (
                      controller: emailControl,
                      decoration: InputDecoration
                      (
                        hintText: "Enter your email",
                        labelText: "Email",
                        errorText: emailNotEmpty ? emailValid ? emailTaken == true ? null : 'Email doesn\'t match any of our registered users!' : 'Invalid email!' : 'Email cannot be empty!'
                      ),
                    ),
                    const SizedBox
                    (
                      height: 40.0,
                    ),
                    ElevatedButton
                    (
                      onPressed: userValid ? () {} : () 
                      async 
                      {
                        await getUserEmails();
                        setState(() 
                        {
                          checkEmail();
                          isEmailNotEmpty();
                          if(emailNotEmpty)
                          {
                            if(emailTaken == true)
                            {
                              if (emailValid)
                              {
                                setState(() 
                                {
                                  userValid = true;
                                });
                                sendOTP();
                              }
                            }
                          }
                        });
                      }, 
                      child: userValid 
                      ? const SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2, ))
                      : const Text
                      (
                        "Send code",
                        style: TextStyle
                        (
                          color: Colors.white
                        ),
                      ),                 
                    ),
                  ],
                ),
              ),        
            ),
          ],
        ),  
      ),
    );
  }
}