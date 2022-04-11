import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  bool dataLoaded = false;
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: dataLoaded == false
      ? Center(child: CircularProgressIndicator( backgroundColor: Colors.cyan))
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
          child: Center
          (
            child: Column
            (
              children: [
                FractionallySizedBox
                (
                  widthFactor: 1,
                  child: Container
                  (
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration
                    (
                      border: Border.all(color: Colors.cyan, width: 3),
                      borderRadius: const BorderRadius.only
                      (
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    height: 200,
                    child: Image.network(BaseUrl.savedBaseUrl + hostelPhoto.toString(), fit: BoxFit.fill),
                  ),
                ),
                Padding
                (
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row
                  (
                    children: 
                    [
                      Text(hostelName.toString(), style: TextStyle(fontSize:24, fontWeight: FontWeight.bold, color: Colors.black),)
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
                      Text(hostelCity.toString() + ', ' + hostelStreet.toString(), style: TextStyle(fontSize:15, color: Colors.black87),),
                    ]
                  ),
                ),
                Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: 
                  [
                    Container
                    (
                      width: 125,
                      height: 45,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(35)
                      ),
                      child: TextButton.icon
                      (
                        style: TextButton.styleFrom
                        (
                          primary: Colors.black
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
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(35)
                      ),
                      child: TextButton.icon
                      (
                        style: TextButton.styleFrom
                        (
                          primary: Colors.black
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.reviews_outlined), 
                        label: const Text("Reviews"),
                      ),
                    ),
                  ],
                ), 
              ]
            ),
          ),
        )
      ),
      ),
    );
  }
}