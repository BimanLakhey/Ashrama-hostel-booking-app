import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetPage extends StatelessWidget {
  const ResetPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
      (
        leading: IconButton
        (
          icon: const Icon(CupertinoIcons.arrow_left),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Reset password"),
        centerTitle: true,
        foregroundColor: Colors.white
      ),
    );
  }
}