import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/routes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class HostelRoomDetailsPage extends StatefulWidget
{
  static File imageFile = File("/data/user/0/com.example.hotel_booking_app/cache/scaled_image_picker2299538797636673050.jpg");
  const HostelRoomDetailsPage({ Key? key }) : super(key: key);

  @override
  State<HostelRoomDetailsPage> createState() => _HostelRoomDetailsPageState();
}

class _HostelRoomDetailsPageState extends State<HostelRoomDetailsPage> 
{
  final List _options = ["Room type", "Single bed", "Double bed", "Triple bed", "more than triple beds"];

  late List<DropdownMenuItem<String>> _dropDownMenuItems;
  late String? _currentOption;

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

  @override
  Widget build(BuildContext context) {
    int roomNum = 1;
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text("Hostel Room Details")
      ),
      body: SingleChildScrollView
      (
        child: Center
        (
          child: Column
          (
            children: 
            [
              SizedBox(height: 100,),
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
                      Text("Room $roomNum", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox
                      (
                        height: 40.0,
                      ),
                      DropdownButton
                      (
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
                        decoration: const InputDecoration
                        (
                          hintText: "Enter the number of rooms",
                          labelText: "Total rooms"
                        ),
                      ),
                      const SizedBox
                      (
                        height: 20.0,
                      ),
                      TextFormField
                      (
                        decoration: const InputDecoration
                        (
                          hintText: "Enter the room price",
                          labelText: "Room price",
                        ),
                      ),
                      const SizedBox
                      (
                        height: 20.0,
                      ),
                      ElevatedButton.icon
                      (
                        onPressed: () 
                        {
                          showDialog
                          (
                            context: context,
                            builder: (BuildContext context) => _buildPopupDialog(context),
                          );
                        }, 
                        label: const Text
                        (
                          "Add room picture",
                          style: TextStyle
                          (
                            color: Colors.white
                          ),
                        ),
                        icon: Icon(CupertinoIcons.camera, color: Colors.white),
                      ),
                      Padding
                      (
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Divider(color: Colors.black12, thickness: 1),
                      ),
                      Text("Amenities", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox
                      (
                        height: 20.0,
                      ),
                      TextFormField
                      (
                        decoration: const InputDecoration
                        (
                          hintText: "Enter the amenity's name",
                          labelText: "Amenity name",
                        ),
                      ),
                      const SizedBox
                      (
                        height: 20.0,
                      ),
                      ElevatedButton.icon
                      (
                        onPressed: () 
                        {
                          showDialog
                          (
                            context: context,
                            builder: (BuildContext context) => _buildPopupDialog(context),
                          );
                        }, 
                        label: const Text
                        (
                          "Add amenity",
                          style: TextStyle
                          (
                            color: Colors.white
                          ),
                        ),
                        icon: Icon(CupertinoIcons.add_circled, color: Colors.white),
                      ),
                      const SizedBox
                      (
                        height: 20.0,
                      ),
                    ],
                  ),
                ),        
              ),
              SizedBox(height: 20),
              ElevatedButton.icon
              (
                onPressed: () 
                {
                  Navigator.pushNamed(context, MyRoutes.confirmationRoute);
                }, 
                label: const Text
                (
                  "Add room",
                  style: TextStyle
                  (
                    color: Colors.white
                  ),
                ),
                icon: Icon(CupertinoIcons.add_circled, color: Colors.white),
              ),
              SizedBox(height: 40),
              ElevatedButton
              (
                onPressed: () 
                {
                  Navigator.pushNamed(context, MyRoutes.homeRoute);
                }, 
                child: const Text
                (
                  "Register",
                  style: TextStyle
                  (
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
              Padding
              (
                padding: const EdgeInsets.fromLTRB(15,80,0,0),
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
                        Navigator.pushNamed(context, MyRoutes.loginRoute);
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
    });
  }

  _getFromGallery() async 
  {
    XFile? pickedFile = await ImagePicker().pickImage
    (
      source: ImageSource.gallery,
      maxWidth: 200,
      maxHeight: 200,
    );
    if (pickedFile != null) {
      setState(() {
        HostelRoomDetailsPage.imageFile = File(pickedFile.path);
        print(HostelRoomDetailsPage.imageFile.toString());
      });
    }
  }

  _getFromCamera() async 
  {
    XFile? pickedFile = await ImagePicker().pickImage
    (
      source: ImageSource.camera,
      maxWidth: 200,
      maxHeight: 200,
    );
    if (pickedFile != null) {
      setState(() {
        HostelRoomDetailsPage.imageFile = File(pickedFile.path);
      });
    }
  }

  Widget _buildPopupDialog(BuildContext context) 
  {
    return AlertDialog
    (
      title: const Text('Select a content type'),
      content: Column
      (
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>
        [
          TextButton.icon
          (
            style: ButtonStyle
            (
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            onPressed: () => _getFromGallery(), 
            icon: Icon(CupertinoIcons.photo),
            label: Text("Select from gallery"),
          ),
          TextButton.icon
          (
            style: ButtonStyle
            (
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            onPressed: () => _getFromCamera(), 
            icon: Icon(CupertinoIcons.camera),
            label: Text("Click a picture"),
          )
        ],
      ),
      actions: <Widget>
      [
        TextButton
        (
          style: TextButton.styleFrom
          (
            primary: Colors.black
          ),
          onPressed: () {Navigator.of(context).pop();}, 
          child: Text("close"),
        ),
      ],
    );
  }
}