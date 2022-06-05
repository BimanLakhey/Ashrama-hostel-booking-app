import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hotel_booking_app/apis/api.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class FeedbackPage extends StatefulWidget {
  FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> 
{ 
  double finalRating = 0.0;
  bool feedbackSent = false;
  String mainEmail = "Ashrama.hostels@gmail.com";

  sendFeedback() async 
  {
    String email = "Ashrama.feedbacks@gmail.com";
    String password = 'qlppegkqhyqissaw';

    final smtpServer = gmail(email, password);

    final message = Message()
      ..from = Address(email, mainEmail)
      ..recipients.add(mainEmail)
      ..subject = "User feedback"
      ..text = "Submitted by: $loggedUserFName $loggedUserLName\nEmail: $loggedUserEmail\nRatings given: ${finalRating.toString()}\nMessage: ${feedbackController.text}";

    try 
    {
      final sendReport = await send(message, smtpServer);
      setState(() {
        feedbackSent = false;
      });
      ScaffoldMessenger.of(context).showSnackBar
      (
        const SnackBar
        (
          content: Text('Thank you for the feedback!'),
        )
      );
    } 
    on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
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
                  unratedColor: const Color.fromARGB(255, 225, 220, 220),
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
                child: Padding
                (
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextField
                  (
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
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
              onPressed: feedbackSent 
              ? () {} 
              : () 
              {
                checkFeedback();
                sendFeedback();
                setState(() {
                  feedbackSent = true;
                });
              },
              child: feedbackSent 
              ? const SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2, ))
              :  const Text
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