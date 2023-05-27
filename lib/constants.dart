import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Color(0xFF393E46),
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Color(0xFFEEEEEE),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32.0), bottomLeft: Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF00ADB5), width: 1.0),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32.0), bottomLeft: Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF00ADB5), width: 2.0),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32.0), bottomLeft: Radius.circular(32.0)),
  ),
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'hint decoration',
  hintStyle: TextStyle(color: Color.fromARGB(255, 13, 74, 71)),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF393E46), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF222831), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
