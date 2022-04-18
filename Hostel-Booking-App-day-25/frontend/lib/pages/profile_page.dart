// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/Model/user_model.dart';
import 'package:hotel_booking_app/utils/base_url.dart';
import 'package:hotel_booking_app/utils/routes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

enum ImageSourceType {gallery, camera}

class ProfilePage extends StatefulWidget 
{
  static String? usernameHolder;
  static String? passwordHolder;

  static File imageFile = File("/data/user/0/com.example.hotel_booking_app/cache/scaled_image_picker2299538797636673050.jpg");
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> 
{
  String? usernameHolder = ProfilePage.usernameHolder;
  String? passwordHolder = ProfilePage.passwordHolder;
  
  UserModel userModel = UserModel();
  String? profileImgUrl;
  TextEditingController username = TextEditingController();
  TextEditingController userFName = TextEditingController();
  TextEditingController userLName = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userAddress = TextEditingController();
  TextEditingController userPhone = TextEditingController();

  bool isEnabled = false;
  bool profilePhoto = false;
  late int userID;

  @override
  void initState()
  {
    super.initState();
    getUserData();
    //updateUserData();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  void updateUser() async 
  {
    try
    {
      var userResponse = await http.put(Uri.parse('${BaseUrl.baseUrl}updateUser/$userID'), body: {'username': username.text, 'userFName': userFName.text, 'userLName': userLName.text, 'userEmail':userEmail.text, 'userAddress': userAddress.text, 'userPhone': userPhone.text});
      var userJsonData = json.decode(userResponse.body);
      
      if(userResponse.statusCode == 200)
      {
        showDialog
        (
          context: context,
          builder: (ctx) => AlertDialog
          (
            title: const Text("Success"),
            content: const Text("User updated!"),
            actions: <Widget>
            [
              FlatButton
              (
                onPressed: () 
                {
                  Navigator.pop(context);
                },
                child: Text("ok"),
              ),
            ],
          ),
        );
      }
    }
    catch(e)
    {
      print("no internet");
    }
    
  }
  
  void getUserData() async 
  {
    try
    {
      var response = await http.post(Uri.parse('${BaseUrl.baseUrl}loginUser/'), body: {'username': usernameHolder, 'userPassword': passwordHolder});
      var jsonData = json.decode(response.body);
      
      setState(() {
        userModel = UserModel.fromJson({"data": jsonData});
        profilePhoto = true;
        
      });
      username.text = jsonData["username"];
      userFName.text = jsonData["userFName"];
      userLName.text = jsonData["userLName"];
      userEmail.text = jsonData["userEmail"];
      userAddress.text = jsonData["userAddress"];
      userPhone.text = jsonData["userPhone"];
      profileImgUrl = jsonData["userPhoto"];
      userID = jsonData["user_id"];
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

    return Scaffold
    (
      appBar: AppBar
      (
        leading: IconButton
        (
          icon: const Icon(CupertinoIcons.arrow_left),
          onPressed: () => Navigator.pushNamed(context, MyRoutes.homeRoute),
        ),
        title: const Text("User Profile"),
        centerTitle: true,
        foregroundColor: Colors.white,
      ), 
      body: SingleChildScrollView
      (
        child: Center
        (
          child: Padding
          (
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column
            (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: 
              [
                Row
                (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: 
                  [
                    Padding
                    (
                      padding: const EdgeInsets.fromLTRB(35,0,0,0),
                      child: Container
                      (
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration
                        (
                          boxShadow: const 
                          [
                            BoxShadow(color: Colors.cyan, spreadRadius: 2, blurRadius: 4)
                          ],
                          borderRadius: const BorderRadius.all(Radius.circular(50.0))
                        ),
                        width: 100,
                        height: 100,
                        child: profilePhoto
                        ? Image.network
                        (
                          profileImgUrl.toString(),
                          fit: BoxFit.contain,
                        )
                        : CircularProgressIndicator(color: Colors.white,)
                      ),
                    ),
                    IconButton
                    (
                      onPressed: () 
                      {
                        showDialog
                        (
                          context: context,
                          builder: (BuildContext context) => _buildPopupDialog(context),
                        );
                      }, 
                      icon: const Icon(CupertinoIcons.photo_camera)
                    )
                  ]
                ),
                const SizedBox
                (
                  height: 10.0,
                ),
                Text(
                  "User profile", 
                  style: TextStyle(fontSize: 35)),
                const SizedBox
                (
                  height: 25.0,
                ),
                Container
                (
                  height: 600.0,
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
                    padding: const EdgeInsets.all(30.0),
                    child: Column
                    (
                      children: 
                      [  
                        //LoginPage(setUserData: getUserData),
                        TextFormField
                        (

                          controller: username,
                          enableInteractiveSelection: false, 
                          decoration: InputDecoration
                          (
                            enabled: isEnabled,
                            hintText: "Enter your username",
                            labelText: "username",
                          ),
                        ),
                        const SizedBox
                        (
                          height: 20.0,
                        ),
                        TextFormField
                        (
                          controller: userFName,
                          enableInteractiveSelection: false, 
                          decoration: InputDecoration
                          (
                            enabled: isEnabled,
                            hintText: "Enter your first name",
                            labelText: "First name",
                          ),
                        ),
                        const SizedBox
                        (
                          height: 20.0,
                        ),
                        TextFormField
                        (
                          controller: userLName,
                          enableInteractiveSelection: false, 
                          decoration: InputDecoration
                          (
                            enabled: isEnabled,
                            hintText: "Enter your last name",
                            labelText: "last name",
                          ),
                        ),
                        const SizedBox
                        (
                          height: 20.0,
                        ),
                        TextFormField
                        (
                          controller: userEmail,
                          decoration: InputDecoration
                          (
                            enabled: isEnabled,
                            hintText: "Enter your email",
                            labelText: "Email",
                          ),
                        ),
                        const SizedBox
                        (
                          height: 20.0,
                        ),
                        TextFormField
                        (
                          controller: userAddress,
                          decoration: InputDecoration
                          (
                            enabled: isEnabled,
                            hintText: "Enter your address",
                            labelText: "Address",
                          ),
                        ),
                        const SizedBox
                        (
                          height: 20.0,
                        ),
                        TextFormField
                        (
                          controller: userPhone,
                          decoration: InputDecoration
                          (
                            enabled: isEnabled,
                            hintText: "Enter your phone number",
                            labelText: "Phone number",
                          ),
                        ),
                        const SizedBox
                        (
                          height: 20.0,
                        ),
                        ElevatedButton
                        (
                          onPressed: () {
                             saveTextFields();  
                             if(!isEnabled)
                             {
                               updateUser();
                             }
                            },
                          child: isEnabled
                          ? Text
                          (
                            "Save", 
                            style: TextStyle(color: Colors.white)
                          )
                          : Text
                          (
                            "Edit", 
                            style: TextStyle(color: Colors.white)
                          )                  
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ) 
        )    
      )
    );
  }

  void saveTextFields()
  {
    setState(() 
    {
      isEnabled = !isEnabled;
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
        ProfilePage.imageFile = File(pickedFile.path);
        print(pickedFile.name);
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
        ProfilePage.imageFile = File(pickedFile.path);
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

