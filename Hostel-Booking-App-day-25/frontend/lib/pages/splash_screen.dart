import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:splashscreen/splashscreen.dart';
import 'landing_page.dart';

class SplashPage extends StatelessWidget 
{
  const SplashPage ({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) 
  {
    return SplashScreen
    (
      backgroundColor: Color(0xFF00BCD4),
      seconds: 3,
      navigateAfterSeconds: LandingPage(),
      image: Image.asset("assets/images/logos/logoWN.PNG"),
      photoSize: 100,
      loaderColor: Colors.white,
      loadingText: const Text("By BIMAN LAKHEY", style: TextStyle(color: Colors.white))
    );
  }
}