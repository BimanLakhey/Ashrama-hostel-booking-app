import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/pages/confirmation_page.dart';
import 'package:hotel_booking_app/utils/routes.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class SignupPage extends StatefulWidget {

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  @override
  void dispose() {
    super.dispose();
  }

  bool emailValid = true;
  bool passwordsValid = true;

  bool firstNameNotEmpty = true;
  bool lastNameNotEmpty = true;
  bool emailNotEmpty = true;
  bool usernameNotEmpty = true;
  bool passwordNotEmpty = true;
  bool confirmNotEmpty = true;
  bool hostelNotEmpty = true;
  bool licenseNotEmpty = true;
  bool addressNotEmpty = true;
  bool userValid = false;

  TextEditingController firstNameControl = TextEditingController();
  TextEditingController lastNameControl = TextEditingController();
  TextEditingController emailControl = TextEditingController();
  TextEditingController phoneNumControl = TextEditingController();
  TextEditingController addressControl = TextEditingController();
  TextEditingController hostelsControl = TextEditingController();
  TextEditingController licenseControl = TextEditingController();
  TextEditingController userNameControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  TextEditingController confirmPasswordControl = TextEditingController();

  var otp;
  String? finalOTP;

  void otpGenerator () 
  {
    var rnd = math.Random();
    otp = rnd.nextDouble() * 1000000;
    while (otp < 100000) {
      otp *= 10;
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
      ..subject = "Verify email address"
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
          content: Text('Sent and OTP to your email.\nPlease verify your email address!'),
        )
      );
      ConfirmationPage.otp = finalOTP;
      ConfirmationPage.username = userNameControl.text;
      ConfirmationPage.userFName = firstNameControl.text;
      ConfirmationPage.userLName = lastNameControl.text;
      ConfirmationPage.userEmail = emailControl.text;
      ConfirmationPage.userPhone = phoneNumControl.text;
      ConfirmationPage.userAddress = addressControl.text;
      ConfirmationPage.userPassword = passwordControl.text;
      Navigator.pushNamed(context, MyRoutes.confirmationRoute);
    } 
    on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
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

  void isFirstNameNotEmpty()
  {
    if(firstNameControl.text.isNotEmpty)
    {
      firstNameNotEmpty = true;
    }
    else
    {
      firstNameNotEmpty = false;
    }
  }

  void isLastNameNotEmpty()
  {
    if(lastNameControl.text.isNotEmpty)
    {
      lastNameNotEmpty = true;
    }
    else
    {
      lastNameNotEmpty = false;
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

  void isUsernameNotEmpty()
  {

    if(userNameControl.text.isNotEmpty)
    {
      usernameNotEmpty = true;
    }
    else
    {
      usernameNotEmpty = false;
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

  void isAddressNotEmpty()
  {
    if(addressControl.text.isNotEmpty)
    {
      addressNotEmpty = true;
    }
    else
    {
      addressNotEmpty = false;
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
          children: 
          [
            Container
            (
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(20.0,100.0,20.0,50.0),
                child: Image.asset("assets/images/logos/sloganAlt.PNG"),
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
            SizedBox(height: 50),
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
                      "Singup user",
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
                      controller: firstNameControl,
                      decoration: InputDecoration
                      (
                        hintText: "Enter your first name",
                        labelText: "First name",
                        errorText: firstNameNotEmpty ? null : 'First name cannot be empty!'
                      ),
                    ),
                    const SizedBox
                    (
                      height: 20.0,
                    ),
                    TextFormField
                    (
                      controller: lastNameControl,
                      decoration: InputDecoration
                      (
                        hintText: "Enter your last name",
                        labelText: "Last name",
                        errorText: lastNameNotEmpty ? null : 'Lastname cannot be empty!'
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
                        errorText: emailNotEmpty ? emailValid ? null : 'Invalid email!' : 'Email cannot be empty!'
                      ),
                    ),
                    const SizedBox
                    (
                      height: 20.0,
                    ),
                    IntlPhoneField
                    (
                      controller: phoneNumControl,
                      showCountryFlag: false,
                      decoration: const InputDecoration
                      (
                          labelText: "Phone number",
                          hintText: "Enter your phone number"   
                      ),
                      initialCountryCode: 'NP',
                    ),
                    const SizedBox
                    (
                      height: 20.0,
                    ),
                    TextFormField
                    (
                      controller: userNameControl,
                      decoration: InputDecoration
                      (
                        hintText: "Enter your username",
                        labelText: "Username",
                        errorText: usernameNotEmpty ? null : 'Username cannot be empty!'
                      ),
                    ),
                    const SizedBox
                    (
                      height: 20.0,
                    ),
                    TextFormField
                    (
                      controller: passwordControl,
                      decoration: InputDecoration
                      (
                        hintText: "Enter your password",
                        labelText: "Password",
                        errorText: passwordNotEmpty ? null : 'Password cannot be empty!'
                      ),
                      obscureText: true,
                    ),
                    const SizedBox
                    (
                      height: 20.0,
                    ),
                    TextFormField
                    (
                      controller: confirmPasswordControl,
                      decoration: InputDecoration
                      (
                        hintText: "Re-enter your password",
                        labelText: "Confirm password",
                        errorText: confirmNotEmpty ? passwordsValid ? null : 'Passwords did not match!' : 'Confirm password cannot be empty!'
                      ),
                      obscureText: true,
                    ),
                    const SizedBox
                    (
                      height: 20.0,
                    ),
                    TextFormField
                    (
                      controller: addressControl,
                      decoration: InputDecoration
                      (
                        hintText: "Enter your address",
                        labelText: "Address",
                        errorText: addressNotEmpty ? null : 'Address cannot be empty!'
                      ),
                    ),
                    const SizedBox
                    (
                      height: 40.0,
                    ),
                    
                    ElevatedButton.icon
                    (

                      onPressed: userValid ? () {} : () 
                      {
                        setState(() {
                          checkEmail();
                          isFirstNameNotEmpty();
                          isLastNameNotEmpty();
                          isEmailNotEmpty();
                          isUsernameNotEmpty();
                          isPasswordNotEmpty();
                          isConfirmNotEmpty();
                          isAddressNotEmpty();
                          checkPasswords();
                        });
                        
                        if(firstNameNotEmpty && lastNameNotEmpty && emailNotEmpty && usernameNotEmpty && passwordNotEmpty && confirmNotEmpty &&  addressNotEmpty)
                        {
                          if (emailValid)
                          {
                            if (passwordsValid)
                            {
                              setState(() {
                                userValid = true;
                              });
                              sendOTP();
                            }
                          }
                        }
                      },    
                      label: userValid 
                      ? const SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2, ))
                      : const Text
                      (
                        "Continue",
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
                        side: BorderSide(width: 2, color: Colors.cyan),
                      )
                    ),
                  ],
                ),
              ),        
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
                    "Already have an account?",
                  ),
                  TextButton
                  (
                    onPressed: () 
                    {
                      Navigator.pushNamed(context, MyRoutes.loginRoute);
                    }, 
                    child: const Text
                    (
                      "Login",
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
    );
  }
}