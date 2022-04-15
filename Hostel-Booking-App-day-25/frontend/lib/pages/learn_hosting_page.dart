import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/routes.dart';
import 'dart:ui' as ui;

class LearnHostingPage extends StatelessWidget {
  LearnHostingPage({Key? key}) : super(key: key);

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
        title: const Text("Learn about hosting"),
        centerTitle: true,
      ), 
      backgroundColor: alt ? backgroundColorAlt : backgroundColor,
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
                padding: const EdgeInsets.fromLTRB(20.0,50.0,20.0,50.0),
                child: alt? Image.asset("assets/images/logos/learnHostingAlt.PNG") : Image.asset("assets/images/logos/learnHosting.PNG"),
              ),
              height: 250,
              decoration: BoxDecoration
              (
                color: alt ? containerColorAlt : containerColor,
                borderRadius: BorderRadius.vertical
                (
                  bottom: Radius.elliptical
                  (
                    MediaQuery.of(context).size.width, 60.0)
                  ),
              ),
            ),
            const SizedBox(height: 50),
            Align
            (
              alignment: Alignment.centerLeft,
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: Text("What may guests expect from hosts?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: alt ? fontColorAlt : fontColor)),
              ),
            ),            
            const SizedBox(height: 30),
            Padding
            (
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText
              (
                textAlign: TextAlign.justify,
                text: TextSpan
                (
                  style: TextStyle(wordSpacing: 1, fontSize: 16, color: alt ? fontColorAlt : fontColor),
                  text: "We want to provide you precise instructions so you know what to anticipate and can consistently provide a 5-star experience when you share your property.\n\nAll hosts must achieve four key criteria: overall rating, response rate, cancellations, and reservation acceptance. You'll also receive feedback from people who stay with you, in addition to the fundamentals.\n\nAre you already a host? To see how you're doing, go to your ",
                  children: 
                  [
                    TextSpan
                    (
                      text: "Manage hostel", 
                      style: const TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline), 
                      recognizer: TapGestureRecognizer()..onTap = () 
                      {
                        Navigator.pushNamed(context, MyRoutes.manageHostelRoute);
                      }
                    ),
                    const TextSpan(text: " page.")
                  ]
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
                child: Text("Basic requirements", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: alt ? fontColorAlt : fontColor)),
              ),
            ),            
            const SizedBox(height: 30),
            Padding
            (
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText
              (
                textAlign: TextAlign.justify,
                text: TextSpan
                (
                  style: TextStyle(wordSpacing: 1, fontSize: 16, color: alt ? fontColorAlt : fontColor),
                  text: "All houses and hosts must satisfy four fundamental conditions in order to provide visitors with comfortable and trustworthy stays.\n\n\n",
                  children: 
                  const 
                  [
                    TextSpan
                    (
                      text: "Be responsive\n\n", 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400), 
                    ),
                    TextSpan(text: "When visitors contact you, responding swiftly demonstrates that you are a thoughtful and attentive host. Your response rate is a measure of how frequently and fast you react to reservation requests and booking queries. We request that hosts react to these alerts within 24 hours.\n\n\n"),
                    TextSpan
                    (
                      text: "Accept reservation requests\n\n", 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400), 
                    ),
                    TextSpan(text: "No one wants to have to make four or five requests to locate a spot, therefore we expect you to accept the majority of requests if your calendar shows you're available. Make sure the calendar on your listing represents the days you're available to host. You'll be more likely to receive reservation requests that you can truly satisfy if you do it this way. You may utilize your availability options to restrict requests for same-day appointments or reservations that are too distant in the future, or to limit time off between bookings.\n\n\n"),
                    TextSpan
                    (
                      text: "Avoid cancelling on guests\n\n", 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400), 
                    ),
                    TextSpan(text: "We take cancellations very seriously, and we urge that all hosts avoid canceling on their guests–their travel plans are on the line! If you cancel a confirmed booking, you will face consequences, including financial penalties. Unless there are exceptional circumstances, we urge that you refrain from canceling booked reservations.\n\n\n"),
                    TextSpan
                    (
                      text: "Get positive reviews\n\n", 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400), 
                    ),
                    TextSpan(text: "Guests want to know that no matter where they book, they can get the same level of service. Guests will rate their experience with you at the conclusion of each stay, which is one of the ways we evaluate you as a host. Your overall rating is the average of all the reviews you've received from the guests you've hosted.\n\n"),
                    TextSpan(text: "As a host, you'll have the chance to review your visitors on cleanliness, courtesy, and communication. Your input allows us to guarantee that guests treat the houses as if they were their own. Guests who are flagged by hosts on a regular basis may face fines.\n\n\n")
                  ]
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
                child: Text("Getting great reviews from guests", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: alt ? fontColorAlt : fontColor)),
              ),
            ),    
            const SizedBox(height: 30),
            Padding
            (
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText
              (
                textAlign: TextAlign.justify,
                text: TextSpan
                (
                  style: TextStyle(wordSpacing: 1, fontSize: 16, color: alt ? fontColorAlt : fontColor),
                  text: "Cleanliness, vital amenities, correct listing facts, a seamless check-in, and proactive communication are five things we've discovered that hosts who earn outstanding ratings focus on.\n\n\n",
                ),
              )
            ),  
            const SizedBox(height: 50),
            Align
            (
              alignment: Alignment.centerLeft,
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: Text("Cleanliness", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: alt ? fontColorAlt : fontColor)),
              ),
            ),    
            const SizedBox(height: 30),
            Padding
            (
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText
              (
                textAlign: TextAlign.justify,
                text: TextSpan
                (
                  style: TextStyle(wordSpacing: 1, fontSize: 16, color: alt ? fontColorAlt : fontColor),
                  text: "Guests will anticipate the spotless environment depicted in your listing images. Make sure you provide adequate time between visitors to clean, especially if you have many reservations.\n\n",
                  children:<InlineSpan> [
                    const TextSpan(text: "Guests will be able to score your space's cleanliness, and the average of their evaluations will display on your listing page. You may face fines if you frequently earn low cleanliness ratings.\n\n\n"),
                    WidgetSpan(child: Icon(CupertinoIcons.check_mark_circled, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  WHAT'S EXPECTED\n\n", 
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400), 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  Clean every space that guests have access to, including the bedrooms, bathrooms, and kitchen.\n\n", 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  Make sure surfaces and floors are free of hair, dust, and mold.\n\n", 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  Between each stay, do a turnover: Provide visitors with clean linens/sheets and towels. Clear trash, food, and leftover items from previous guests.\n\n\n", 
                    ),
                    WidgetSpan(child: Icon(CupertinoIcons.lightbulb, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  TIPS\n\n", 
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400), 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  allow yourself more time to prepare between guests, spread out your reservations. You can adjust your reservation choices to block a night or two ahead of time.\n\n", 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  Charge a cleaning charge and utilize the excess funds to purchase cleaning materials or hire a cleaning service.\n\n", 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  Leave cleaning tools in your area so that your visitors may clean up spills and other mishaps.\n\n\n", 
                    ),
                  ]
                ),
              )
            ), 
            Align
            (
              alignment: Alignment.centerLeft,
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: Text("Essential amenities", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: alt ? fontColorAlt : fontColor)),
              ),
            ),    
            const SizedBox(height: 30),
            Padding
            (
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText
              (
                textAlign: TextAlign.justify,
                text: TextSpan
                (
                  style: TextStyle(wordSpacing: 1, fontSize: 16, color: alt ? fontColorAlt : fontColor),
                  text: "We urge that all hosts give the necessary facilities to ensure that their visitors are comfortable and have a decent night's sleep.\n\n",
                  children:<InlineSpan> 
                  [
                    
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  Toilet paper\n\n", 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  Soap\n\n", 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  Linens/sheets.\n\n", 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  At least one towel per booked guest.\n\n", 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  At least one pillow per booked guest.\n\n", 
                    ),
                  ]
                ),
              )
            ), 
            Align
            (
              alignment: Alignment.centerLeft,
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: Text("Accurate listing details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: alt ? fontColorAlt : fontColor)),
              ),
            ),    
            const SizedBox(height: 30),
            Padding
            (
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText
              (
                textAlign: TextAlign.justify,
                text: TextSpan
                (
                  style: TextStyle(wordSpacing: 1, fontSize: 16, color: alt ? fontColorAlt : fontColor),
                  text: "Setting the correct expectations before a vacation will help both you and your visitors have a better time. By giving clear information and essential facts such as whether you allow dogs, you can assist guests in determining if your facility fulfills their needs. A thorough listing and profile can help you attract guests seeking for a location similar to yours.\n\n",
                  children:<InlineSpan> [
                    const TextSpan(text: "Guests will be able to give you feedback on how accurate the information you present is.\n\n\n"),
                    const TextSpan
                    (
                      text: "LISTING INFORMATION\n\n", 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400), 
                    ),
                    WidgetSpan(child: Icon(CupertinoIcons.check_mark_circled, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  WHAT'S EXPECTED\n\n", 
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400), 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  Address that is correct and up to date (this will be shared only after guest has booked).\n\n", 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  The privacy features for the bedroom and bathroom are correct.\n\n", 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  The listing photographs accurately depict the space's condition and layout.\n\n", 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  Amenities are as described, present, and working.\n\n\n", 
                    ),
                    WidgetSpan(child: Icon(CupertinoIcons.lightbulb, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  TIPS\n\n", 
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400), 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  Write a descriptive description of the place and include a choice of high-quality images with descriptions.\n\n", 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  Establish House Rules that address issues that will concern your visitors. Your rules can help clarify what you accept and don't allow, such as smoking, pets, or extra guests.\n\n", 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  Inform guests if there are any areas of the property that are off-limits, such as the garage or the attic.\n\n", 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  Be open and honest about any unforeseen circumstances that may affect your visitors' stay. Your visitors have a right to know if your neighbors are working on a noisy construction project next door or if they'll have to climb eight flights of stairs to get to your property.\n\n\n", 
                    ),
                    const TextSpan
                    (
                      text: "AMENITIES\n\n", 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400), 
                    ),
                    const TextSpan
                    (
                      text: "Make a list of all the facilities you provide and double-check that they are all present and operating.\n\n\n", 
                    ),
                    const TextSpan
                    (
                      text: "NIGHTLY PRICE\n\n", 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400), 
                    ),
                    const TextSpan
                    (
                      text: "Make sure the size of your area corresponds to the price you've specified. A extremely high price may induce visitors to believe your offering is more opulent. Do you require assistance? Look at more properties in your area or switch on Smart Pricing to see what else is available.\n\n\n", 
                    ),
                  ]
                ),
              )
            ), 
            Align
            (
              alignment: Alignment.centerLeft,
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: Text("Easy check-in", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: alt ? fontColorAlt : fontColor)),
              ),
            ),    
            const SizedBox(height: 30),
            Padding
            (
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText
              (
                textAlign: TextAlign.justify,
                text: TextSpan
                (
                  style: TextStyle(wordSpacing: 1, fontSize: 16, color: alt ? fontColorAlt : fontColor),
                  text: "After a long day of travel, your guests will appreciate a straightforward and quick check-in process. At the conclusion of their stay, guests will be asked to review their check-in experience.\n\n",
                  children:<InlineSpan> [
                    WidgetSpan(child: Icon(CupertinoIcons.lightbulb, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  TIPS\n\n", 
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400), 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  Create a check-in guide for your property, and we'll send it to your visitors 24 hours before their arrival to ensure they have everything they need.\n\n", 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  If you want to meet your visitors in person, schedule a check-in time ahead of time.\n\n", 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  If you provide self-check-in, include that information in your listing's Guest resources section.\n\n", 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  Ascertain that your visitors know how to contact you in the event of a travel delay or a last-minute query.\n\n", 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  Provide precise directions to your visitors for arriving to your home—you may save time by including everything in your house manual.\n\n\n", 
                    ),
                  ]
                ),
              )
            ), 
            Align
            (
              alignment: Alignment.centerLeft,
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: Text("Supporting guests during their stay", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: alt ? fontColorAlt : fontColor)),
              ),
            ),    
            const SizedBox(height: 30),
            Padding
            (
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText
              (
                textAlign: TextAlign.justify,
                text: TextSpan
                (
                  style: TextStyle(wordSpacing: 1, fontSize: 16, color: alt ? fontColorAlt : fontColor),
                  text: "It's critical to be available to your visitors during their stay, whether or not you're staying in the space with them. At the conclusion of their stay, your visitors will be able to review the clarity and consistency of your communication, and the average of these guest evaluations will display on your listing page.\n\n",
                  children:<InlineSpan> [
                    WidgetSpan(child: Icon(CupertinoIcons.lightbulb, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  TIPS\n\n", 
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400), 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  Make sure visitors know you're available by being proactive in your communication. Make contact as soon as possible to discuss arrival plans. If you won't be there to welcome your visitors when they arrive, you may send them a note at the time of their check-in to ensure everything went successfully.\n\n", 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  If something about your listing changes after you confirm a reservation, inform your visitor ahead of time.\n\n", 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  Install the Ashrama app to be able to react to messages from anywhere.\n\n", 
                    ),
                    WidgetSpan(alignment: ui.PlaceholderAlignment.middle, child: Icon(CupertinoIcons.circle_fill, size: 10, color: alt ?  fontColorAlt: fontColor),),
                    const TextSpan
                    (
                      text: "  You may provide your guests with a local point of contact if you won't be in the region during their stay.\n\n", 
                    ),
                  ]
                ),
              )
            ), 
          ],
        ),
      ),

    );
  }
}