import 'package:flutter/material.dart';
import 'package:hotel_booking_app/pages/confirmation_page.dart';
import 'package:hotel_booking_app/pages/enter_number_page.dart';
import 'package:hotel_booking_app/pages/final_signup_page.dart';
import 'package:hotel_booking_app/pages/hostel_details_page.dart';
import 'package:hotel_booking_app/pages/hostel_owner_details_page.dart';
import 'package:hotel_booking_app/pages/hostel_profile_page.dart';
import 'package:hotel_booking_app/pages/hostel_room_details.dart';
import 'package:hotel_booking_app/pages/login_page.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:hotel_booking_app/pages/manage_hostel_page.dart';
import 'package:hotel_booking_app/pages/profile_page.dart';
import 'package:hotel_booking_app/pages/singnup_page.dart';
import 'package:hotel_booking_app/pages/reset_password_page.dart';
import 'package:hotel_booking_app/pages/splash_screen.dart';
// import 'package:hotel_booking_app/pages/test.dart';
import 'package:hotel_booking_app/utils/bottom_navigation.dart';
import 'package:hotel_booking_app/utils/routes.dart';

void main()
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp
    (
      themeMode: ThemeMode.light,
      theme: ThemeData
      (
        appBarTheme: const  AppBarTheme
        (
          centerTitle: true,
          foregroundColor: Colors.white
        ),
        backgroundColor: Colors.white,
        primarySwatch: Colors.cyan,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData
        (
          style: ElevatedButton.styleFrom
          (
            minimumSize: const Size(175, 40),
            side: const BorderSide(width: 2, color: Colors.cyan), 
            shape: RoundedRectangleBorder( //to set border radius to button
                borderRadius: BorderRadius.circular(30)
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData
      (
        backgroundColor: Colors.black54,
        colorScheme: ColorScheme.fromSwatch().copyWith
        (
          primary:Colors.cyan,
          secondary: Colors.white54
        ),
        elevatedButtonTheme: ElevatedButtonThemeData
        (
          style: ElevatedButton.styleFrom
          (
            primary: Colors.cyan,
            minimumSize: const Size(175, 40),
            side: const BorderSide(width: 2, color: Colors.cyan), 
            shape: RoundedRectangleBorder( //to set border radius to button
                borderRadius: BorderRadius.circular(30)
            ),
          ),
        ),
      ),
      routes: 
      {
        "/": (context) => SplashPage(),
        MyRoutes.homeRoute: (context) => BottomNavigation(),
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.registerRoute: (context) => SignupPage(),
        MyRoutes.resetRoute: (context) => ResetPage(),
        MyRoutes.profileRoute: (context) => ProfilePage(),
        MyRoutes.confirmationRoute: (context) => ConfirmationPage(),
        MyRoutes.signinRoute: (context) => FinalSignUpPage(),
        MyRoutes.enterNumberRoute: (context) => EnterNumberPage(),
        MyRoutes.hostelDetailsRoute: (context) => RegisterHostelPage(),
        MyRoutes.hostelOwnerDetailsRoute: (context) => HostelOwnerDetailsPage(),
        MyRoutes.hostelRoomDetailsRoute: (context) => HostelRoomDetailsPage(),
        MyRoutes.hostelProfileRoute: (context) => HostelProfilePage(),
        MyRoutes.manageHostelRoute: (context) => ManageHostelPage(),
      }
    );
  }
}