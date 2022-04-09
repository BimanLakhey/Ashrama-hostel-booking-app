//@dart = 2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/apis/api.dart';
import 'package:hotel_booking_app/pages/hostel_profile_page.dart';
import 'package:hotel_booking_app/pages/saved_page.dart';
import 'package:hotel_booking_app/utils/drawer.dart';
import 'package:hotel_booking_app/utils/routes.dart';
import 'package:hotel_booking_app/utils/search.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) { 
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
              scrollDirection: Axis.horizontal,
              child: Padding
              (
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.placemark), 
                          label: const Text("Nearby"),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
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
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.hand_thumbsup), 
                          label: const Text("For you"),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
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
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.money_dollar), 
                          label: const Text("Cheapest"),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
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
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.percent), 
                          label: const Text("Deals"),
                        ),
                      ),
                    )
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
              future: getHostels(),
              builder: (context, snapshot) 
              {
                //print(snapshot.data);
                if(snapshot.data == null)
                {
                  return Container(child: Text("loading...", style: TextStyle(fontSize: 18),));
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
                        return SingleChildScrollView
                        (
                          child: Column
                          (
                            children: 
                            [
                              
                              InkWell(
                                onTap: () 
                                {
                                  HostelProfilePage.hostelID = snapshot.data[i].id;
                                  Navigator.pushNamed(context, MyRoutes.hostelProfileRoute);
                                },
                                child: Container
                                (                    
                                  width: 325,
                                  margin: EdgeInsets.fromLTRB(15, 15, 15, 45),
                                  decoration: BoxDecoration
                                  (
                                    boxShadow: 
                                    [
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
                                        child: Image.network(
                                          snapshot.data[i].hostelPhoto, 
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Padding(
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
                                              children: [
                                                
                                                Text(snapshot.data[i].hostelCity, style: TextStyle(color: Colors.white, fontSize: 15)),
                                                Text(", ", style: TextStyle(color: Colors.white, fontSize: 15)),
                                                Text(snapshot.data[i].hostelStreet, style: TextStyle(color: Colors.white, fontSize: 15)),
                                              ],
                                            ),
                                               
                                          ],
                                        ),
                                      ),
                                      Text
                                      (
                                        snapshot.data[i].hostelType, 
                                        style: TextStyle(color: Colors.white, fontSize: 15)
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
            )
          ]
        )      
      ),
    );
  }
}