import 'package:flutter/material.dart';

Widget bookinformation(
    String textFieldValue, int maxLines, TextEditingController controllerName) {
  return TextFormField(
    maxLines: maxLines,
    style: TextStyle(color: Colors.white),
    controller: controllerName,
    decoration: InputDecoration(
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            gapPadding: 4.0,
            borderSide: BorderSide(
              color: Colors.white60,
            )),
        labelText: "$textFieldValue",
        labelStyle: TextStyle(color: Colors.white38),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            gapPadding: 4.0,
            borderSide: BorderSide(
              color: Colors.white54,
            ))),
  );
}
