import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static toastMessage(String message) {
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
            forwardAnimationCurve: Curves.decelerate,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.all(15),
            message: message,
            duration: const Duration(seconds: 3),
            borderRadius: BorderRadius.circular(10),
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Color.fromARGB(255, 11, 10, 10),
            reverseAnimationCurve: Curves.easeInOut,
            positionOffset: 20,
            icon: Icon(Icons.error,
                size: 18, color: const Color.fromARGB(255, 237, 7, 7)))
          ..show(context));
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 3, 3, 3),
        content: Text('Message')));
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextNode) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextNode);
  }

  static OutlineInputBorder myinputborder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 237, 231, 231),
          width: 3,
        ));
  }

  static OutlineInputBorder myfocusborder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 8, 8, 8),
          width: 3,
        ));
  }
}
