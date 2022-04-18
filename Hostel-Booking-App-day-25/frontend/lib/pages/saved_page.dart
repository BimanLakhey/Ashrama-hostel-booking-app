// @dart = 2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/Model/hostel_model.dart';
import 'package:hotel_booking_app/apis/api.dart';
import 'package:hotel_booking_app/pages/hostel_profile_page.dart';
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
  String userID;

  @override
  void initState() {
    mySavedHostels = getSavedHostels();
    super.initState();
  }

  void removeHostel(String id) async 
  {
    var response = await http.delete
    (
      Uri.parse('${BaseUrl.baseUrl}savedHostels/$id'), 
    );
    var jsonData = json.decode(response.body);
    if(response.statusCode == 204)
    {
      print("deleted!");
    }
    else
    {
      print("failed!");
    }
  }


  @override
  Widget build(BuildContext context) {
    // List<Hostels> hostelDetails = getHostels();

    return WillPopScope
    (
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
                  return const SizedBox(height: 325, child: Center(child: CircularProgressIndicator()));
                }
                else
                {
                  return Expanded
                  (
                    child: ListView.builder
                    (
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i)
                      {
                        return SingleChildScrollView
                        (       
                          child: !snapshot.hasData
                          ? 
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
                          :
                          Column
                          (
                            children: 
                            [
                              InkWell
                              (
                                onTap: () 
                                {
                                  HostelProfilePage.hostelID = snapshot.data[i].hostelID;
                                  Navigator.pushNamed(context, MyRoutes.hostelProfileRoute);
                                },
                                child: Container
                                (                    
                                  width: 325,
                                  margin: EdgeInsets.fromLTRB(15, 15, 15, 45),
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
                                    border: Border.all(color: Colors.cyan),
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.cyan
                                  ),        
                                  child: Column
                                  (
                                    children: 
                                    [
                                      Container
                                      (
                                        clipBehavior: Clip.antiAlias,                                       
                                        width: 350,
                                        height: 125,
                                        decoration: BoxDecoration
                                        (
                                          border: Border.all(color: Colors.cyan),
                                          borderRadius: const BorderRadius.only
                                          (
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(45),
                                            bottomRight: Radius.circular(45),
                                          ),
                                          color: Colors.white
                                        ),
                                        child: Stack
                                        (
                                          fit: StackFit.expand,
                                          children: <Widget>
                                          [
                                            Image.network(BaseUrl.savedBaseUrl + snapshot.data[i].hostelPhoto,fit: BoxFit.fill),
                                            Padding
                                            (
                                              padding: const EdgeInsets.all(5.0),
                                              child: Align
                                              (
                                                alignment: Alignment.topRight,
                                                child: IconButton
                                                (
                                                  icon: const Icon
                                                  (
                                                    Icons.favorite_outline, 
                                                    color: Colors.cyanAccent,
                                                  ), 
                                                  onPressed: () 
                                                  {
                                                    
                                                    setState(() 
                                                    {
                                                      hostelID = snapshot.data[i].id;
                                                      removeHostel(hostelID);
                                                      mySavedHostels = getSavedHostels();
                                                    });
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ),
                                      Padding
                                      (
                                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                                        child: Row
                                        (
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: 
                                          [
                                            Text
                                            (
                                              snapshot.data[i].hostelName, 
                                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        child: Row
                                        (
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: 
                                          [
                                            Row(
                                              children: 
                                              [  
                                                Text(snapshot.data[i].hostelCity, style: TextStyle(color: Colors.white, fontSize: 15)),
                                                Text(", ", style: TextStyle(color: Colors.white, fontSize: 15)),
                                                Text(snapshot.data[i].hostelStreet, style: TextStyle(color: Colors.white, fontSize: 15)),
                                              ],
                                            ),
                                               
                                          ],
                                        ),
                                      ),
                                      Align
                                      (
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Text
                                          (
                                            snapshot.data[i].hostelPhone, 
                                            style: TextStyle(color: Colors.white, fontSize: 15)
                                          ),
                                        ),
                                      ),     
                                      SizedBox(height: 25,)
                                    ]
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
          ],
        )
      ),
    );
  }
}