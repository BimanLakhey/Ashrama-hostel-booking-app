import 'dart:convert';
import 'package:hotel_booking_app/pages/hostel_profile_page.dart';
import 'package:hotel_booking_app/pages/manage_hostel_page.dart';
import 'package:hotel_booking_app/utils/base_url.dart';
import 'package:http/http.dart' as http;

String? loggedUserID;
String? loggedUserCity;
String? loggedUserStreet;
String? loggedUserEmail;
String? loggedUserFName;
String? loggedUserLName;
bool loginValid = false;
bool userSignedUp = false;
bool hasRegisteredHostel = false;
bool noBookings = false;
bool noSaved = false;
bool noCurrentlyBooked = false;
bool noReviews = false;
bool noNotifications = false;
List<Hostels> hostels = [];
List<Reviews> reviews = [];
List<Notifications> notifications = [];

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

class BookingDetails{
  final String id, userID, hostelID, roomID, roomType, bookingDate, checkingOutDate, userFName, userLName, userCity, userStreet, userPhone, userPhoto, userEmail;

  BookingDetails(
    this.id,
    this.userID,
    this.hostelID,
    this.roomID,
    this.roomType,
    this.bookingDate,
    this.checkingOutDate,
    this.userFName,
    this.userLName,
    this.userCity,
    this.userStreet,
    this.userPhone,
    this.userPhoto,
    this.userEmail,
  );
}

class Reviews 
{
  final String id, userID, userFName, userLName, hostelID, rating, review, reviewDate;

  Reviews
  (
    this.id, 
    this.userID, 
    this.userFName,
    this.userLName,
    this.hostelID, 
    this.rating, 
    this.review, 
    this.reviewDate
  );
}

class Notifications
{
  final String userID, hostelID, hostelName, roomType, notificationMessage, notificationDate;

  Notifications
  (
    this.userID,
    this.hostelID,
    this.hostelName,
    this.roomType,
    this.notificationMessage,
    this.notificationDate
  );
}

Future getHostels() async
{
  try
  {
    var response = await http.get(Uri.parse('${BaseUrl.baseUrl}hostelDetails/'));
    var jsonData = json.decode(response.body);

    hostels = [];
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
  catch(e)
  {
    print("no internet");
  }  
}

Future getNearbyHostels() async
{
  try
  {
    var response = await http.get(Uri.parse('${BaseUrl.baseUrl}hostelDetails/?hostelCity=${loggedUserCity!.toLowerCase()}'));
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
  catch(e)
  {
    print("no internet");
  }
}

Future getSavedHostels() async
{
  try
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
    if(savedHostels.isEmpty)
    {
      noSaved = true;
    }
    else
    {
      noSaved = false;
    }
    return savedHostels;
  }
  
  catch(e)
  {
    print("no internet");
  }
}

Future getBookedHostels() async
{
  try
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
    if(bookedHostels.isEmpty)
    {
      noBookings = true;
    }
    else
    {
      noBookings = false;
    }
    return bookedHostels;
  }
  catch(e)
  {
    print("no internet");
  }
}

Future getRooms() async
{
  try
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
  catch(e)
  {
    print("no internet");
  }
}

Future getBookingDetails() async
{
  try
  {
    var registeredResponse = await http.get(Uri.parse('${BaseUrl.baseUrl}registeredHostels/'), headers: {'Cookie': '${Cookie.cookieSession}'});
    var registeredJsonData = json.decode(registeredResponse.body);

    for (var registeredHostel in registeredJsonData)
    {
      if(registeredHostel["userID"] == loggedUserID)
      {
        hasRegisteredHostel = true;
        ManageHostelPage.hostelID = registeredHostel["hostelID"];
        var bookingResponse = await http.get(Uri.parse('${BaseUrl.baseUrl}bookedHostels/?hostelID=${registeredHostel["hostelID"]}'), headers: {'Cookie': '${Cookie.cookieSession}'});
        var bookingJsonData = json.decode(bookingResponse.body);

        var userResponse = await http.get(Uri.parse('${BaseUrl.baseUrl}userDetails/?id=${registeredHostel["userID"]}'), headers: {'Cookie': '${Cookie.cookieSession}'});
        var userJsonData = json.decode(userResponse.body);
        List<BookingDetails> bookingDetails = [];

        for (var h in bookingJsonData)
        {
          for(var u in userJsonData)
          {
            BookingDetails details = BookingDetails
            (
              h["id"].toString(),
              h["userID"].toString(),
              h["hostelID"], 
              h["roomID"],
              h["roomType"], 
              h["bookingDate"], 
              h["checkingOutDate"], 
              h["userFName"] = u["userFName"], 
              h["userLName"] = u["userLName"], 
              h["userCity"] = u["userCity"], 
              h["userStreet"] = u["userStreet"], 
              h["userPhone"] = u["userPhone"],  
              h["userPhoto"] = u["userPhoto"], 
              h["userEmail"] = u["userEmail"],  
            ); 
            bookingDetails.add(details);
          }
        } 
        if(bookingDetails.isEmpty)
        {
          noCurrentlyBooked = true;
        }
        else
        {
          noCurrentlyBooked = false;
        }
        return bookingDetails;
      }
      else
      {
        hasRegisteredHostel = false;
      }
    }
  }
  catch(e)
  {
    print("no internet");
  }
}

Future getHostelReviews() async
{
  try
  {
    var reviewResponse = await http.get(Uri.parse('${BaseUrl.baseUrl}userReviews/?hostelID=${HostelProfilePage.hostelID}'), headers: {'Cookie': '${Cookie.cookieSession}'});
    var reviewJsonData = json.decode(reviewResponse.body);
    reviews = [];

    for (var r in reviewJsonData)
    {
      var userResponse = await http.get(Uri.parse('${BaseUrl.baseUrl}userDetails/?id=${r["userID"]}'), headers: {'Cookie': '${Cookie.cookieSession}'});
      var userJsonData = json.decode(userResponse.body);
      for(var u in userJsonData)
      {
        Reviews userReviews = Reviews
        (
          r["id"].toString(),
          r["userID"],
          r["userFName"] = u["userFName"], 
          r["userLName"] = u["userLName"],  
          r["hostelID"],    
          r["rating"],    
          r["review"],    
          r["reviewDate"],   

        ); 
        reviews.add(userReviews);
      }
    }
    if(reviews.isEmpty)
    {
      noReviews = true;
    }
    else
    {
      noReviews = false;
    }
    return reviews;
  }
  catch(e)
  {
    print("no internet");
  }
}

Future getUserNotifications() async
{
  try
  {
    var notificationResponse = await http.get(Uri.parse('${BaseUrl.baseUrl}userNotifications/?userID=$loggedUserID'), headers: {'Cookie': '${Cookie.cookieSession}'});
    var notificationJsonData = json.decode(notificationResponse.body);

    notifications = [];

    for (var n in notificationJsonData)
    {
      var hostelResponse = await http.get(Uri.parse('${BaseUrl.baseUrl}hostelProfile/${n["hostelID"]}'));
      var hostelJsonData = json.decode(hostelResponse.body);

      Notifications userNotifications = Notifications
      (
        n["userID"],
        n["hostelID"],
        n["hostelName"] = hostelJsonData["hostelName"],
        n["roomType"] = hostelJsonData["roomType"],
        n["notificationMessage"], 
        n["notificationDate"],  

      ); 
      notifications.add(userNotifications);
    }
    if(notifications.isEmpty)
    {
      noNotifications = true;
    }
    else
    {
      noNotifications = false;
    }
    return notifications;
  }
    
  catch(e)
  {
    print("no internet");
  }
}

