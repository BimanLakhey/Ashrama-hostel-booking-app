import 'dart:convert';
import 'package:hotel_booking_app/utils/base_url.dart';
import 'package:http/http.dart' as http;

String? loggedUserID;
String? loggedUserAddress;
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

class Rooms{
  final String id, roomType, roomPrice;

  Rooms(
    this.id,
    this.roomType, 
    this.roomPrice, 
  );
}

class SavedHostels{
  final String id, userID, hostelID, hostelName, hostelCity, hostelStreet, hostelType, hostelPhone, hostelPhoto;

  SavedHostels(
    this.id,
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

class BookedHostels{
  final String id, userID, hostelID, roomID, roomType, bookingDate, hostelName, hostelCity, hostelStreet, hostelType, hostelPhone, hostelPhoto;

  BookedHostels(
    this.id,
    this.userID,
    this.hostelID,
    this.roomID,
    this.roomType,
    this.bookingDate,
    this.hostelName,
    this.hostelCity,
    this.hostelStreet,
    this.hostelType,
    this.hostelPhone,
    this.hostelPhoto,
  );
}

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

Future getNearbyHostels() async
{
  var response = await http.get(Uri.parse('${BaseUrl.baseUrl}hostelDetails/?hostelStreet=${loggedUserAddress}'));
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
  var savedResponse = await http.get(Uri.parse('${BaseUrl.baseUrl}savedHostels/?userID=$loggedUserID'), headers: {'Cookie': '${Cookie.cookieSession}'});
  var savedJsonData = json.decode(savedResponse.body);
  List<SavedHostels> savedHostels = [];

  for (var h in savedJsonData)
  {
    var hostelResponse = await http.get(Uri.parse('${BaseUrl.baseUrl}hostelProfile/${h["hostelID"]}'));
    var jsonData = json.decode(hostelResponse.body);
    SavedHostels details = SavedHostels
    (
      h["id"].toString(),
      h["userID"].toString(),
      h["hostelID"] = jsonData["id"].toString(), 
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

Future getBookedHostels() async
{
  var savedResponse = await http.get(Uri.parse('${BaseUrl.baseUrl}bookedHostels/?userID=$loggedUserID'), headers: {'Cookie': '${Cookie.cookieSession}'});
  var savedJsonData = json.decode(savedResponse.body);
  List<BookedHostels> bookedHostels = [];

  for (var h in savedJsonData)
  {
    var hostelResponse = await http.get(Uri.parse('${BaseUrl.baseUrl}hostelProfile/${h["hostelID"]}'));
    var hostelJsonData = json.decode(hostelResponse.body);

    // var roomResponse = await http.get(Uri.parse('${BaseUrl.baseUrl}roomDetails/${h["roomID"]}'));
    // var roomJsonData = json.decode(roomResponse.body);
    BookedHostels details = BookedHostels
    (
      h["id"].toString(),
      h["userID"].toString(),
      h["hostelID"] = hostelJsonData["id"].toString(), 
      h["roomID"], 
      h["roomType"], 
      h["bookingDate"], 
      h["hostelName"] = hostelJsonData["hostelName"], 
      h["hostelCity"] = hostelJsonData["hostelCity"], 
      h["hostelStreet"] = hostelJsonData["hostelStreet"], 
      h["hostelType"] = hostelJsonData["hostelType"], 
      h["hostelPhone"] = hostelJsonData["hostelPhone"], 
      h["hostelPhoto"] = hostelJsonData["hostelPhoto"], 
    ); 
    bookedHostels.add(details);
  }
  return bookedHostels;
}

Future getRooms() async
{
  var roomResponse = await http.get(Uri.parse('${BaseUrl.baseUrl}roomDetails/'), headers: {'Cookie': '${Cookie.cookieSession}'});
  var roomJsonData = json.decode(roomResponse.body);
  List<Rooms> rooms = [];

  for (var h in roomJsonData)
  {
    Rooms details = Rooms
    (
      h["id"].toString(),
      h["roomType"],
      h["roomPrice"]    
    ); 
    rooms.add(details);
  }
  return rooms;
}

  // void getRooms() async
  // {
  //   var response = await http.get(Uri.parse('${BaseUrl.baseUrl}roomDetails/'));
  //   var jsonData = json.decode(response.body);
  //   if(response.statusCode == 200)
  //   {
  //     rID = jsonData["id"].toString();
  //     roomType = jsonData["roomType"];
  //     roomPrice = jsonData["roomType"];
  //   }
  // }
