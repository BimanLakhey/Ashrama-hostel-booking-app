import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/routes.dart';

class Search extends SearchDelegate<String>
{
  final testValues = [
    "hello",
    "world",
    "my",
    "name",
    "is"
  ];

  final recentValues = [
    "my",
    "name",
    "is"
  ];
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
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? recentValues : testValues;
    return ListView.builder
    (
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.location_city_outlined),
        title: Text(suggestionList[index]
        ),
      ),
      itemCount: suggestionList.length,
    ); 
  }
}