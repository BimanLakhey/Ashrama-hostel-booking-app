import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:hotel_booking_app/utils/routes.dart';

class ConfirmationPage extends StatefulWidget {
  ConfirmationPage({ Key? key }) : super(key: key);

  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  
  final List _options = ["Send via SMS", "Send via Email"];

  late List<DropdownMenuItem<String>> _dropDownMenuItems;
  late String? _currentOption;
  bool isValid = true;

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
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: const Text("Confirm your number"),
      ),
      body: SingleChildScrollView
      (
        child: Center
        (
          child: Column
          (
            children: 
            [
              Padding
              (
                padding: EdgeInsets.all(40),
                child: _currentOption == "Send via SMS" 
                ? const Text
                (
                  "Enter the code we have sent by SMS to your number", 
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                  textAlign: TextAlign.center
                )
                : const Text
                (
                  "Enter the code we have sent to your email", 
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                  textAlign: TextAlign.center
                )
              ),
              OtpTextField
              (
                numberOfFields: 6,
                borderColor: Color(0xFF00BCD4),
                showFieldAsBox: true,
                focusedBorderColor: Colors.cyan,
                textStyle: TextStyle(fontSize: 13),
                onSubmit: (String loginRoute)
                {
                  loginRoute = MyRoutes.signinRoute;
                  Navigator.pushNamed(context, loginRoute);
                },
              ),
              Padding
              (
                padding: const EdgeInsets.fromLTRB(20,40,0,0),
                child: Row
                (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: 
                  [
                    const Text
                    (
                      "Haven't received a code yet?",
                    ),
                    TextButton
                    (
                      onPressed: () => Navigator.pushNamed(context, MyRoutes.loginRoute),
                      child: const Text
                      (
                        "Send again",
                        style: TextStyle
                        (
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),
                      )
                    )
                  ]               
                ),
              ),
              DropdownButton
              (
                value: _currentOption,
                items: _dropDownMenuItems, 
                onChanged: changedDropDownItem
              )
            ],
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

