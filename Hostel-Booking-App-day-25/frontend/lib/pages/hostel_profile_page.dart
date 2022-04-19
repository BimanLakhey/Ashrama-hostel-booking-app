import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hotel_booking_app/Model/hostel_model.dart';
import 'package:hotel_booking_app/apis/api.dart';
import 'package:hotel_booking_app/utils/base_url.dart';
import 'package:hotel_booking_app/utils/notifications.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class HostelProfilePage extends StatefulWidget {
  HostelProfilePage({Key? key}) : super(key: key);
  static String? hostelID;

  @override
  State<HostelProfilePage> createState() => _HostelProfilePageState();
}

class _HostelProfilePageState extends State<HostelProfilePage> {
  HostelModel hostelModel = HostelModel();
  String? hostelID = HostelProfilePage.hostelID;
  String? hostelName;
  String? hostelPhoto;
  String? hostelCity;
  String? hostelStreet;
  String? hostelPhone; 
  String? hostelTotalRooms; 
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

  String? hID;
  String? uID;
  String? rID;
  String? bookedDate = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
  String? checkingOutDate = "${DateTime.now().year}-${DateTime.now().month + 1}-${DateTime.now().day}";
  String? roomType;
  String? roomPrice;
  Future? myRooms;
  @override
  void initState()
  {
    myRooms = getRooms();
    super.initState();
    getHostelData();
    //updateUserData();
  }
  
  @override
  void dispose() {
    super.dispose();
  }

  sendMail() async {
    String email = "Ashrama.hostels@gmail.com";
    String password = 'Hesoyam74';

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
      // ScaffoldMessenger.of(context).showSnackBar
      // (
      //   const SnackBar
      //   (
      //     content: Text('Booking confirmed.\nPlease view your email for booking details!'),
      //   )
      // );

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
                        initialRating: 0,
                        minRating: 0,
                        allowHalfRating: true,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemSize: 25,
                        itemBuilder: (context, _) => const Icon
                        (
                          Icons.star,
                          color: Colors.amber,
                        ), 
                        onRatingUpdate: (rating) 
                        {
                          print(rating);
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
                          onPressed: () {},
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
                          onPressed: () {},
                          icon: const Icon(Icons.reviews_outlined), 
                          label: const Text("Reviews"),
                        ),
                      ),
                    ],
                  ),
                ), 
                Padding
                (
                  padding: const EdgeInsets.fromLTRB(15, 50, 0, 0),
                  child: Text("Where you will be", style: TextStyle(fontSize: 20, color: alt? fontColorAlt : fontColor)),
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
                Padding
                (
                  padding: const EdgeInsets.fromLTRB(15, 40, 0, 0),
                  child: Text("What this place offers", style: TextStyle(fontSize: 20, color: alt? fontColorAlt : fontColor)),
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
                    child: GridView.count
                    (
                      childAspectRatio: 2,
                      crossAxisCount: 3,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      children: List.generate(10, (index) 
                      {
                        return TextButton.icon
                        (
                          icon: Icon(Icons.tiktok, color: alt ? containerFontColorAlt : containerFontColor), 
                          onPressed: () {  }, 
                          label: Text("Amenity", style: TextStyle(color: alt ? containerFontColorAlt: containerFontColor),),
                        );
                      }),
                    ),
                  ),
                ),
                Padding
                (
                  padding: const EdgeInsets.fromLTRB(15, 40, 0, 0),
                  child: Text("Choose your preferred room", style: TextStyle(fontSize: 20, color: alt? fontColorAlt : fontColor)),
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
                                                        side: BorderSide(width: 2, color: borderColor),
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
                Padding
                (
                  padding: const EdgeInsets.fromLTRB(15, 40, 0, 0),
                  child: Text("Choose your preferred date", style: TextStyle(fontSize: 20, color: alt? fontColorAlt : fontColor)),
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
                Padding
                (
                  padding: const EdgeInsets.fromLTRB(15, 40, 0, 0),
                  child: Text("Book now and pay at the hostel", style: TextStyle(fontSize: 20, color: alt? fontColorAlt : fontColor)),
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
                              { 
                                if(roomPrice != null && bookedDate != null)
                                {

                                  hID = hostelID;
                                  uID = loggedUserID;
                                  bookHostel();
                                  sendMail();
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
              ]
            ),
          )
        ),
      ),
    );
  }
}