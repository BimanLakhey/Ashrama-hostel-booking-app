import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/routes.dart';

class HostelDetailsPage extends StatefulWidget {
  const HostelDetailsPage({ Key? key }) : super(key: key);

  @override
  State<HostelDetailsPage> createState() => _HostelDetailsPageState();
}

class _HostelDetailsPageState extends State<HostelDetailsPage> 
{
  final List _options = ["Hostel type", "Unisex", "Girls only", "Boys only"];

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
    return Scaffold(
      appBar: AppBar
      (
        title: Text("Hostel Details")
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
                          
                          hintText: "Enter the hostel name",
                          labelText: "Hostel name"
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
                          hintText: "Enter the city name",
                          labelText: "Hostel city",
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
                          hintText: "Enter the hostel street",
                          labelText: "Hostel street",
                        ),
                        obscureText: true,
                      ),
                      const SizedBox
                      (
                        height: 20.0,
                      ),
                      DropdownButton
                      (
                        value: _currentOption,
                        items: _dropDownMenuItems, 
                        onChanged: changedDropDownItem
                      ),
                      Padding
                      (
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Divider(color: Colors.black12, thickness: 1),
                      ),
                      Padding
                      (
                        padding: const EdgeInsets.fromLTRB(0,0,175,0),
                        child: Text
                        (
                          "Amenities",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      TextFormField
                      (
                        decoration: const InputDecoration
                        (
                          hintText: "Enter an amenity",
                          labelText: "Hostel amenity",
                        ),
                        obscureText: true,
                      ),
                      const SizedBox
                      (
                        height: 40.0,
                      ),
                      ElevatedButton.icon
                      (
                        onPressed: () 
                        {
                          Navigator.pushNamed(context, MyRoutes.hostelOwnerDetailsRoute);
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
                padding: const EdgeInsets.fromLTRB(15,50,0,0),
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
                        Navigator.pushNamed(context, MyRoutes.hostelOwnerDetailsRoute);
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
}