import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/Model/user_model.dart';
import 'package:hotel_booking_app/apis/api.dart';
import 'package:hotel_booking_app/utils/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_email_sender/flutter_email_sender.dart';
import '../utils/routes.dart';

class CustomerCarePage extends StatefulWidget {
  CustomerCarePage({Key? key}) : super(key: key);

  @override
  State<CustomerCarePage> createState() => _CustomerCarePageState();
}

class _CustomerCarePageState extends State<CustomerCarePage> {

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    _recipientController.dispose();
    super.dispose();
  }

  UserModel userModel = UserModel();

  Color fontColorAlt = Colors.white;
  Color containerColorAlt = Colors.white;
  Color buttonFontColorAlt = Colors.cyan;
  Color backgroundColorAlt = Colors.cyan;
  Color fontColor = Colors.black;
  Color containerColor = Colors.cyan;
  Color buttonFontColor = Colors.white;
  Color backgroundColor = Colors.white;
  bool alt = false;

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  final _recipientController = TextEditingController(
    text: 'biman.lakhey74@gmail.com',
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> send() async {
    final Email email = Email(
      body:"Username: ${userNameController.text}\nEmail: ${emailController.text}\nMessage: ${messageController.text}",
      subject: subjectController.text,
      recipients: [_recipientController.text],
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

    void getUserData() async {
    try
    {
      var response = await http.get(Uri.parse('${BaseUrl.baseUrl}userProfile/$loggedUserID'));
      var jsonData = json.decode(response.body);
      
      setState(() {
        userModel = UserModel.fromJson({"data": jsonData});
        
      });
      userNameController.text = jsonData["username"];
      emailController.text = jsonData["userEmail"];
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

  void sendUserMessage() async
  {
    try
    {
      var response = await http.get(Uri.parse('${BaseUrl.baseUrl}userProfile/$loggedUserID'));
      var jsonData = json.decode(response.body);
      print("message sent");

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
  Widget build(BuildContext context) {
    return Scaffold
    (
      key: _scaffoldKey,
      appBar: AppBar
      (
        leading: IconButton
        (
          icon: const Icon(CupertinoIcons.arrow_left),
          onPressed: () => Navigator.pushNamed(context, MyRoutes.homeRoute),
        ),
        title: const Text("Customer care"),
        centerTitle: true,
      ), 
      backgroundColor: alt ? backgroundColorAlt : backgroundColor,
      body: Center(
        child: SingleChildScrollView
        (
          child: Column
          (
            children: [
              Padding
              (
                padding: const EdgeInsets.all(15),
                child: Container
                (
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
                        const Text
                        (
                          "Send us a message",
                          style: TextStyle
                          (
                            fontSize: 28,
                            fontWeight:  FontWeight.bold,
                          ),
                        ),
                        const SizedBox
                        (
                          height: 20.0,
                        ),
                        TextFormField
                        (
                          readOnly: true,
                          controller: userNameController,
                          decoration: const InputDecoration
                          ( 
                            hintText: "Enter your username",
                            labelText: "Username"
                          ),
                        ),
                        const SizedBox
                        (
                          height: 20.0,
                        ),
                        TextFormField
                        (
                          readOnly: true,
                          controller: emailController,
                          decoration: const InputDecoration
                          (
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
                          controller: subjectController,
                          decoration: const InputDecoration
                          (
                            hintText: "Enter your subject",
                            labelText: "Subject",
                          ),
                        ),
                        const SizedBox
                        (
                          height: 20.0,
                        ),
                        TextFormField
                        (
                          minLines: 1,
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          controller: messageController,
                          decoration: const InputDecoration
                          (
                            hintText: "Enter your message",
                            labelText: "Message",
                          ),
                        ),
                        const SizedBox
                        (
                          height: 40.0,
                        ),
                        ElevatedButton
                        (
                          onPressed: () 
                          { 
                            send();
                          }, 
                          child: const Text
                          (
                            "Send message",
                            style: TextStyle
                            (
                              color: Colors.white
                            ),
                          ),
                          style: ElevatedButton.styleFrom
                          (
                            minimumSize: const Size(150, 40),
                            side: const BorderSide(width: 2, color: Colors.cyan),
                          )
                        ),
                      ],
                    ),
                  ),        
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}