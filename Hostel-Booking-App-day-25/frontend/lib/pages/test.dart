// // @dart = 2.9
// import 'package:flutter/material.dart';
// import 'package:hotel_booking_app/apis/api.dart';

// class TestPage extends StatelessWidget {
//   const TestPage({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Container(
//         child:  Card
//         (
//           child: FutureBuilder(
//             future: getUserData(),
//                         builder: (context, snapshot) {
//                           if(snapshot.data == null)
//                           {
//                             return Container(child: Text("loading..."));
//                           }
//                           else
//                           {
//                             return Padding(
//                               padding: EdgeInsets.all(25),
//                               child: ListView.builder(
//                                 itemCount: snapshot.data.length,
//                                 itemBuilder: (context, i)
//                                 {
//                                   return SingleChildScrollView
//                                   (
//                                     child: Column
//                                     (
//                                       children: [
//                                           Container(
//                                             margin: EdgeInsets.all(15),
//                                             padding: EdgeInsets.all(25),
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(15),
//                                               color: Colors.cyan
//                                             ),
                                            
//                                             child: Column(
//                                               children: [
//                                                 Text(snapshot.data[i].hostelTotalRooms, style: TextStyle(color: Colors.white)),
//                                                 Text(snapshot.data[i].hostelName, style: TextStyle(color: Colors.white)),
//                                                 Text(snapshot.data[i].hostelCity, style: TextStyle(color: Colors.white)),
//                                                 Text(snapshot.data[i].hostelStreet, style: TextStyle(color: Colors.white)),
//                                                 Text(snapshot.data[i].hostelType, style: TextStyle(color: Colors.white)),
//                                                 Text(snapshot.data[i].hostelPhone, style: TextStyle(color: Colors.white)),
//                                               ]),
//                                           ),
                                      
//                                       ],
//                                     )
//                                   );
//                                 }
//                               ),
//                             );
//                           }
//                         } ,
//                       ),
//                     ),
//       ),
//     );
//   }
// }

