// @dart = 2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/Model/hostel_model.dart';
import 'package:hotel_booking_app/apis/api.dart';
import 'package:hotel_booking_app/utils/base_url.dart';
import 'package:hotel_booking_app/utils/routes.dart';
import 'package:hotel_booking_app/utils/search.dart';
import 'package:http/http.dart' as http;


class SavedPage extends StatefulWidget 
{
  SavedPage({Key key}) : super(key: key);

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> 
{
  HostelModel hostelModel = HostelModel();
  Future mySavedHostels;
  final bool isSaved = false;
  String hostelID;
  String hostelName;
  String hostelCity;
  String hostelStreet;
  String hostelType;
  String hostelPhone;
  String hostelPhoto;

  @override
  void initState() {
    mySavedHostels = getSavedHostels();
    super.initState();
  }

  // getHostelData() async {
  //   var response = await http.get(Uri.parse('${BaseUrl.baseUrl}hostelProfile/$hostelID'));
  //   var jsonData = json.decode(response.body);
  //   print("called!");

    
  //   // setState(() {
  //   //   hostelModel = HostelModel.fromJson({"data": jsonData});
      
  //   // });
  //   hostelID = jsonData["id"].toString();
  //   hostelName = jsonData["hostelName"];
  //   hostelPhoto = jsonData["hostelPhoto"];
  //   hostelCity = jsonData["hostelCity"];
  //   hostelStreet = jsonData["hostelStreet"];
  //   hostelType = jsonData["hostelType"];
  //   hostelPhone = jsonData["hostelPhone"];
  //   hostelPhoto = jsonData["hostelPhoto"];
  // }

  @override
  Widget build(BuildContext context) {
    // List<Hostels> hostelDetails = getHostels();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold
      (
        appBar: AppBar
        (
          leading: IconButton
          (
            icon: const Icon(CupertinoIcons.arrow_left),
            onPressed: () => Navigator.pushNamed(context, MyRoutes.homeRoute),
          ),
          title: const Text("Saved"),
        ), 
        body: Column
        (
          children: 
          [
            FutureBuilder
            (
              future: mySavedHostels,
              builder: (context, snapshot) 
              {
                if(snapshot.data == null)
                {
                  return Center(child: Text("loading...", style: TextStyle(fontSize: 18),));
                }
                else
                {
                  return Expanded
                  (
                    child: ListView.builder
                    (
                      scrollDirection: Axis.vertical,

                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i)
                      {
                        print("snapshot.data[i].hostelID");
                        return SingleChildScrollView
                        (       
                          child: snapshot.data[i].hostelID != "null"
                          ? Center
                          (
                            child: Container
                            (
                              margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration
                              (
                                color: Colors.cyan
                              ),
                              child: Text('Hostel Name: ' + snapshot.data[i].hostelName, style: TextStyle(color: Colors.white,))
                            )
                          )
                          :
                          Container
                          (
                            height: 800,
                            alignment: Alignment.center,
                            child: SingleChildScrollView
                            (
                              child: Column
                              (
                                children:
                                [
                                  const Text
                                  (
                                    "Find your favourite hostels now",
                                    style: TextStyle
                                    (
                                      fontSize: 20                  
                                    ),
                                  ),
                                  const SizedBox
                                  (
                                    height: 20,
                                  ),
                                  ElevatedButton
                                  (
                                    onPressed: () => showSearch(context: context, delegate: Search()),
                                    child: const Text
                                    (
                                      "Browse hostels", 
                                      style: TextStyle
                                      (
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                  )
                                ],
                              ),
                            ),   
                          )
                        );
                      },
                    ),
                  );
                }
              }
            ),
          ],
        )
      ),
    );
  }
}