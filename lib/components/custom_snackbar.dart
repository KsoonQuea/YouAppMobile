import 'package:flutter/material.dart';
// import 'package:flushbar/flushbar.dart';
// import 'package:flushbar/flushbar_helper.dart';
import 'dart:developer' as developer;

class CustomSnackbar {
  void showSuccessMessage(String text, context) {
    final screen_height       = MediaQuery.of(context).size.height;
    final keyboard_height     = MediaQuery.of(context).viewInsets.bottom;
    final top_space           = keyboard_height == 0 ? 150 : 90;

    final snackBar = SnackBar(
      content: Text(text, textAlign: TextAlign.center),
      backgroundColor: Colors.green[500],
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2), // Show for 2 seconds
      // size.height, viewInsets.bottom
      margin: EdgeInsets.only(
        bottom: screen_height - keyboard_height - top_space, 
        left: 20, 
        right: 20
      ),
      // elevation: 100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showFailMessage(String text, context) {
    final screen_height       = MediaQuery.of(context).size.height;
    final keyboard_height     = MediaQuery.of(context).viewInsets.bottom;
    final top_space           = keyboard_height == 0 ? 150 : 90;

    final snackBar = SnackBar(
      content: Text(text, textAlign: TextAlign.center),
      backgroundColor: Colors.red[400],
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2), // Show for 2 seconds
      // size.height, viewInsets.bottom
      margin: EdgeInsets.only(
        bottom: screen_height - keyboard_height - top_space, 
        left: 20, 
        right: 20
      ),
      // elevation: 100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}