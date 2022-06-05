import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hotel_booking_app/Model/hostel_model.dart';
import 'package:hotel_booking_app/apis/api.dart';
import 'package:hotel_booking_app/pages/notification_page.dart';
import 'package:hotel_booking_app/utils/base_url.dart';
import 'package:hotel_booking_app/utils/notifications.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:intl/intl.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class HostelProfilePage extends StatefulWidget {
  const HostelProfilePage({Key? key}) : super(key: key);
  static String? hostelID;

  @override
  State<HostelProfilePage> createState() => _HostelProfilePageState();
}

class _HostelProfilePageState extends State<HostelProfilePage> 
{
  Future? hostelUserReviews;
  String? profileType = "details";
  HostelModel hostelModel = HostelModel();
  String? hostelID = HostelProfilePage.hostelID;
  String? hostelName;
  String? hostelPhoto;
  String? hostelCity;
  String? hostelStreet;
  String? hostelPhone; 
  String? hostelTotalRooms; 
  String? hostelOwnerID; 
  bool dataLoaded = false;
  Color borderColor = Colors.cyan;
  Color fontColor = Colors.white;
  Color backgroundColor = Colors.cyan;
  Color buttonFontColor = Colors.white;
  Color ratingColor = const Color.fromARGB(255, 225, 220, 220);
  Color dividerColor = Colors.white;
  Color containerColor = Colors.white;
  Color containerFontColor = Colors.cyan;

  Color borderColorAlt = Colors.cyan;
  Color fontColorAlt = Colors.black;
  Color backgroundColorAlt = Colors.white;
  Color buttonFontColorAlt = Colors.white;
  Color ratingColorAlt = Colors.white;
  Color dividerColorAlt = Colors.white;
  Color containerColorAlt = Colors.cyan;
  Color buttonColorAlt = Colors.cyan;
  Color containerFontColorAlt = Colors.black;
  bool alt = true;
  bool bookingConfirmed = false;
  double averageRatings = 0.0;
  double totalRatings = 0.0;

  TextEditingController reviewController = TextEditingController();

  String? hID;
  String? uID;
  String? rID;
  String? finalRating = "0.0";
  String? reviewDate = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
  String? bookedDate = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
  String? checkingOutDate = "${DateTime.now().year}-${DateTime.now().month + 1}-${DateTime.now().day}";
  String? roomType;
  String? roomPrice;
  Future? myRooms;
  @override
  void initState()
  {
    getHostelData();
    hostelUserReviews = getHostelReviews();
    averageReviews();
    setState(() 
    {
      
    });   
    myRooms = getRooms();
    super.initState();

  }
  
  @override
  void dispose() {
    super.dispose();
  }

  void averageReviews()
  {

    for(int j = 0; j < reviews.length - 1; j++)
    {
      // print("${totalRatings.toString()}");
      // print("$totalRatings + ${double.parse(reviews[j].rating)}");
      totalRatings = totalRatings + double.parse(reviews[j].rating);
      // print(totalRatings);
    }
    averageRatings = totalRatings / reviews.length;
  }

  sendMail() async 
  {
    String email = "Ashrama.hostels@gmail.com";
    String password = 'spikhhueqoqjosym';

    final smtpServer = gmail(email, password);

    final message = Message()
      ..from = Address(email, "Ashrama.hostels@gmail.com")
      ..recipients.add(loggedUserEmail)
      ..subject = "Booking confirmed"
      ..text = "Booked by: $loggedUserFName $loggedUserLName\nBooking date: $bookedDate\nChecking out date: $checkingOutDate\nHostel name: $hostelName\nRoom details: $roomType\nTotal price to be paid: Rs.$roomPrice\n\n Please visit the hostel on the booked date!";

    try 
    {
      final sendReport = await send(message, smtpServer);
      setState(() {
        bookingConfirmed = false;
      });
      bookingConfirmedNotification();
    } 
    on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  void getHostelData() async 
  {
    var response = await http.get(Uri.parse('${BaseUrl.baseUrl}hostelProfile/$hostelID'));
    var jsonData = json.decode(response.body);
    
    setState(() {
      hostelModel = HostelModel.fromJson({"data": jsonData});
      dataLoaded = true;
      
    });
    hostelID = jsonData["id"].toString();
    hostelName = jsonData["hostelName"];
    hostelPhoto = jsonData["hostelPhoto"];
    hostelCity = jsonData["hostelCity"];
    hostelStreet = jsonData["hostelStreet"];
    hostelPhone = jsonData["hostelPhone"];
    hostelTotalRooms = jsonData["hostelTotalRooms"];
  }

  void bookHostel() async 
  {
    var response = await http.post
    (
      Uri.parse('${BaseUrl.baseUrl}bookedHostels/'), 
      // headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
      body: {'hostelID': hID, 'userID': uID, 'roomType': roomType, 'bookingDate': bookedDate, 'checkingOutDate': checkingOutDate, 'roomID': rID}
    );
    var jsonData = json.decode(response.body);
    if(response.statusCode == 201)
    {
      print("booked!");
    }
    else
    {
      print("failed!");
    }
  }

  void checkReview()
  {
    if(reviewController.text == "")
    {
      reviewController.text = "No review";
    }
  }

  void postReview() async 
  {
    try
    {
      var reviewResponse = await http.post(Uri.parse('${BaseUrl.baseUrl}userReviews/'), body: {'userID': loggedUserID, 'hostelID': hostelID, 'rating': finalRating, 'review':reviewController.text, 'reviewDate': reviewDate});
      var reviewJsonData = json.decode(reviewResponse.body);
      if(reviewResponse.statusCode == 201)
      {
        ScaffoldMessenger.of(context).showSnackBar
        (
          const SnackBar
          (
            content: Text('Review posted!'),
          )
        );
      }
    }
    catch(e)
    {
      ScaffoldMessenger.of(context).showSnackBar
      (
        const SnackBar
        (
          content: Text('Not connected to the internet!'),
        )
      );
    }
  }

  Future getHostelOwnerID () async
  {
    try
    {
      var response = await http.get(Uri.parse('${BaseUrl.baseUrl}registeredHostels/'));
      var jsonData = json.decode(response.body);
      if(response.statusCode == 200)
      {
        for(var rH in jsonData)
        {
          if(rH["hostelID"] == hostelID)
          {
            hostelOwnerID = rH["userID"];
          }
        }
      }
    }
    catch(e)
    {
      ScaffoldMessenger.of(context).showSnackBar
      (
        const SnackBar
        (
          content: Text('Not connected to the internet!'),
        )
      );
    }
  }

  void saveHostelOwnerNotification () async
  {
    try
    {
      var response = await http.post(Uri.parse('${BaseUrl.baseUrl}userNotifications/'), body: {'userID': hostelOwnerID, 'hostelID': hostelID, 'notificationMessage': "Your hostel was booked by ${loggedUserFName} ${loggedUserLName}", 'notificationDate': "${DateTime.now()}"});
    }   
    catch(e)
    {
      print(e);
    }
  }

  DateTime now = DateTime.now();
  void saveNotification() async 
  {
    try
    {
      var response = await http.post(Uri.parse('${BaseUrl.baseUrl}userNotifications/'), body: {'userID': loggedUserID, 'hostelID': hostelID, 'notificationMessage': "Booked", 'notificationDate': "${DateTime.now()}"});
    }   
    catch(e)
    {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: dataLoaded == false
      ? const Center(child: CircularProgressIndicator( backgroundColor: Colors.cyan))
      : Center
      (
        child: Scaffold
        (
          //backgroundColor: Colors.cyan,
          appBar: AppBar
          (
            leading: IconButton
            (
              icon: const Icon(CupertinoIcons.arrow_left),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(hostelName.toString()),
            centerTitle: true,
            foregroundColor: fontColor
          ),
          backgroundColor: alt? backgroundColorAlt : backgroundColor,
          body: SingleChildScrollView
          (
            child: Column
            (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: 
              [
                FractionallySizedBox
                (
                  widthFactor: 1,
                  child: Container
                  (
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration
                    (
                      borderRadius: BorderRadius.only
                      (
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    height: 200,
                    child: Image.network(BaseUrl.savedBaseUrl + hostelPhoto.toString(), fit: BoxFit.fill),
                  ),
                ),
                Padding
                (
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Row
                  (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: 
                    [
                      SizedBox
                      (
                        width: 225,
                        child: Text
                        (
                          hostelName.toString(),
                          style: TextStyle(fontSize:24, fontWeight: FontWeight.bold, color: alt? fontColorAlt : fontColor)
                        ),
                      ),
                      RatingBar.builder
                      (
                        unratedColor: ratingColor,
                        initialRating: averageRatings.toString() == "NaN" ? 0 : averageRatings,
                        minRating: 0,
                        allowHalfRating: true,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        ignoreGestures: true,
                        itemSize: 25,
                        itemBuilder: (context, _) => const Icon
                        (
                          Icons.star,
                          color: Colors.amber,
                        ), 
                        onRatingUpdate: (rating) 
                        {
                        },
                      )
                    ]
                  ),
                ),
                Padding
                (
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
                  child: Row
                  (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: 
                    [
                      Text(hostelCity.toString() + ', ' + hostelStreet.toString(), style: TextStyle(fontSize:15, color: alt? fontColorAlt : fontColor),),
                      Text(hostelPhone.toString(), style: TextStyle(fontSize:15, color: alt? fontColorAlt : fontColor),),
                    ]
                  ),
                ),
                Padding
                (
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
                  child: Text
                  (
                    "Total available rooms: ${hostelTotalRooms.toString()}",
                    style: TextStyle(fontSize:15, color: alt? fontColorAlt : fontColor),
                  )
                ),
                Padding
                (
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row
                  (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: 
                    [
                      Container
                      (
                        width: 125,
                        height: 45,
                        decoration: BoxDecoration
                        (
                          boxShadow: 
                          const [
                            BoxShadow
                            (
                              color: Colors.black54,
                              offset: Offset(1, 5),
                              blurRadius: 6,
                            )
                          ],
                          color: alt ? buttonColorAlt : buttonFontColor,
                          border: Border.all(color: alt? buttonColorAlt : buttonFontColor, width: 2),
                          borderRadius: BorderRadius.circular(35)
                        ),
                        child: TextButton.icon
                        (
                          style: TextButton.styleFrom
                          (
                            primary: alt ? buttonFontColorAlt : buttonColorAlt,
                          ),
                          onPressed: () 
                          {
                            setState(() {
                              profileType = "details";
                            });
                          },
                          icon: const Icon(Icons.details_outlined), 
                          label: const Text("Details"),
                        ),
                      ),
                      Container
                      (
                        width: 125,
                        height: 45,
                        decoration: BoxDecoration(
                          boxShadow: 
                          const [
                            BoxShadow
                            (
                              color: Colors.black54,
                              offset: Offset(1, 5),
                              blurRadius: 6,
                            )
                          ],
                          color: alt ? buttonColorAlt : buttonFontColor,
                          border: Border.all(color: alt? buttonColorAlt : buttonFontColor, width: 2),
                          borderRadius: BorderRadius.circular(35)
                        ),
                        child: TextButton.icon
                        (
                          style: TextButton.styleFrom
                          (
                            primary: alt ? buttonFontColorAlt : buttonColorAlt,
                          ),
                          onPressed: () 
                          {
                            setState(() 
                            {
                              profileType = "reviews";
                            });
                            hostelUserReviews = getHostelReviews();
                          },
                          icon: const Icon(Icons.reviews_outlined), 
                          label: const Text("Reviews"),
                        ),
                      ),
                    ],
                  ),
                ), 
                Container
                (
                  child: profileType == "details" 
                  ? Column
                  (
                    children: 
                    [
                      Align
                      (
                        alignment: Alignment.centerLeft,
                        child: Padding
                        (
                          padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
                          child: Text("Where you will be", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: alt? fontColorAlt : fontColor)),
                        ),
                      ),
                      Padding
                      (
                        padding: const EdgeInsets.all(15),
                        child: Container
                        (
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration
                          (
                            boxShadow: 
                            const 
                            [
                              BoxShadow
                              (
                                color: Colors.black54,
                                offset: Offset(1, 5),
                                blurRadius: 6,
                              )
                            ],
                            color: containerColor,
                            border: Border.all(width: 2, color: alt ? containerColorAlt : containerColor),
                            borderRadius: const BorderRadius.all
                            (
                              Radius.circular(30)
                            ),
                          ),
                          width: 400,
                          child: Center
                          (
                            child: Text
                            (
                              hostelCity.toString() + ", " + hostelStreet.toString(), 
                              style: TextStyle
                              (
                                color: alt ? containerFontColorAlt : containerFontColor,
                                fontSize: 25
                              )
                            )
                          ),
                          height: 150,
                        ),
                      ),
                      Align
                      (
                        alignment: Alignment.centerLeft,
                        child: Padding
                        (
                          padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
                          child: Text("What this place offers", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: alt? fontColorAlt : fontColor)),
                        ),
                      ),
                      Padding
                      (
                        padding: const EdgeInsets.all(15),
                        child: Container
                        (
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration
                          (
                            boxShadow: 
                            const [
                              BoxShadow
                              (
                                color: Colors.black54,
                                offset: Offset(1, 5),
                                blurRadius: 6,
                              )
                            ],
                            color: containerColor,
                            border: Border.all(width: 2, color: alt ? containerColorAlt : containerColor),
                            borderRadius: const BorderRadius.all(Radius.circular(30))
                          ),
                          width: 400,
                          height: 150,
                          child: FutureBuilder
                          (
                            future: getHostelAmenities(),
                            builder: (context, AsyncSnapshot snapshot) 
                            {
                              if(snapshot.data == null)
                              {
                                return const SizedBox(height: 150, child: Center(child: CircularProgressIndicator()));
                              }
                              else
                              {
                                return Expanded
                                (
                                  child: ListView.builder
                                    (
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, i)
                                      {
                                        return SingleChildScrollView
                                        (
                                          child: Column
                                          (
                                            children: 
                                            [
                                              Align
                                              (
                                                alignment: Alignment.centerLeft,
                                                child: Padding
                                                (
                                                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.warning_amber_rounded),
                                                      Text("  ${snapshot.data[i].amenityName}", style: const TextStyle(height: 1.5, fontSize: 18, color: Colors.black87)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        );
                                      },
                                    ),
                                );
                              }
                            }
                          ),
                        ),
                      ),
                      Align
                      (
                        alignment: Alignment.centerLeft,
                        child: Padding
                        (
                          padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
                          child: Text("Choose your preferred room", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: alt? fontColorAlt : fontColor)),
                        ),
                      ),
                      Padding
                      (
                        padding: const EdgeInsets.all(15),
                        child: Container
                        (
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration
                          (
                            boxShadow: 
                            const [
                              BoxShadow
                              (
                                color: Colors.black54,
                                offset: Offset(1, 5),
                                blurRadius: 6,
                              )
                            ],
                            color: containerColor,
                            border: Border.all(width: 2, color: alt ? containerColorAlt : containerColor),
                            borderRadius: const BorderRadius.all(Radius.circular(30))
                          ),
                          width: 400,
                          height: 280,
                          child: Row
                          (
                            children: 
                            [
                              FutureBuilder
                              (
                                future: myRooms,
                                builder: (context, AsyncSnapshot snapshot) 
                                {
                                  if(snapshot.data == null)
                                  {
                                    return const Center(child: CircularProgressIndicator());
                                  }
                                  else
                                  {
                                    return Expanded
                                    (
                                      child: ListView.builder
                                      (
                                        scrollDirection: Axis.horizontal,
                          
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, i)
                                        {
                                          return SingleChildScrollView
                                          (       
                                            child: Column
                                            (
                                              children: 
                                              [
                                                InkWell
                                                (
                                                  onTap: () 
                                                  {
                                                    rID = snapshot.data[i].id;
                                                    roomPrice = snapshot.data[i].roomPrice;
                                                    roomType = snapshot.data[i].roomType;
                                                    setState(() {          
                                                    });
                                                  },
                                                  child: Container
                                                  (          
                                                    width: 195,
                                                    height: 225,      
                                                    margin: const EdgeInsets.all(25),
                                                    decoration: BoxDecoration
                                                    (
                                                      color: containerColorAlt,
                                                      boxShadow: 
                                                      const 
                                                      [
                                                        BoxShadow
                                                        (
                                                          color: Colors.black54,
                                                          offset: Offset(1, 5),
                                                          blurRadius: 6,
                                                        )
                                                      ],
                                                      border: Border.all(color: alt? borderColorAlt: borderColor, width: 1),
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),        
                                                    child: Column
                                                    (
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: 
                                                      [
                                                        Align
                                                        (
                                                          alignment: Alignment.topLeft,
                                                          child: Container
                                                          ( 
                                                            decoration: BoxDecoration
                                                            (
                                                              border: Border.all(color: backgroundColor),
                                                              borderRadius: const BorderRadius.only
                                                              (
                                                                topLeft: Radius.circular(10),
                                                                topRight: Radius.circular(10),
                                                                bottomLeft: Radius.circular(10),
                                                                bottomRight: Radius.circular(10)
                                                              ),
                                                            ),
                                                            child: Container
                                                            (
                                                              decoration: BoxDecoration
                                                              (
                                                                boxShadow: 
                                                                const [
                                                                  BoxShadow
                                                                  (
                                                                    color: Colors.black54,
                                                                    offset: Offset(1, 5),
                                                                    blurRadius: 5,
                                                                  )
                                                                ],
                                                                color: containerColor,
                                                                borderRadius: const BorderRadius.only
                                                                (
                                                                  topLeft: Radius.circular(10),
                                                                  topRight: Radius.circular(10),
                                                                  bottomLeft: Radius.circular(10),
                                                                  bottomRight: Radius.circular(10)
                                                                ),
                                                              ),       
                                                              child: Padding
                                                              (
                                                                padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                                                child: Text
                                                                (
                                                                  snapshot.data[i].roomType, 
                                                                  style: TextStyle(color: buttonColorAlt, fontSize: 18, fontWeight: FontWeight.bold)
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 25),
                                                        Padding
                                                        (
                                                          padding: const EdgeInsets.all(5),
                                                          child: Text('Price per month', style: TextStyle(color: fontColor, fontSize: 15)),
                                                        ),
                                                        Padding
                                                        (
                                                          padding: const EdgeInsets.all(5),
                                                          child: Text('Rs.' + snapshot.data[i].roomPrice, style: TextStyle(color: fontColor, fontSize: 15, fontWeight: FontWeight.bold))
                                                        ),
                                                        Padding
                                                        (
                                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                                          child:  Divider(color: dividerColor, thickness: 1)
                                                        ),
                                                        Padding
                                                        (
                                                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                          child: ElevatedButton
                                                          (
                                                            onPressed: () 
                                                            { 
                                                              rID = snapshot.data[i].id;
                                                              roomPrice = snapshot.data[i].roomPrice;
                                                              roomType = snapshot.data[i].roomType;
                                                              setState(() {
                                                                
                                                              });
                                                            },
                                                            child: Text
                                                            (
                                                              "Select",
                                                              style: TextStyle
                                                              (
                                                                color: buttonColorAlt
                                                              ),
                                                            ),
                                                            style: ElevatedButton.styleFrom
                                                            (
                                                              primary: containerColor,
                                                              side: BorderSide(width: 2, color: backgroundColorAlt)
                                                            )
                                                          ),
                                                        ),
                                                      ]
                                                    ),
                                                  ),
                                                ),              
                                              ],
                                            )
                                          );
                                        }
                                      )
                                    );
                                  }
                                }
                              )
                            ]
                          )
                        ),
                      ),
                      Align
                      (
                        alignment: Alignment.centerLeft,
                        child: Padding
                        (
                          padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
                          child: Text("Choose your preferred date", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: alt? fontColorAlt : fontColor)),
                        ),
                      ),
                      Padding
                      (
                        padding: const EdgeInsets.all(15),
                        child: Container
                        (
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration
                          (
                            boxShadow: const [
                              BoxShadow
                              (
                                color: Colors.black54,
                                offset: Offset(1, 5),
                                blurRadius: 6,
                              )
                            ],
                            color: containerColor,
                            border: Border.all(color: alt? borderColorAlt : borderColor, width: 2),
                            borderRadius: const BorderRadius.all(Radius.circular(30))
                          ),
                          width: 400,
                          height: 150,
                          child: Padding
                          (
                            padding: const EdgeInsets.all(15),
                            child: Column
                            (
                              children: 
                              [
                                Row
                                (
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: 
                                  [
                                    Text
                                    (
                                      "The date of booking:", 
                                      style: TextStyle(color: alt ? containerFontColorAlt : containerFontColor, fontSize: 18)
                                    ),
                                    Text
                                    (
                                      "$bookedDate", 
                                      style: TextStyle(color: alt ? containerFontColorAlt : containerFontColor, fontSize: 18, fontWeight: FontWeight.bold)
                                    )
                                  ]
                                ),
                                Padding
                                (
                                  padding: const EdgeInsets.fromLTRB(0, 45, 0, 0),
                                  child: ElevatedButton
                                  (
                                    onPressed: () 
                                    {
                                      DatePicker.showDatePicker
                                      (
                                        context,
                                        showTitleActions: true,
                                        minTime: DateTime.now(),
                                        maxTime: DateTime.now().add(const Duration(days: 14)), 
                                        onConfirm: (date) 
                                        {
                                          bookedDate ="${date.year}-${date.month}-${date.day}".toString();
                                          checkingOutDate = "${date.year}-${date.month + 1}-${date.day}".toString();
                                          setState(() {
                                          });
                                        }, 
                                        currentTime: DateTime.now(), locale: LocaleType.en);    
                                    },
                                    child: Text
                                    (
                                      "Select booking date",
                                      style: TextStyle
                                      (
                                        color: fontColor
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom
                                    (
                                      primary: backgroundColor,
                                      minimumSize: Size(165, 50),
                                      side: BorderSide(width: 2, color: borderColor),
                                    )
                                  ),
                                ),
                              ],
                            ),
                          )
                        ),
                      ),
                      Align
                      (
                        alignment: Alignment.centerLeft,
                        child: Padding
                        (
                          padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
                          child: Text("Book now and pay at the hostel", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: alt? fontColorAlt : fontColor)),
                        ),
                      ),
                      Padding
                      (
                        padding: const EdgeInsets.all(15),
                        child: Container
                        (
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration
                          (
                            boxShadow: const [
                              BoxShadow
                              (
                                color: Colors.black54,
                                offset: Offset(1, 5),
                                blurRadius: 6,
                              )
                            ],
                            color: containerColor,
                            border: Border.all(color: alt? borderColorAlt : borderColor, width: 2),
                            borderRadius: const BorderRadius.all(Radius.circular(30))
                          ),
                          width: 400,
                          height: 150,
                          child: Padding
                          (
                            padding: const EdgeInsets.all(15),
                            child: Column
                            (
                              children: 
                              [
                                Row
                                (
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: 
                                  [
                                    Text
                                    (
                                      "What you will pay per month:", 
                                      style: TextStyle(color: alt ? containerFontColorAlt : containerFontColor, fontSize: 18)
                                    ),
                                    roomPrice != null 
                                    ? Text
                                    (
                                      "Rs. $roomPrice", 
                                      style: TextStyle(color: alt ? containerFontColorAlt : containerFontColor, fontSize: 18, fontWeight: FontWeight.bold)
                                    )
                                    :
                                    Text
                                    (
                                      "Rs. 0", 
                                      style: TextStyle(color: alt ? containerFontColorAlt : containerFontColor, fontSize: 18, fontWeight: FontWeight.bold)
                                    )
                                  ]
                                ),
                                Padding
                                (
                                  padding: const EdgeInsets.fromLTRB(0, 45, 0, 0),
                                  child: ElevatedButton
                                  (
                                    onPressed: bookingConfirmed 
                                    ? () {}
                                    : () 
                                    async 
                                    { 
                                      await getHostelOwnerID();
                                      if(roomPrice != null && bookedDate != null)
                                      {
                                        hID = hostelID;
                                        uID = loggedUserID;
                                        bookHostel();
                                        sendMail();
                                        saveNotification();
                                        saveHostelOwnerNotification();
                                        setState(() 
                                        {
                                          bookingConfirmed = true;  
                                        });
                                        
                                      }
                                      else if(roomPrice == null)
                                      {
                                        ScaffoldMessenger.of(context).showSnackBar
                                        (
                                          const SnackBar
                                          (
                                            content: Text('Please select a room!'),
                                          )
                                        );
                                      }
                                      else if(bookedDate == null)
                                      {
                                        ScaffoldMessenger.of(context).showSnackBar
                                        (
                                          const SnackBar
                                          (
                                            content: Text('Please select a date!'),
                                          )
                                        );
                                      }
                                    },
                                    child: bookingConfirmed 
                                    ? const SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2, ))
                                    : Text
                                    (
                                      "Book hostel",
                                      style: TextStyle
                                      (
                                        color: fontColor
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom
                                    (
                                      primary: backgroundColor,
                                      minimumSize: const Size(165, 50),
                                      side: BorderSide(width: 2, color: borderColor),
                                    )
                                  ),
                                ),
                              ],
                            ),
                          )
                        ),
                      ),
                    ],
                  )
                  : SizedBox
                  (
                    height: 525,
                    child: Column
                    (
                      children: 
                      [
                        const SizedBox
                        (
                          height: 25,
                        ),
                        Container
                        (
                          height: 30,
                          color: const Color.fromARGB(255, 225, 220, 220),
                        ),
                        Align
                        (
                          alignment: Alignment.center,
                          child: Padding
                          (
                            padding: const EdgeInsets.fromLTRB(0, 25, 0, 20),
                            child: Text("What people are saying", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: alt? fontColorAlt : fontColor)),
                          ),
                        ),
                        FutureBuilder
                        (
                          future: hostelUserReviews,
                          builder: (context,AsyncSnapshot snapshot) 
                          {
                            if(snapshot.data == null)
                            {
                              return const SizedBox(height: 325, child: Center(child: CircularProgressIndicator()));
                            }
                            else
                            {
                              return Expanded
                              (
                                child: RefreshIndicator
                                (
                                  onRefresh: () 
                                  {
                                    return hostelUserReviews = getHostelReviews();
                                  },
                                  child: ListView.builder
                                  (
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, i)
                                    {
                                      return SingleChildScrollView
                                      (
                                        child: Column
                                        (
                                          children: 
                                          [
                                            Row
                                            (
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: 
                                              [
                                                Align
                                                (
                                                  alignment: Alignment.centerLeft,
                                                  child: Padding
                                                  (
                                                    padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
                                                    child: RatingBar.builder
                                                    (
                                                      unratedColor: ratingColor,
                                                      initialRating: double.parse(snapshot.data[i].rating),
                                                      minRating: 0,
                                                      allowHalfRating: true,
                                                      direction: Axis.horizontal,
                                                      itemCount: 5,
                                                      itemSize: 25,
                                                      ignoreGestures: true,
                                                      itemBuilder: (context, _) => const Icon
                                                      (
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ), 
                                                      onRatingUpdate: (rating) 
                                                      {
                                                        
                                                      },
                                                    ),
                                                  )
                                                ),
                                                Padding
                                                (
                                                  padding: const EdgeInsets.fromLTRB(0, 40, 20, 0),
                                                  child: Text("${snapshot.data[i].reviewDate}", style: const TextStyle(fontSize: 16,color: Colors.black54),),
                                                )
                                              ],
                                            ),
                                            Align
                                            (
                                              alignment: Alignment.centerLeft,
                                              child: Padding
                                              (
                                                padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                                                child: Text("${snapshot.data[i].review}", style: const TextStyle(height: 1.5, fontSize: 18, color: Colors.black87)),
                                              ),
                                            ),
                                            Align
                                            (
                                              alignment: Alignment.centerLeft,
                                              child: Padding
                                              (
                                                padding: const EdgeInsets.fromLTRB(20, 25, 0, 0),
                                                child: Text("By: ${snapshot.data[i].userFName} ${snapshot.data[i].userLName}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),),
                                              )
                                            ),
                                            const Padding
                                            (
                                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                              child:  Divider(color: Colors.black26, thickness: 1)
                                            ),
                                          ],
                                        )
                                      );
                                    },
                                  ),
                                ),
                              );
                            }
                          }
                        ),
                        Align
                        (
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: FloatingActionButton
                            (
                              onPressed: () 
                              {
                                showModalBottomSheet
                                (
                                  context: context,
                                  builder: (context) 
                                  {
                                    return Padding
                                    (
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column
                                      (
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>
                                        [
                                          Row
                                          (
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: 
                                            [
                                              Padding
                                              (
                                                padding: const EdgeInsets.fromLTRB(0,0,0,50),
                                                child: IconButton(icon: const Icon(CupertinoIcons.xmark), onPressed: () => Navigator.pop(context))
                                              ),
                                              Padding
                                              (
                                                padding: const EdgeInsets.fromLTRB(0,0,0,50),
                                                child: Text("$hostelName", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                                              ),
                                              Padding
                                              (
                                                padding: const EdgeInsets.fromLTRB(0,0,0,50),
                                                child: ElevatedButton
                                                (
                                                  onPressed: reviewController.text == "" 
                                                  ? () 
                                                  {
                                                    reviewController.text = "No review";
                                                    postReview();
                                                    
                                                    averageReviews();
                                                    setState(() 
                                                    {
                                                      hostelUserReviews = getHostelReviews();
                                                    });                                                   
                                                    Navigator.pop(context);
                                                  }
                                                  : () 
                                                  { 
                                                    postReview();
                                                    
                                                    averageReviews();
                                                    setState(() {
                                                      hostelUserReviews = getHostelReviews();
                                                    });                                                    
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text
                                                  (
                                                    "Post",
                                                    style: TextStyle
                                                    (
                                                      color: fontColor
                                                    ),
                                                  ),
                                                  style: ElevatedButton.styleFrom
                                                  (
                                                    primary: backgroundColor,
                                                    minimumSize: const Size(100, 30),
                                                    side: BorderSide(width: 2, color: borderColor),
                                                  )
                                                ),
                                              ),
                                            ],
                                          ),
                                          Align
                                          (
                                            alignment: Alignment.centerLeft,
                                            child: Text("$loggedUserFName $loggedUserLName", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
                                          ),
                                          Align
                                          (
                                            alignment: Alignment.centerLeft,
                                            child: Padding
                                            (
                                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                              child: RatingBar.builder
                                              (
                                                unratedColor: ratingColor,
                                                initialRating: 0,
                                                minRating: 0,
                                                allowHalfRating: true,
                                                direction: Axis.horizontal,
                                                itemCount: 5,
                                                itemSize: 50,
                                                itemBuilder: (context, _) => const Icon
                                                (
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ), 
                                                onRatingUpdate: (rating) 
                                                {
                                                  finalRating = rating.toString();
                                                },
                                              ),
                                            )
                                          ),
                                          const Align
                                          (
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(0, 35, 0, 0),
                                              child: Text("Share more about your experience", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                            )
                                          ),
                                          const SizedBox(height: 25,),
                                          Container
                                          (
                                            decoration: BoxDecoration
                                            (
                                              border: Border.all(color: const Color.fromARGB(255, 225, 220, 220), width: 2),
                                              borderRadius: const BorderRadius.all(Radius.circular(15))
                                            ),
                                            width: 400,
                                            height: 150,
                                            child: Padding
                                            (
                                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                              child: TextField
                                              (
                                                maxLines: 5,
                                                keyboardType: TextInputType.multiline,
                                                controller: reviewController,
                                                decoration: const InputDecoration
                                                (
                                                  border: InputBorder.none,
                                                  hintText: "Enter your review..."
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                );
                              },
                              child: Icon(CupertinoIcons.add, color: buttonFontColor,)
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                )
              ]
            ),
          )
        ),
      ),
    );
  }
}