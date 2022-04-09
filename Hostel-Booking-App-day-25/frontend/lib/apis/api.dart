import 'dart:convert';
import 'package:hotel_booking_app/utils/base_url.dart';
import 'package:http/http.dart' as http;

String? loggedUserID;
bool loginValid = false;
bool userSignedUp = false;

class Hostels{
  final String id, hostelName, hostelCity, hostelStreet, hostelType, hostelPhone, hostelTotalRooms, hostelPhoto;

  Hostels(
    this.id,
    this.hostelName, 
    this.hostelCity, 
    this.hostelStreet,
    this.hostelType,
    this.hostelPhone,
    this.hostelTotalRooms,
    this.hostelPhoto,
  );
}

class SavedHostels{
  final String userID, hostelID, hostelName, hostelCity, hostelStreet, hostelType, hostelPhone, hostelPhoto;

  SavedHostels(
    this.userID,
    this.hostelID,
    this.hostelName,
    this.hostelCity,
    this.hostelStreet,
    this.hostelType,
    this.hostelPhone,
    this.hostelPhoto,
  );
}

// class HostelDetails{
//   final String id, hostelName, hostelCity, hostelStreet, hostelType, hostelPhone, hostelTotalRooms, hostelPhoto;

//   HostelDetails(
//     this.id,
//     this.hostelName, 
//     this.hostelCity, 
//     this.hostelStreet,
//     this.hostelType,
//     this.hostelPhone,
//     this.hostelTotalRooms,
//     this.hostelPhoto,
//   );
// }

//getting data of all the hostels

Future getHostels() async
{
  var response = await http.get(Uri.parse('${BaseUrl.baseUrl}hostelDetails/'));
  var jsonData = json.decode(response.body);
  List<Hostels> hostels = [];

  for (var h in jsonData)
  {
    Hostels details = Hostels(
      h["id"].toString(),
      h["hostelName"], 
      h["hostelCity"], 
      h["hostelStreet"],
      h["hostelType"],
      h["hostelPhone"],
      h["hostelTotalRooms"],
      h["hostelPhoto"],
    ); 
    hostels.add(details);
  }
  return hostels;
}

Future getSavedHostels() async
{
  var savedResponse = await http.get(Uri.parse('${BaseUrl.baseUrl}savedHostels/?userID_id=$loggedUserID'), headers: {'Cookie': '${Cookie.cookieSession}'});
  var savedJsonData = json.decode(savedResponse.body);
  List<SavedHostels> savedHostels = [];

  for (var h in savedJsonData)
  {
    var hostelResponse = await http.get(Uri.parse('${BaseUrl.baseUrl}hostelProfile/${h["hostelID_id"]}'));
    var jsonData = json.decode(hostelResponse.body);
    SavedHostels details = SavedHostels
    (
      h["userID_id"].toString(),
      h["hostelID_id"] = jsonData["id"].toString(), 
      h["hostelName"] = jsonData["hostelName"], 
      h["hostelCity"] = jsonData["hostelCity"], 
      h["hostelStreet"] = jsonData["hostelStreet"], 
      h["hostelType"] = jsonData["hostelType"], 
      h["hostelPhone"] = jsonData["hostelPhone"], 
      h["hostelPhoto"] = jsonData["hostelPhoto"], 
    ); 
    savedHostels.add(details);
  }
  return savedHostels;
}

//getting data of a particular hostel
// Future getHostelData() async
// {
//   String hostelID = '1';
//   var response = await http.get(Uri.parse('${BaseUrl.baseUrl}/hostelProfile/1'));
//   var jsonData = json.decode(response.body);
//   List<HostelDetails> hostelDetails = [];
//   for (int i = 0; i <= jsonData.length; i++)
//   {
//     HostelDetails details = HostelDetails(
//       jsonData[i].id,
//       jsonData[i].hostelName,
//       jsonData[i].hostelCity,
//       jsonData[i].hostelStreet,
//       jsonData[i].hostelType,
//       jsonData[i].hostelPhone,
//       jsonData[i].hostelTotalRooms,
//       jsonData[i].hostelPhoto,
//     ); 
    
//     print(jsonData[i].id);
//     hostelDetails.add(details);
//   }
//   return hostelDetails;
// }


//  void login(String username , userPassword) async {
//     try{
      
//       final response = await http.post(
//         Uri.parse('$baseUrl/loginUser/'),
//         body: {
//           'username' : username,
//           'userPassword' : userPassword
//         }
//       );

//       var data = json.decode(response.body) as Map <String, dynamic>;
//       if(response.statusCode == 200){
    
//         loginValid = true;
//         print(data);
//       }
//       else {
//         loginValid = false;
//       }
//     }catch(e){
//       print("hello!");
//       print(e.);
//     }
//   }// For login


void signup(String username, String userFName , String userLName, String userEmail, String userPassword, String userAddress, String userPhone, String totalHostels, String ownerLicense) async {
    try{
      
      final response = await http.post(
        Uri.parse('${BaseUrl.baseUrl}/registerUser/'),
        body: {
          'username': username,
          'userFName' : userFName,
          'userLName' : userLName,
          'userEmail' : userEmail,
          'userPassword' : userPassword,
          'userPhone' : userPhone,
          'userAddress' : userAddress,
          'totalHostels' : totalHostels,
          'ownerLicense' : ownerLicense,
        }
      );
      if(response.statusCode == 200)
      {
        userSignedUp = true;
      }
      else
      {
        print(response.statusCode);
        userSignedUp = false;
      }
    }catch(e){
      print("failed!");
    }
  }// For Register