// @dart=2.9
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/Model/hostel_model.dart';
import 'package:hotel_booking_app/apis/api.dart';
import 'package:hotel_booking_app/utils/base_url.dart';
import 'package:hotel_booking_app/utils/routes.dart';
import 'package:http/http.dart' as http;

class ManageHostelPage extends StatefulWidget {
  const ManageHostelPage({Key key}) : super(key: key);

  @override
  State<ManageHostelPage> createState() => _ManageHostelPageState();
  static String hostelID;
}

class _ManageHostelPageState extends State<ManageHostelPage> {
  @override
  void initState() 
  {
    getHostelData();
    myHostelDetails = getBookingDetails();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController hostelName = TextEditingController();
  TextEditingController hostelCity = TextEditingController();
  TextEditingController hostelStreet = TextEditingController();
  TextEditingController hostelType = TextEditingController();
  TextEditingController hostelPhone = TextEditingController();
  TextEditingController hostelTotalRooms = TextEditingController();

  Color fontColor = Colors.white;
  Color containerColor = Colors.white;
  Color buttonFontColor = Colors.white;
  Color backgroundColor = Colors.cyan;
  Color buttonColor = Colors.cyan;

  Color fontColorAlt = Colors.black;
  Color containerColorAlt = Colors.cyan;
  Color buttonFontColorAlt = Colors.white;
  Color backgroundColorAlt = Colors.white;
  Color buttonColorAlt = Colors.cyan;
  bool alt = true;

  int currentlyHosting = 0;
  int arrivingSoon = 0;
  int checkingOut = 0;
  int checkedOut = 0;
  String allReservations = "0";

  HostelModel hostelModel = HostelModel();
  String hostelID = ManageHostelPage.hostelID;
  String hostelPhoto;

  bool isEnabled = false;
  bool dataLoaded = false;
  bool hasData = true;
  Future myHostelDetails;
  int index = 0;

  void saveTextFields()
  {
    setState(() 
    {
      isEnabled = !isEnabled;
    });
  }

  void getHostelData() async 
  {
    try
    {
      var response = await http.get(Uri.parse('${BaseUrl.baseUrl}hostelProfile/$hostelID'));
      var jsonData = json.decode(response.body);
      
      setState(() {
        hostelModel = HostelModel.fromJson({"data": jsonData});
        dataLoaded = true;
        
      });
      hostelID = jsonData["id"].toString();
      hostelName.text = jsonData["hostelName"];
      hostelPhoto = jsonData["hostelPhoto"];
      hostelCity.text = jsonData["hostelCity"];
      hostelStreet.text = jsonData["hostelStreet"];
      hostelPhone.text = jsonData["hostelPhone"];
      hostelTotalRooms.text = jsonData["hostelTotalRooms"];
      hostelType.text = jsonData["hostelType"];
    }
    catch(e)
    {
      if(hasRegisteredHostel == false)
      {

      }
      else
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
    
  }

  void updateHostel() async 
  {
    try
    {
      var registerResponse = await http.put(Uri.parse('${BaseUrl.baseUrl}updateHostel/$hostelID'), body: {'hostelName': hostelName.text, 'hostelCity': hostelCity.text, 'hostelStreet': hostelStreet.text, 'hostelType':hostelType.text, 'hostelPhone': hostelPhone.text, 'hostelTotalRooms': hostelTotalRooms.text});
      var registerJsonData = json.decode(registerResponse.body);
      
      if(registerResponse.statusCode == 201)
      {
        // registeredHostels();
        showDialog
        (
          context: context,
          builder: (ctx) => AlertDialog
          (
            title: const Text("Success"),
            content: const Text("Hostel updated!"),
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
      body: hasRegisteredHostel == false
      ? Center
      (
        child: SizedBox
        (
          height: 150,
          child: Column
          (
            children: 
            [
              const Text("You haven't registered a hostel yet!", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 25,),
              ElevatedButton
              (
                style: ElevatedButton.styleFrom
                (
                  primary: alt? buttonColorAlt : buttonColor
                ),
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.registerHostel);
                },
                child: Text("Register hostel", style: TextStyle(color: Colors.white),)
              )
            ],
          ),
        ),
      ) 
      : dataLoaded == false
      ? Center(child: CircularProgressIndicator( backgroundColor: alt? backgroundColorAlt : backgroundColor))
      : Center
      (
        child: Scaffold
        (
          appBar: AppBar
          (
            leading: IconButton
            (
              icon: const Icon(CupertinoIcons.arrow_left),
              onPressed: () => Navigator.pushNamed(context, MyRoutes.homeRoute),
            ),
            title: const Text("Your hostel"),
          ), 
          backgroundColor: alt ? backgroundColorAlt : backgroundColor,
          body: SingleChildScrollView
          (
            child: Column
            (
              children: 
              [
                FractionallySizedBox
                (
                  widthFactor: 1,
                  child: Container
                  (
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration
                    (
                      borderRadius: BorderRadius.only
                      (
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    height: 200,
                    child: Image.network(BaseUrl.savedBaseUrl + hostelPhoto.toString(), fit: BoxFit.fill),
                  ),
                ),
                Align
                (
                  alignment: Alignment.centerLeft,
                  child: Padding
                  (
                    padding: const EdgeInsets.fromLTRB(15, 30, 0, 0),
                    child: Text("Hostel details", style: TextStyle(fontSize: 20, color: alt? fontColorAlt : fontColor)),
                  ),
                ),
                const SizedBox(height: 30),
                Padding
                (
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container
                  (
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
                      color: containerColor,
                      border: Border.all
                      (
                        color: alt ? containerColorAlt : containerColor,
                        width: 3
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(15.0))
                    ),
                    child: Padding
                    (
                      padding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 25),
                      child: Column
                      (
                        children: 
                        [  
                          TextFormField
                          (
                            controller: hostelName,
                            enableInteractiveSelection: false, 
                            decoration: InputDecoration
                            (
                              hintStyle: TextStyle(color: alt? buttonFontColorAlt : buttonFontColor),
                              labelStyle: TextStyle(color: alt ? buttonFontColorAlt : buttonFontColor),
                              enabled: isEnabled,
                              hintText: "Enter the hostel name",
                              labelText: "Hostel name",
                            ),
                          ),
                          const SizedBox
                          (
                            height: 20.0,
                          ),
                          TextFormField
                          (
                            
                            controller: hostelCity,
                            enableInteractiveSelection: false, 
                            decoration: InputDecoration
                            (
                              hintStyle: TextStyle(color: alt? buttonFontColorAlt : buttonFontColor),
                              labelStyle: TextStyle(color: alt ? buttonFontColorAlt : buttonFontColor),
                              enabled: isEnabled,
                              hintText: "Enter the hostel city",
                              labelText: "Hostel city",
                            ),
                          ),
                          const SizedBox
                          (
                            height: 20.0,
                          ),
                          TextFormField
                          (
                            controller: hostelStreet,
                            enableInteractiveSelection: false, 
                            decoration: InputDecoration
                            (
                              hintStyle: TextStyle(color: alt? buttonFontColorAlt : buttonFontColor),
                              labelStyle: TextStyle(color: alt ? buttonFontColorAlt : buttonFontColor),
                              enabled: isEnabled,
                              hintText: "Enter the hostel street",
                              labelText: "Hostel street",
                            ),
                          ),
                          const SizedBox
                          (
                            height: 20.0,
                          ),
                          TextFormField
                          (
                            controller: hostelPhone,
                            decoration: InputDecoration
                            (
                              hintStyle: TextStyle(color: alt? buttonFontColorAlt : buttonFontColor),
                              labelStyle: TextStyle(color: alt ? buttonFontColorAlt : buttonFontColor),
                              enabled: isEnabled,
                              hintText: "Enter the hostel phonenumber",
                              labelText: "Hostel phone number",
                            ),
                          ),
                          const SizedBox
                          (
                            height: 20.0,
                          ),
                          TextFormField
                          (
                            cursorColor: Colors.cyan,
                            controller: hostelType,
                            decoration: InputDecoration
                            (
                              hintStyle: TextStyle(color: alt? buttonFontColorAlt : buttonFontColor),
                              labelStyle: TextStyle(color: alt ? buttonFontColorAlt : buttonFontColor),
                              enabled: isEnabled,
                              hintText: "Enter the hostel type",
                              labelText: "Hostel type",
                            ),
                          ),
                          const SizedBox
                          (
                            height: 20.0,
                          ),
                          TextFormField
                          (
                            controller: hostelTotalRooms,
                            decoration: InputDecoration
                            (
                              hintStyle: TextStyle(color: alt? buttonFontColorAlt : buttonFontColor),
                              labelStyle: TextStyle(color: alt ? buttonFontColorAlt : buttonFontColor),
                              enabled: isEnabled,
                              hintText: "Enter the total no. rooms",
                              labelText: "Total rooms",
                            ),
                          ),
                          const SizedBox
                          (
                            height: 20.0,
                          ),
                          ElevatedButton
                          (
                            style: ElevatedButton.styleFrom
                            (
                              primary: alt? buttonColorAlt : buttonColor
                            ),
                            onPressed: () {
                               saveTextFields();  
                               if(!isEnabled)
                               {
                                 updateHostel();
                               }
                              },
                            child: isEnabled
                            ? Text
                            (
                              "Save", 
                              style: TextStyle(color: alt ? buttonFontColorAlt : buttonFontColor)
                            )
                            : Text
                            (
                              "Edit", 
                              style: TextStyle(color: alt ? buttonFontColorAlt : buttonFontColor)
                            )                  
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Align
                (
                  alignment: Alignment.centerLeft,
                  child: Padding
                  (
                    padding: const EdgeInsets.fromLTRB(15, 45, 0, 0),
                    child: Text("Your reservations", style: TextStyle(fontSize: 20, color: alt? fontColorAlt : fontColor)),
                  ),
                ),

                SingleChildScrollView
                (
                  scrollDirection: Axis.horizontal,
                  child: Padding
                  (
                    padding: const EdgeInsets.fromLTRB(15, 25, 15, 15),
                    child: Row
                    (
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: 
                      [
                        Container
                        (
                          height: 45,
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
                            color: alt ? buttonColorAlt : buttonFontColor,
                            border: Border.all(color: alt? buttonColorAlt : buttonFontColor, width: 2),
                            borderRadius: BorderRadius.circular(35)
                          ),
                          child: TextButton
                          (
                            style: TextButton.styleFrom
                            (
                              primary: alt ? buttonFontColorAlt : buttonColor,
                            ),
                            onPressed: () {},
                            child: Text("Currently hosting (${currentlyHosting.toString()})",),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container
                        (
                          height: 45,
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
                            color: alt ? buttonColorAlt : buttonFontColor,
                            border: Border.all(color: alt? buttonColorAlt : buttonFontColor, width: 2),
                            borderRadius: BorderRadius.circular(35)
                          ),
                          child: TextButton
                          (
                            style: TextButton.styleFrom
                            (
                              primary: alt ? buttonFontColorAlt : buttonColor,
                            ),
                            onPressed: () {},
                            child: Text("Arriving soon (${arrivingSoon.toString()})"),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container
                        (
                          height: 45,
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
                            color: alt ? buttonColorAlt : buttonFontColor,
                            border: Border.all(color: alt? buttonColorAlt : buttonFontColor, width: 2),
                            borderRadius: BorderRadius.circular(35)
                          ),
                          child: TextButton
                          (
                            style: TextButton.styleFrom
                            (
                              primary: alt ? buttonFontColorAlt : buttonColor,
                            ),
                            onPressed: () {},
                            child: Text("Checking out (${checkingOut.toString()})"),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container
                        (
                          height: 45,
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
                            color: alt ? buttonColorAlt : buttonFontColor,
                            border: Border.all(color: alt? buttonColorAlt : buttonFontColor, width: 2),
                            borderRadius: BorderRadius.circular(35)
                          ),
                          child: TextButton
                          (
                            style: TextButton.styleFrom
                            (
                              primary: alt ? buttonFontColorAlt : buttonColor,
                            ),
                            onPressed: () {},
                            child: Text("Checked out (${checkedOut.toString()})"),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container
                        (
                          height: 45,
                          decoration: BoxDecoration(
                            boxShadow: 
                            const [
                              BoxShadow
                              (
                                color: Colors.black54,
                                offset: Offset(1, 5),
                                blurRadius: 6,
                              )
                            ],
                            color: alt ? buttonColorAlt : buttonFontColor,
                            border: Border.all(color: alt? buttonColorAlt : buttonFontColor, width: 2),
                            borderRadius: BorderRadius.circular(35)
                          ),
                          child: TextButton
                          (
                            style: TextButton.styleFrom
                            (
                              primary: alt ? buttonFontColorAlt : buttonColor,
                            ),
                            onPressed: () {},
                            child: Text("All reservations ($allReservations)"),
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                ),
                Padding
                (
                  padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
                  child: Container
                  (
                    width: 350,
                    height: 300,
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
                      color: containerColor,
                      border: Border.all
                      (
                        color: alt ? containerColorAlt : containerColor,
                        width: 3
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(15.0))
                    ),
                    child: Center
                    (
                      child: Container
                      (
                        width: 225,
                        child: hasData 
                        ? FutureBuilder
                        (
                          future: myHostelDetails,
                          builder: (context, snapshot) 
                          {
                            if(snapshot.data == null)
                            {
                              return const Text("loading...", style: TextStyle(fontSize: 18),);
                            }
                            else
                            {
                              allReservations = snapshot.data.length.toString();
                              currentlyHosting = 0;
                              arrivingSoon = 0;
                              checkingOut = 0;
                              // checkedOut = 0;
                              return ListView.builder
                              (
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, i)
                                {
                      
                                  index = i;
                                  String bookingDate = snapshot.data[index].bookingDate;
                                  String checkingOutDate = snapshot.data[index].checkingOutDate;
                                  if(int.parse(bookingDate.substring(0, bookingDate.indexOf('-'))) <= DateTime.now().year && int.parse(bookingDate.substring(5, bookingDate.lastIndexOf('-'))) <= DateTime.now().month && int.parse(bookingDate.substring(8)) <= DateTime.now().day)
                                  {
                                    currentlyHosting++;
                                  }
                                  else if (int.parse(bookingDate.substring(0, bookingDate.indexOf('-'))) >= DateTime.now().year && int.parse(bookingDate.substring(5, bookingDate.lastIndexOf('-'))) >= DateTime.now().month && int.parse(bookingDate.substring(8)) >= DateTime.now().day)
                                  {
                                    arrivingSoon++;
                                  }
                                  else if (int.parse(checkingOutDate.substring(0, checkingOutDate.indexOf('-'))) == DateTime.now().year && int.parse(checkingOutDate.substring(5, checkingOutDate.lastIndexOf('-'))) == DateTime.now().month && int.parse(checkingOutDate.substring(8)) - 1 == DateTime.now().day)
                                  {
                                    checkingOut++;
                                  }
                                  else if (int.parse(checkingOutDate.substring(0, checkingOutDate.indexOf('-'))) <= DateTime.now().year && int.parse(checkingOutDate.substring(5, checkingOutDate.lastIndexOf('-'))) <= DateTime.now().month && int.parse(checkingOutDate.substring(8)) < DateTime.now().day)
                                  {
                                    // currentlyHosting--;
                                    checkedOut++;
                                  }
                                  WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
                                  // print(int.parse(checkingOutDate.substring(8)));
                      
                                  // print("${int.parse(checkingOutDate.substring(0, checkingOutDate.indexOf('-')))}-${int.parse(checkingOutDate.substring(5, checkingOutDate.lastIndexOf('-')))}-${int.parse(checkingOutDate.substring(8))}");
                                  return SingleChildScrollView
                                  (
                                    child: Container
                                    (                    
                                      width: 325,
                                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 45),
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
                                            child: Image.network(snapshot.data[i].userPhoto,fit: BoxFit.fill),
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
                                                  "${snapshot.data[i].userFName} ${snapshot.data[i].userLName}", 
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
                                                    
                                                    Text(snapshot.data[i].roomType, style: TextStyle(color: Colors.white, fontSize: 15)),
                                                    Text(", ", style: TextStyle(color: Colors.white, fontSize: 15)),
                                                    Text(snapshot.data[i].roomID, style: TextStyle(color: Colors.white, fontSize: 15)),
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
                                                snapshot.data[i].hostelID, 
                                                style: const TextStyle(color: Colors.white, fontSize: 15)
                                              ),
                                            ),
                                          ),     
                                          const SizedBox(height: 25,)
                                        ]
                                      ),
                                    ),
                      
                                  );
                                }
                              );
                            }
                          }
                        )
                        : Text("You don't have any guests staying with you right now", textAlign: TextAlign.center, style: TextStyle(color: buttonFontColor))
                      )
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      )
    );
  }
}