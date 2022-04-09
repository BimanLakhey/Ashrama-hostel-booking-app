import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/routes.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    ( 
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column
        (     
          children: 
          [
            Container
            (
              child:  Padding(
                padding: const EdgeInsets.all(60.0),
                child: Image.asset("assets/images/logos/logoWN.PNG"),
              ),
              height: 500.0,
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
            SizedBox(height: 150),
            ElevatedButton
            (
              onPressed: () 
              {
                Navigator.pushNamed(context, MyRoutes.registerRoute);
              }, 
              child: Text
              (
                "Sign up",
                style: TextStyle
                (
                  color: Theme.of(context).backgroundColor,
                  fontSize: 20
                ),
              ),
            ),
            SizedBox(height: 50),
            Padding
            (
              padding: const EdgeInsets.fromLTRB(20,60,0,0),
              child: Row
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: 
                [
                  Text
                  (
                    "Already have an account?",
                    style: TextStyle
                    (
                      color: Colors.black
                    ), 
                  ),
                  TextButton
                  (
                    onPressed: () => Navigator.pushNamed(context, MyRoutes.loginRoute),
                    child: Text
                    (
                      "Login",
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
          ],
        ),
      ),
    );
  }
}