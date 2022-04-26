// @dart=2.9
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/Model/hostel_model.dart';
import 'package:hotel_booking_app/apis/api.dart';
import 'package:hotel_booking_app/utils/base_url.dart';
import 'package:hotel_booking_app/utils/routes.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';

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

  TextEditingController hostelNameControl = TextEditingController();
  TextEditingController hostelCityControl = TextEditingController();
  TextEditingController hostelStreetControl = TextEditingController();
  TextEditingController hostelTypeControl = TextEditingController();
  TextEditingController hostelPhoneControl = TextEditingController();
  TextEditingController hostelTotalRoomsControl = TextEditingController();

  bool hostelNameNotEmpty = true;
  bool hostelCityNotEmpty = true;
  bool hostelStreetNotEmpty = true;
  bool hostelTypeNotEmpty = true;
  bool hostelTotalRoomsNotEmpty = true;
  bool hostelValid = false;

  void isHostelNameNotEmpty()
  {
    if(hostelNameControl.text.isNotEmpty)
    {
      hostelNameNotEmpty = true;
    }
    else
    {
      hostelNameNotEmpty = false;
    }
  }

  void isHostelCityNotEmpty()
  {
    if(hostelCityControl.text.isNotEmpty)
    {
      hostelCityNotEmpty = true;
    }
    else
    {
      hostelCityNotEmpty = false;
    }
  }

  void isHostelStreetNotEmpty()
  {

    if(hostelStreetControl.text.isNotEmpty)
    {
      hostelStreetNotEmpty = true;
    }
    else
    {
      hostelStreetNotEmpty = false;
    }
  }

  void isHostelTypeNotEmpty()
  {
    if(hostelTypeControl.text.isNotEmpty)
    {
      hostelTypeNotEmpty = true;
    }
    else
    {
      hostelTypeNotEmpty = false;
    }
  }

  void isHostelTotalRoomsNotEmpty()
  {
    if(hostelTotalRoomsControl.text.isNotEmpty)
    {
      hostelTotalRoomsNotEmpty = true;
    }
    else
    {
      hostelTotalRoomsNotEmpty = false;
    }
  }

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
      hostelNameControl.text = jsonData["hostelName"];
      hostelPhoto = jsonData["hostelPhoto"];
      hostelCityControl.text = jsonData["hostelCity"];
      hostelStreetControl.text = jsonData["hostelStreet"];
      hostelPhoneControl.text = jsonData["hostelPhone"];
      hostelTotalRoomsControl.text = jsonData["hostelTotalRooms"];
      hostelTypeControl.text = jsonData["hostelType"];
    }
    on SocketException
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

  void updateHostel() async 
  {
    try
    {
      var registerResponse = await http.put(Uri.parse('${BaseUrl.baseUrl}updateHostel/$hostelID'), body: {'hostelName': hostelNameControl.text, 'hostelCity': hostelCityControl.text, 'hostelStreet': hostelStreetControl.text, 'hostelType':hostelTypeControl.text, 'hostelPhone': hostelPhoneControl.text, 'hostelTotalRooms': hostelTotalRoomsControl.text});
      var registerJsonData = json.decode(registerResponse.body);
      
      if(registerResponse.statusCode == 200)
      {
        setState(() {
          hostelValid = false;
        });
        ScaffoldMessenger.of(context).showSnackBar
        (
          const SnackBar
          (
            content: Text('Profile updated!'),
          )
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

  void confirmDelete()
  {
    showDialog
    (
      context: context,
      builder: (ctx) => AlertDialog
      (
        title: const Text("Delete confirmation"),
        content: const Text("Do you wish to delete the hostel?"),
        actions: <Widget>
        [
          TextButton
          (
            onPressed: () 
            {
              Navigator.pop(context);
            },
            child: Text("cancel"),
          ),
          TextButton
          (
            onPressed: () 
            {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar
              (
                const SnackBar
                (
                  content: Text('Could not delete hostel!'),
                )
              );
            },
            child: Text("ok"),
          ),
        ],
      ),
    );
  }

  void removeHostel(String id) async 
  {
    try
    {
      removeRegisteredHostel(id);
      var response = await http.delete
      (
        Uri.parse('${BaseUrl.baseUrl}hostelDetails/$id'), 
      );
      if(response.statusCode == 204)
      {
        hasRegisteredHostel = false;
      }
      var jsonData = json.decode(response.body);
    }
    catch(e)
    {
      ScaffoldMessenger.of(context).showSnackBar
      (
        const SnackBar
        (
          content: Text('Could not delete hostel!'),
        )
      );
    }

  }

  void removeRegisteredHostel(String id) async 
  {
    var response = await http.delete
    (
      Uri.parse('${BaseUrl.baseUrl}registeredHostels/$id'), 
    );
    if(response.statusCode == 204)
    {
      hasRegisteredHostel = false;
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
                child: const Text("Register hostel", style: TextStyle(color: Colors.white),)
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
                            controller: hostelNameControl,
                            enableInteractiveSelection: false, 
                            decoration: InputDecoration
                            (
                              hintStyle: TextStyle(color: alt? buttonFontColorAlt : buttonFontColor),
                              labelStyle: TextStyle(color: alt ? buttonFontColorAlt : buttonFontColor),
                              hintText: "Enter the hostel name",
                              labelText: "Hostel name",
                              errorText: hostelNameNotEmpty ? null : 'Hostel name cannot be empty!'
                            ),
                          ),
                          const SizedBox
                          (
                            height: 20.0,
                          ),
                          TextFormField
                          (
                            
                            controller: hostelCityControl,
                            enableInteractiveSelection: false, 
                            decoration: InputDecoration
                            (
                              hintStyle: TextStyle(color: alt? buttonFontColorAlt : buttonFontColor),
                              labelStyle: TextStyle(color: alt ? buttonFontColorAlt : buttonFontColor),
                              hintText: "Enter the hostel city",
                              labelText: "Hostel city",
                              errorText: hostelCityNotEmpty ? null : 'Hostel city cannot be empty!'
                            ),
                          ),
                          const SizedBox
                          (
                            height: 20.0,
                          ),
                          TextFormField
                          (
                            controller: hostelStreetControl,
                            enableInteractiveSelection: false, 
                            decoration: InputDecoration
                            (
                              hintStyle: TextStyle(color: alt? buttonFontColorAlt : buttonFontColor),
                              labelStyle: TextStyle(color: alt ? buttonFontColorAlt : buttonFontColor),
                              hintText: "Enter the hostel street",
                              labelText: "Hostel street",
                              errorText: hostelStreetNotEmpty ? null : 'Hostel street cannot be empty!'
                            ),
                          ),
                          const SizedBox
                          (
                            height: 20.0,
                          ),
                          IntlPhoneField
                          (
                            controller: hostelPhoneControl,
                            showCountryFlag: false,
                            decoration: const InputDecoration
                            (
                                labelText: "Phone number",
                                hintText: "Enter your phone number"   
                            ),
                            initialCountryCode: 'NP',
                          ),
                          const SizedBox
                          (
                            height: 20.0,
                          ),
                          TextFormField
                          (
                            cursorColor: Colors.cyan,
                            controller: hostelTypeControl,
                            decoration: InputDecoration
                            (
                              hintStyle: TextStyle(color: alt? buttonFontColorAlt : buttonFontColor),
                              labelStyle: TextStyle(color: alt ? buttonFontColorAlt : buttonFontColor),
                              hintText: "Enter the hostel type",
                              labelText: "Hostel type",
                              enabled:  false
                            ),
                          ),
                          const SizedBox
                          (
                            height: 20.0,
                          ),
                          TextFormField
                          (
                            controller: hostelTotalRoomsControl,
                            decoration: InputDecoration
                            (
                              hintStyle: TextStyle(color: alt? buttonFontColorAlt : buttonFontColor),
                              labelStyle: TextStyle(color: alt ? buttonFontColorAlt : buttonFontColor),
                              hintText: "Enter the total no. rooms",
                              labelText: "Total rooms",
                              errorText: hostelTotalRoomsNotEmpty ? null : 'Total number of rooms cannot be empty!'
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
                            onPressed: hostelValid ? () {} : () 
                            {
                              setState(() 
                              {
                                isHostelNameNotEmpty();
                                isHostelCityNotEmpty();
                                isHostelStreetNotEmpty();
                                isHostelTotalRoomsNotEmpty();
                                isHostelTypeNotEmpty();
                              });
                              if(hostelNameNotEmpty && hostelCityNotEmpty && hostelStreetNotEmpty &&  hostelTotalRoomsNotEmpty && hostelTypeNotEmpty)
                              {
                                setState(() 
                                {
                                  hostelValid = true;
                                });
                                updateHostel();
                              }
                              else
                              {
                                print("empty");
                              }
                            }, 
                            child: hostelValid 
                            ? const SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2, ))
                            : Text
                            (
                              "Save", 
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
                      child: SizedBox
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
                              return Expanded
                              (
                                child: noCurrentlyBooked == true 
                                ? const Text("You don't have any guests staying with you right now", textAlign: TextAlign.center)   
                                : ListView.builder
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
                                            Align
                                            (
                                              alignment: Alignment.centerLeft,
                                              child: Padding
                                              (
                                                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                                child: Text(snapshot.data[i].roomType, style: const TextStyle(color: Colors.white, fontSize: 15)),
                                              ),
                                            ),
                                            Align
                                            (
                                              alignment: Alignment.centerLeft,
                                              child: Padding
                                              (
                                                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                child: Text("Room ID: ${snapshot.data[i].roomID}", style: const TextStyle(color: Colors.white, fontSize: 15)),
                                              ),
                                            ),
                                            Align
                                            (
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                child: Text
                                                (
                                                  "${snapshot.data[i].bookingDate} - ${snapshot.data[i].checkingOutDate}", 
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
                                ),
                              );
                            }
                          }
                        )
                        : Text("You don't have any guests staying with you right now", textAlign: TextAlign.center, style: TextStyle(color: buttonFontColor))
                      )
                    ),
                  ),
                ),
                ElevatedButton
                (
                  onPressed: () 
                  { 
                    setState(() 
                    {
                      confirmDelete();
                    });
                  }, 
                  child: const Text
                  (
                    "Delete hostel",
                    style: TextStyle
                    (
                      color: Colors.white
                    ),
                  ),
                  style: ElevatedButton.styleFrom
                  (
                    primary: Colors.red,
                    minimumSize: const Size(150, 40),
                    side: const BorderSide(width: 2, color: Colors.red),
                  )
                ),
                const SizedBox(height: 25)
              ],
            ),
          ),
        )
      )
    );
  }
}