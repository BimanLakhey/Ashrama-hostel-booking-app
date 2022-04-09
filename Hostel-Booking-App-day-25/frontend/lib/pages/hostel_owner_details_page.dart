import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/routes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class HostelOwnerDetailsPage extends StatefulWidget
{
  static File imageFile = File("/data/user/0/com.example.hotel_booking_app/cache/scaled_image_picker2299538797636673050.jpg");
  const HostelOwnerDetailsPage({ Key? key }) : super(key: key);

  @override
  State<HostelOwnerDetailsPage> createState() => _HostelOwnerDetailsPageState();
}

class _HostelOwnerDetailsPageState extends State<HostelOwnerDetailsPage> 
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
      (
        title: Text("Hostel Owner Details")
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
                      const SizedBox
                      (
                        height: 20.0,
                      ),
                      TextFormField
                      (
                        decoration: const InputDecoration
                        (
                          
                          hintText: "Enter the owner name",
                          labelText: "Owner name"
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
                          hintText: "Enter the owner address",
                          labelText: "Owner city",
                        ),
                        obscureText: true,
                      ),
                      const SizedBox
                      (
                        height: 20.0,
                      ),
                      TextFormField
                      (
                        decoration: const InputDecoration
                        (
                          hintText: "Enter the owner email",
                          labelText: "Owner email",
                        ),
                        obscureText: true,
                      ),
                      const SizedBox
                      (
                        height: 20.0,
                      ),
                     IntlPhoneField
                      (
                        showCountryFlag: false,
                        decoration: const InputDecoration
                        (
                            labelText: "Owner phone number",
                            hintText: "Enter the owner phone number"   
                        ),
                        initialCountryCode: 'NP',
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
                          "Owner license",
                          style: TextStyle
                          (
                            color: Colors.white
                          ),
                        ),
                        icon: Icon(CupertinoIcons.camera, color: Colors.white),
                      ),
                      const SizedBox
                      (
                        height: 40.0,
                      ),
                      ElevatedButton.icon
                      (
                        onPressed: () 
                        {
                          Navigator.pushNamed(context, MyRoutes.hostelRoomDetailsRoute);
                        }, 
                        label: const Text
                        (
                          "Continue",
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
        HostelOwnerDetailsPage.imageFile = File(pickedFile.path);
        print(HostelOwnerDetailsPage.imageFile.toString());
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
        HostelOwnerDetailsPage.imageFile = File(pickedFile.path);
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