import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/base_url.dart';
import 'package:hotel_booking_app/utils/routes.dart';
import 'package:http/http.dart' as http;

class RegisterHostelPage extends StatefulWidget {
  const RegisterHostelPage({ Key? key }) : super(key: key);

  @override
  State<RegisterHostelPage> createState() => _RegisterHostelPageState();
}

class _RegisterHostelPageState extends State<RegisterHostelPage> 
{
  final List _options = ["Hostel type", "Unisex", "Girls only", "Boys only"];

  late List<DropdownMenuItem<String>> _dropDownMenuItems;
  late String? _currentOption;

  String? selectedHostelType;
  TextEditingController hostelNameControl = TextEditingController();
  TextEditingController hostelCityControl = TextEditingController();
  TextEditingController hostelStreetControl = TextEditingController();
  TextEditingController hostelTypeControl = TextEditingController();
  TextEditingController hostelPhoneControl = TextEditingController();
  TextEditingController hostelTotalRooms = TextEditingController();



  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentOption = _dropDownMenuItems[0].value!;
    super.initState();
  }
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String option in _options) 
    {
      items.add
      ( 
        DropdownMenuItem
        (
          value: option,
          child: Text(option)
        )
      );
    }
    return items;
  }

  void registerHostel() async {
    var response = await http.post(Uri.parse('${BaseUrl.baseUrl}registerHostel/'), body: {'hostelName': hostelNameControl.text, 'hostelCity': hostelCityControl.text, 'hostelStreet': hostelStreetControl.text, 'hostelType':selectedHostelType, 'hostelPhone': hostelPhoneControl.text, 'hostelTotalRooms': hostelTotalRooms.text});
    var jsonData = json.decode(response.body);
    if(response.statusCode == 201)
    {
      showDialog
      (
        context: context,
        builder: (ctx) => AlertDialog
        (
          title: const Text("Hostel registered"),
          content: const Text("Manage your hostel?"),
          actions: <Widget>
          [
            FlatButton
            (
              onPressed: () 
              {
                Navigator.pushNamed(context, MyRoutes.manageHostelRoute);
              },
              child: Text("ok"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
      (
        title: const Text("Register your hostel")
      ),
      body: SingleChildScrollView
      (
        child: Center
        (
          child: Column
          (
            children: 
            [
              SizedBox(height: 50,),
              Container
              (
                width: 325.0,
                decoration: BoxDecoration
                (
                  border: Border.all
                  (
                    color: Colors.cyan,
                    width: 3
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(15.0))
                ),
                child: Padding
                (
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                  child: Column
                  (
                    children: 
                    [
                      const SizedBox
                      (
                        height: 20.0,
                      ),
                      TextFormField
                      (
                        controller: hostelNameControl,
                        decoration: const InputDecoration
                        (
                          hintText: "Enter the hostel name",
                          labelText: "Hostel name"
                        ),
                      ),
                      const SizedBox
                      (
                        height: 20.0,
                      ),
                      TextFormField
                      (
                        controller: hostelCityControl,
                        decoration: const InputDecoration
                        (
                          hintText: "Enter the city name",
                          labelText: "Hostel city",
                        ),
                      ),
                      const SizedBox
                      (
                        height: 20.0,
                      ),
                      TextFormField
                      (
                        controller: hostelStreetControl,
                        decoration: const InputDecoration
                        (
                          hintText: "Enter the hostel street",
                          labelText: "Hostel street",
                        ),
                      ),
                      const SizedBox
                      (
                        height: 20.0,
                      ),
                      DropdownButton
                      (
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black54),
                        underline: Container( height: 1, color: Colors.black38,),
                        isExpanded: true,
                        value: _currentOption,
                        items: _dropDownMenuItems, 
                        onChanged: changedDropDownItem
                      ),
                      const SizedBox
                      (
                        height: 20.0,
                      ),
                      TextFormField
                      (
                        controller: hostelPhoneControl,
                        decoration: const InputDecoration
                        (
                          hintText: "Enter the phone number",
                          labelText: "Hostel phonenumber",
                        ),
                      ),
                      const SizedBox
                      (
                        height: 20.0,
                      ),
                      TextFormField
                      (
                        controller: hostelTotalRooms,
                        decoration: const InputDecoration
                        (
                          hintText: "Enter the total number of rooms",
                          labelText: "Total rooms",
                        ),
                      ),
                      const SizedBox
                      (
                        height: 40.0,
                      ),
                      ElevatedButton.icon
                      (
                        onPressed: () 
                        {
                          registerHostel();
                        }, 
                        label: const Text
                        (
                          "Register",
                          style: TextStyle
                          (
                            color: Colors.white
                          ),
                        ),
                        icon: Icon(CupertinoIcons.arrow_right, color: Colors.white),
                      ),
                    ],
                  ),
                ),        
              ),
              Padding
              (
                padding: const EdgeInsets.fromLTRB(15,100,0,0),
                child: Row
                (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: 
                  [
                    const Text
                    (
                      "Already registered the hostel?",
                    ),
                    TextButton
                    (
                      onPressed: () 
                      {
                        Navigator.pushNamed(context, MyRoutes.hostelOwnerDetailsRoute);
                      }, 
                      child: const Text
                      (
                        "Manage it",
                        style: TextStyle
                        (
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )
                    )
                  ]               
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
  void changedDropDownItem(String? selectedOption)
  {
    setState(() {
      _currentOption = selectedOption;
      selectedHostelType = _currentOption;
    });
  }
}