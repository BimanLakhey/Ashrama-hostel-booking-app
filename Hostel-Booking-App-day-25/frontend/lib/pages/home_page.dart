//@dart = 2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/Model/hostel_model.dart';
import 'package:hotel_booking_app/apis/api.dart';
import 'package:hotel_booking_app/pages/hostel_profile_page.dart';
import 'package:hotel_booking_app/utils/base_url.dart';
import 'package:hotel_booking_app/utils/drawer.dart';
import 'package:hotel_booking_app/utils/routes.dart';
import 'package:hotel_booking_app/utils/search.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> 
{
  bool isFavourite = false;
  String hostelID;
  String userID;
  Future myHostels;
  @override
  void initState() 
  {
    myHostels = getHostels();
    super.initState();
  }
 
  @override
  void dispose() {
    super.dispose();
  }

  void saveHostel() async 
  {
    try
    {
      var response = await http.post
      (
        Uri.parse('${BaseUrl.baseUrl}savedHostels/'), 
        // headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
        body: {'hostelID': hostelID, 'userID': userID}
      );
      var jsonData = json.decode(response.body);
      if(response.statusCode == 201)
      {
        print("saved!");
      }
      else
      {
        print("failed!");
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

  @override
  Widget build(BuildContext context) 
  { 
    return WillPopScope
    (
      onWillPop: () async => false,
      child: Scaffold
      (
        appBar: AppBar
        (
          elevation: 10,
          shadowColor: Colors.black,
          foregroundColor: Colors.white,
          title: const Text("Ashrama"),
          centerTitle: true,
          actions: 
          [
            IconButton
            (
              onPressed: () => showSearch(context: context, delegate: Search()), 
              icon: const Icon(Icons.search)
            ),
            IconButton
            (
              icon: const Icon(Icons.notifications_none_outlined),
              onPressed: () {  },
            ),
            
          ],
        ),
        drawer: DrawerPage(),
        body: Column
        (
          children:
          [
            const SizedBox
            (
              height: 25.0,
            ),
            SingleChildScrollView
            (
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Padding
              (
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row
                (
                  children: 
                  [
                    Padding
                    (
                      padding: const EdgeInsets.fromLTRB(0,0,0,25),
                      child: Container
                      (
                        width: 125,
                        height: 45,
                        decoration: BoxDecoration
                        (
                          boxShadow: const 
                          [
                            BoxShadow
                            (
                              color: Colors.black54,
                              offset: Offset(1, 5),
                              blurRadius: 6,
                            )
                          ],
                          color: Colors.cyan,
                          border: Border.all(color: Colors.cyan, width: 2),
                          borderRadius: BorderRadius.circular(35)
                        ),
                        child: TextButton.icon
                        (
                          style: TextButton.styleFrom
                          (
                            primary: Colors.white
                          ),
                          onPressed: () {myHostels = getHostels(); setState(() {});},
                          icon: const Icon(CupertinoIcons.hand_thumbsup), 
                          label: const Text("For you"),
                        ),
                      ),
                    ),
                    SizedBox(width: 75),
                    Padding
                    (
                      padding: const EdgeInsets.fromLTRB(0,0,0,25),
                      child: Container
                      (
                        width: 125,
                        height: 45,
                        decoration: BoxDecoration
                        (
                          boxShadow: const 
                          [
                            BoxShadow
                            (
                              color: Colors.black54,
                              offset: Offset(1, 5),
                              blurRadius: 6,
                            )
                          ],
                          color: Colors.cyan,
                          border: Border.all(color: Colors.cyan, width: 2),
                          borderRadius: BorderRadius.circular(35)
                        ),
                        child: TextButton.icon
                        (
                          style: TextButton.styleFrom
                          (
                            primary: Colors.white
                          ),
                          onPressed: () {myHostels = getNearbyHostels(); setState(() {});},
                          icon: const Icon(CupertinoIcons.placemark), 
                          label: const Text("Nearby"),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    
                  ],
                ),
              ),
            ), 
            const SizedBox(height: 25),
            const Text
            (
              "Hostels price for a month", 
              style: TextStyle
              (
                fontSize: 18
              ),
            ),
            const SizedBox(height: 25),
            FutureBuilder
            (
              future: myHostels,
              builder: (context, snapshot) 
              {
                if(snapshot.data == null)
                {
                  return const CircularProgressIndicator();
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
                              InkWell
                              (
                                onTap: () 
                                {
                                  HostelProfilePage.hostelID = snapshot.data[i].id;
                                  Navigator.pushNamed(context, MyRoutes.hostelProfileRoute);
                                },
                                child: Container
                                (                    
                                  width: 325,
                                  margin: const EdgeInsets.fromLTRB(15, 15, 15, 45),
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
                                            Image.network(snapshot.data[i].hostelPhoto,fit: BoxFit.fill),
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
                                                      userID = loggedUserID;
                                                      saveHostel();
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
                                      Padding
                                      (
                                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        child: Row
                                        (
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: 
                                          [
                                            Row(
                                              children: [
                                                
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
                                      const SizedBox(height: 25,)
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
            )
          ]
        )      
      ),
    );
  }
}