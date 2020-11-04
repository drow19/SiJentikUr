import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjumantik/src/resource.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textFieldStyle(BuildContext context) {
  return GoogleFonts.roboto(
      textStyle: Theme.of(context).textTheme.display1,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black);
}

InputDecoration textFieldDecoration(String hint) {
  return new InputDecoration(
      filled: true,
      fillColor: lightGrey.withOpacity(0.2),
      hintText: hint,
      isDense: true,
      hintStyle: TextStyle(color: darkGrey),
      prefixIcon:
          hint == 'Email' ? Icon(Icons.email) : Icon(Icons.lock_outline),
      suffixIcon: hint == "Email" ? null : Icon(Icons.remove_red_eye),
      border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.transparent)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainGreen, width: 3)));
}

InputDecoration textFieldDecorationUsername(String hint) {
  return new InputDecoration(
      filled: true,
      fillColor: lightGrey.withOpacity(0.2),
      hintText: hint,
      isDense: true,
      hintStyle: TextStyle(color: darkGrey),
      prefixIcon: Icon(Icons.person),
      border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.transparent)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainGreen, width: 3)));
}

Widget snackBar(String message) {
  return SnackBar(
    content: Text(
      '$message',
      style: GoogleFonts.roboto(color: Colors.white),
    ),
    duration: const Duration(seconds: 3),
  );
}

loadingDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("Loading..."),
          content: CupertinoActivityIndicator(
            radius: 15,
          ),
        );
      });
}

Future<bool> backDialog(BuildContext context) {
  return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                content: new Container(
                  height: 100,
                  width: 300,
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: const Color(0xFFFFFF),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(32.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: Text(
                          'Form not saved yet! Are you sure want to back?',
                          style: GoogleFonts.roboto(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () => Navigator.of(context).pop(true),
                            child: Container(
                              height: 30,
                              width: 30,
                              alignment: Alignment.center,
                              child: Text(
                                'Yes',
                                style: GoogleFonts.roboto(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: mainGreen),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context).pop(false),
                            child: Container(
                              height: 30,
                              width: 30,
                              alignment: Alignment.center,
                              child: Text(
                                'No',
                                style: GoogleFonts.roboto(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )) ??
      false;
}
