import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hotel_booking_app/apis/api.dart';

class FeedbackPage extends StatefulWidget {
  FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> 
{
  
  double finalRating = 0.0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool feedbackSent = false;

  Future<void> send() async {
    final Email email = Email(
      body:"Username: $loggedUserFName $loggedUserLName\nEmail: $loggedUserEmail\nRatings given: ${finalRating.toString()}\nMessage: ${feedbackController.text}",
      subject: "User feedback",
      recipients: ["Ashrama.hostels@gmail.com"],
    );

    String platformResponse;

    try 
    {
      setState(() {
        feedbackSent = false;
      });
      await FlutterEmailSender.send(email);
      platformResponse = 'Thank you for the feedback!';

    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  void checkFeedback()
  {
    if(feedbackController.text == "")
    {
      feedbackController.text = "No feedback";
    }
  }

  TextEditingController feedbackController = TextEditingController();
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        leading: IconButton
        (
          icon: const Icon(CupertinoIcons.arrow_left),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Feedback"),
        centerTitle: true,
        foregroundColor: Colors.white
      ),
      body: SingleChildScrollView
      (
        child: Column
        (
          children: [
            Container
            (
              height: 20,
              color: Color.fromARGB(255, 225, 220, 220),
            ),
            const Align
            (
              alignment: Alignment.centerLeft,
              child: Padding
              (
                padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: Text("Rate Your Experience", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: Colors.black)),
              ),
            ),   
            const Align
            (
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                child: Text("Are you satisfied with the app?", style: TextStyle(color:Color.fromARGB(255, 163, 158, 158), ),),
              )
            ),     
            Align
            (
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 0, 15),
                child: RatingBar.builder
                (
                  unratedColor: Color.fromARGB(255, 225, 220, 220),
                  initialRating: 0,
                  minRating: 0,
                  allowHalfRating: true,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemSize: 60,
                  itemBuilder: (context, _) => const Icon
                  (
                    Icons.star,
                    color: Colors.amber,
                  ), 
                  onRatingUpdate: (rating) 
                  {
                    finalRating = rating;
                  },
                ),
              ),
            ),
            const Padding
            (
              padding: EdgeInsets.symmetric(),
              child:  Divider(color: Color.fromARGB(255, 225, 220, 220), thickness: 1)
            ),
            const Align
            (
              alignment: Alignment.centerLeft,
              child: Padding
              (
                padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: Text("Tell us what can be improved?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
              ),
            ),   
            const SizedBox(height: 25),
            Padding
            (
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container
              (
                decoration: BoxDecoration
                (
                  border: Border.all(color: const Color.fromARGB(255, 225, 220, 220), width: 2),
                ),
                width: 400,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextField
                  (
                    controller: feedbackController,
                    decoration: const InputDecoration
                    (
                      border: InputBorder.none,
                      hintText: "Enter your feedback..."
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton
            (
              onPressed: feedbackSent ? () {} 
              : () 
              {
                checkFeedback();
                send();
                setState(() {
                  feedbackSent = true;
                });
              },
              child: feedbackSent 
              ? const SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2, ))
              : const Text
              (
                "Submit",
                style: TextStyle
                (
                  color: Colors.white
                ),
              ),
              style: ElevatedButton.styleFrom
              (
                primary: Colors.cyan,
                minimumSize: const Size(180, 50),
                side: const BorderSide(width: 2, color: Colors.cyan),
              )
            ),
          ],
        ),
      ),
    );
  }
}