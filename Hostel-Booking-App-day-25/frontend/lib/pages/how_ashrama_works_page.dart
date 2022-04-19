import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/routes.dart';

class HowAshramaWorksPage extends StatelessWidget {
  HowAshramaWorksPage({Key? key}) : super(key: key);

  Color fontColorAlt = Colors.white;
  Color containerColorAlt = Colors.white;
  Color buttonFontColorAlt = Colors.cyan;
  Color backgroundColorAlt = Colors.cyan;
  Color fontColor = Colors.black;
  Color containerColor = Colors.cyan;
  Color buttonFontColor = Colors.white;
  Color backgroundColor = Colors.white;
  bool alt = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
      (
        leading: IconButton
        (
          icon: const Icon(CupertinoIcons.arrow_left),
          onPressed: () => Navigator.pushNamed(context, MyRoutes.homeRoute),
        ),
        title: const Text("How ashrama works"),
        centerTitle: true,
      ), 
      backgroundColor: alt ? backgroundColorAlt : backgroundColor,
      body: SingleChildScrollView
      (
        child: Column
        (
          children: 
          [
            Align
            (
              alignment: Alignment.topLeft,
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Text("You are just 3 steps away from your next getaway", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: alt ? fontColorAlt : fontColor)),
              ),
            ),        
            const SizedBox(height: 50),
            Align
            (
              alignment: Alignment.centerLeft,
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: Text("1. Browse", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: alt ? fontColorAlt : fontColor)),
              ),
            ),
            SizedBox(height: 30),
            Padding
            (
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText
              (
                textAlign: TextAlign.justify,
                text: TextSpan
                (
                  style: TextStyle(wordSpacing: 1, fontSize: 16, color: alt ? fontColorAlt : fontColor),
                  text: "Start by exploring Hostels. Apply filters like entire rooms or self check-in to narrow your options. You can also save your favourite hostels to a wish list.",
                )
              ),
            ),           
            const SizedBox(height: 50),
            Align
            (
              alignment: Alignment.centerLeft,
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: Text("2. Book", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: alt ? fontColorAlt : fontColor)),
              ),
            ),
            SizedBox(height: 30),
            Padding
            (
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText
              (
                textAlign: TextAlign.justify,
                text: TextSpan
                (
                  style: TextStyle(wordSpacing: 1, fontSize: 16, color: alt ? fontColorAlt : fontColor),
                  text: "Once you've found what you're looking for, learn about your host, read past guest reviews and get the details on cancellation options - then book in just a few clicks.",
                )
              ),
            ),  
            const SizedBox(height: 50),
            Align
            (
              alignment: Alignment.centerLeft,
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: Text("3. Go", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: alt ? fontColorAlt : fontColor)),
              ),
            ),
            SizedBox(height: 30),
            Padding
            (
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText
              (
                textAlign: TextAlign.justify,
                text: TextSpan
                (
                  style: TextStyle(wordSpacing: 1, fontSize: 16, color: alt ? fontColorAlt : fontColor),
                  text: "You're all set! Connect with your host through the app for local tips, questions or advice. You can also contact Ashrama anytime for additional support.",
                )
              ),
            ),  
            const Padding
            (
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child:  Divider(color: Colors.black26, thickness: 1)
            ),
            Align
            (
              alignment: Alignment.topLeft,
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: RichText
                (
                  textAlign: TextAlign.justify,
                  text: TextSpan
                  (
                    style: TextStyle(wordSpacing: 3, fontWeight: FontWeight.bold, fontSize: 22, color: alt ? fontColorAlt : fontColor),
                    text: "Wherever you go,\n",
                    children: const [
                      TextSpan(text: "we're here to help")
                    ]
                  )
                ),  
              ),
            ),       
            Align
            (
              alignment: Alignment.topLeft,
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: RichText
                (
                  textAlign: TextAlign.justify,
                  text: TextSpan
                  (
                    style: TextStyle(wordSpacing: 1, fontWeight: FontWeight.bold, fontSize: 20, color: alt ? fontColorAlt : fontColor),
                    text: "Health and safety is a priority\n\n",
                    children: const [
                      TextSpan(text: "Hosts are commiting to enhanced COVID-19 cleaning protocols, and listings are rated for cleanliness.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal))
                    ]
                  )
                ),  
              ),
            ),      
            Align
            (
              alignment: Alignment.topLeft,
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
                child: RichText
                (
                  textAlign: TextAlign.justify,
                  text: TextSpan
                  (
                    style: TextStyle(wordSpacing: 1, fontWeight: FontWeight.bold, fontSize: 20, color: alt ? fontColorAlt : fontColor),
                    text: "More cancellation options\n\n",
                    children: const [
                      TextSpan(text: "Hosts can offer a range of flexible cancellation options which are clearly stated at the time of booking.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal))
                    ]
                  )
                ),  
              ),
            ),        
            Align
            (
              alignment: Alignment.topLeft,
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
                child: RichText
                (
                  textAlign: TextAlign.justify,
                  text: TextSpan
                  (
                    style: TextStyle(wordSpacing: 1, fontWeight: FontWeight.bold, fontSize: 20, color: alt ? fontColorAlt : fontColor),
                    text: "Support anytime, day or night\n\n",
                    children: const [
                      TextSpan(style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal), text: "With 24/7 global customer support, we're there for you whenever you need assistance.")
                    ]
                  )
                ),  
              ),
            ),      
            const Padding
            (
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child:  Divider(color: Colors.black26, thickness: 1)
            ),
            Container
            (           
              height: 250,
              child: Stack
              (
                fit: StackFit.expand,
                children: <Widget>
                [
                  Image.asset("assets/images/logos/room.jfif", fit: BoxFit.fill),
                  Padding
                  (
                    padding: const EdgeInsets.all(5.0),
                    child: Align
                    (
                      alignment: Alignment.center,
                      child: Container
                      (
                        height: 150,
                        width: 175,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column
                          (
                            children: [
                              const Text("Ready to start searching?", style: TextStyle(color: Colors.white, fontSize: 25)),
                              const SizedBox(height: 20),
                              ElevatedButton.icon
                              (
                                onPressed: () => Navigator.pushNamed(context, MyRoutes.homeRoute), 
                                icon: const Icon(Icons.arrow_right_alt, color: Colors.white,), 
                                label: const Text("Explore now", style: TextStyle(color: Colors.white),), 
                              )
                            ],
                          ),
                        ),
                      )
                    ),
                  )
                ],
              )
            ),
          ]
        )
      )
    );
  }
}