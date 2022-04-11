import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hotel_booking_app/Model/hostel_model.dart';
import 'package:hotel_booking_app/apis/api.dart';
import 'package:hotel_booking_app/utils/base_url.dart';
import 'package:hotel_booking_app/utils/routes.dart';
import 'package:http/http.dart' as http;

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
  String? totalPrice;
  bool dataLoaded = false;
  Color borderColor = Colors.black;
  Color fontColor = Colors.black;
  @override
  void initState()
  {
    super.initState();
    getHostelData();
    //updateUserData();
  }
  void getHostelData() async 
  {
    var response = await http.get(Uri.parse('${BaseUrl.baseUrl}hostelProfile/${hostelID}'));
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
            foregroundColor: Colors.white
          ),
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
                    decoration: BoxDecoration
                    (
                      border: Border.all(color: borderColor, width: 3),
                      borderRadius: const BorderRadius.only
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
                          style: TextStyle(fontSize:24, fontWeight: FontWeight.bold, color: fontColor)
                        ),
                      ),
                      RatingBar.builder
                      (
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
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 25),
                  child: Row
                  (
                    children: 
                    [
                      Text(hostelCity.toString() + ', ' + hostelStreet.toString(), style: TextStyle(fontSize:15, color: fontColor),),
                    ]
                  ),
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
                          border: Border.all(color: borderColor, width: 2),
                          borderRadius: BorderRadius.circular(35)
                        ),
                        child: TextButton.icon
                        (
                          style: TextButton.styleFrom
                          (
                            primary: fontColor
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
                          border: Border.all(color: borderColor, width: 2),
                          borderRadius: BorderRadius.circular(35)
                        ),
                        child: TextButton.icon
                        (
                          style: TextButton.styleFrom
                          (
                            primary: borderColor
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
                  padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
                  child: Text("Location", style: TextStyle(fontSize: 20, color: fontColor)),
                ),
                Padding
                (
                  padding: const EdgeInsets.all(15),
                  child: Container
                  (
                    clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration
                      (
                        border: Border.all(width: 2),
                        borderRadius: const BorderRadius.only
                        (
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
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
                          color: fontColor,
                          fontSize: 25
                        )
                      )
                    ),
                    height: 150,
                  ),
                ),
                Padding
                (
                  padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
                  child: Text("Amenities", style: TextStyle(fontSize: 20, color: fontColor)),
                ),
                Padding
                (
                  padding: const EdgeInsets.all(15),
                  child: Container
                  (
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration
                    (
                      border: Border.all(color: borderColor, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30))
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
                          icon: Icon(Icons.tiktok, color: fontColor,), 
                          onPressed: () {  }, 
                          label: Text("Amenity", style: TextStyle(color: fontColor),),
                        );
                      }),
                    ),
                  ),
                ),
                Padding
                (
                  padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
                  child: Text("Choose your preferred room", style: TextStyle(fontSize: 20, color: fontColor)),
                ),
                Padding
                (
                  padding: const EdgeInsets.all(15),
                  child: Container
                  (
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration
                    (
                      border: Border.all(color: borderColor, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                    width: 400,
                    height: 150,
                    child: Row
                    (
                      children: [
                        
                      ]
                    )
                  ),
                ),
                Padding
                (
                  padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
                  child: Text("Pricing details", style: TextStyle(fontSize: 20, color: fontColor)),
                ),
                Padding
                (
                  padding: const EdgeInsets.all(15),
                  child: Container
                  (
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration
                    (
                      border: Border.all(color: borderColor, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30))
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
                                "Price to pay", 
                                style: TextStyle(color: fontColor, fontSize: 18)
                              ),
                              Text
                              (
                                "Rs. $totalPrice", 
                                style: TextStyle(color: fontColor, fontSize: 18, fontWeight: FontWeight.bold)
                              ),
                            ]
                          ),
                          Padding
                          (
                            padding: const EdgeInsets.fromLTRB(0, 45, 0, 0),
                            child: ElevatedButton
                            (
                              onPressed: () 
                              { 
                                ScaffoldMessenger.of(context).showSnackBar
                                (
                                  const SnackBar(content: Text("booking unavailable!"))
                                );
                                //bookhostel()
                              },
                              child: Text
                              (
                                "Book now and pay later",
                                style: TextStyle
                                (
                                  color: fontColor
                                ),
                              ),
                              style: ElevatedButton.styleFrom
                              (
                                primary: Colors.white,
                                minimumSize: Size(150, 40),
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