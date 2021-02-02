import 'package:flutter/material.dart';

Widget loginOrSignUpTextFormField(
    String _hintText,
    Widget _prefixIcon,
    bool _obscureText,
    TextEditingController _controller,
    TextInputType _textInputType) {
  return TextFormField(
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          hintText: "$_hintText",
          prefixIcon: _prefixIcon,
          enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color: Colors.white,
              )),
          focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color: Colors.white,
              ))),
      keyboardType: _textInputType,
      obscureText: _obscureText,
      controller: _controller);
}
