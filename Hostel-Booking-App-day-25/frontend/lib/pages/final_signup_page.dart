import 'package:flutter/material.dart';
import 'package:hotel_booking_app/pages/singnup_page.dart';
import 'package:hotel_booking_app/utils/routes.dart';
import 'package:hotel_booking_app/apis/api.dart';

class FinalSignUpPage extends StatelessWidget {
  TextEditingController userNameControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  TextEditingController confirmPasswordControl = TextEditingController();
  SignupPage signupPage =SignupPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      backgroundColor: Colors.white,
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
                child: Image.asset("assets/images/logos/slogan2.PNG"),
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
                      "User sign up",
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
                        labelText: "Username",
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
                        labelText: "Password",
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
                      decoration: const InputDecoration
                      (
                        hintText: "Re-enter your password",
                        labelText: "Confirm password",
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
                        showDialog
                        (
                          context: context, 
                          builder: (context) => AlertDialog
                          (
                            title: Text("User signed up"),
                            content: Text ("Please login to continue."),
                            actions: <Widget>[
                            TextButton
                            (
                              onPressed: () {
                                Navigator.pushNamed(context, MyRoutes.loginRoute);
                              },
                              child: Text('Close'),
                            )]
                          )
                        );
                        
                      }, 
                      child: const Text
                      (
                        "Sign up",
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
            Padding
            (
              padding: const EdgeInsets.fromLTRB(15,150,0,0),
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