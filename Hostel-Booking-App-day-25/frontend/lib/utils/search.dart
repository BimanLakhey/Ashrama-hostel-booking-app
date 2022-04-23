import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/apis/api.dart';
import 'package:hotel_booking_app/pages/hostel_profile_page.dart';
import 'package:hotel_booking_app/utils/base_url.dart';
import 'package:hotel_booking_app/utils/routes.dart';
import 'package:http/http.dart' as http;

int itemCount = 0;
String? matchedHostel;
AsyncSnapshot? snapS;
String? hID;
bool matched = false;
class Search extends SearchDelegate<String>
{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return 
    [
      IconButton
      (
        onPressed: () => query = "", 
        icon: const Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return  IconButton
    (
      icon: AnimatedIcon
      (
        icon: AnimatedIcons.menu_arrow, 
        progress: transitionAnimation,
      ),
      onPressed: () => Navigator.pushNamed(context, MyRoutes.homeRoute),

    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container
    (
      child: GestureDetector
      (
        onTap: () 
        {
          HostelProfilePage.hostelID = hID;
          Navigator.pushNamed(context, MyRoutes.hostelProfileRoute);
        },
        child: ListTile
        (
          leading: Icon(Icons.location_city_outlined),
          title: Text(matchedHostel.toString()),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) 
  {
    itemCount = 0;
    matchedHostel;
    hID;
    matched = false;
    return FutureBuilder
    (
      future: getHostels(),
      builder: (context, AsyncSnapshot snapshot)
      {
        if(snapshot.data == null)
        {
          return const Center(child: CircularProgressIndicator());
        }
        else
        {
          return ListView.builder
          (
            itemBuilder: (context, index) 
            { 
              for(int i = 0; i<= index; i++)
              {
                if(query == snapshot.data[index].hostelName.toString().substring(0, 3))
                {
                  matched= true;
                  itemCount = 1;
                  matchedHostel = snapshot.data[index].hostelName;
                  hID = snapshot.data[index].id;
                }
              }
              
              return GestureDetector
              (
                onTap: () 
                {
                  HostelProfilePage.hostelID = snapshot.data[index].id;
                  Navigator.pushNamed(context, MyRoutes.hostelProfileRoute);
                },
                child: ListTile
                (
                  leading: Icon(Icons.location_city_outlined),
                  title: matched ? Text(matchedHostel.toString()) : Text(snapshot.data[index].hostelName),
                ),
              );
            },
            itemCount: query.isEmpty ? 0 : matched ? itemCount : snapshot.data.length,
          );
        }
      },
    ); 
  }
}