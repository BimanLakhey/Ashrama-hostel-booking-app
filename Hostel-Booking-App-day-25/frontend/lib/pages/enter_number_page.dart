import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/routes.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class EnterNumberPage extends StatelessWidget {
  const EnterNumberPage({ Key? key }) : super(key: key);

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
                      "Enter the number\nassociated with your account",
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
                    IntlPhoneField
                    (
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
                      height: 40.0,
                    ),
                    ElevatedButton
                    (
                      onPressed: () 
                      {
                        Navigator.pushNamed(context, MyRoutes.confirmationRoute);
                      }, 
                      child: const Text
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