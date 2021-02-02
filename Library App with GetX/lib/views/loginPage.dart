import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nook/controllers/authController.dart';
import 'package:nook/controllers/book_controller.dart';
import 'package:nook/views/listOfBooks.dart';
import 'package:nook/views/signUpPage.dart';
import 'package:nook/widgets/loginOrSignUpPageTextFormFields.dart';

class Login extends GetWidget<AuthController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/candleBook.gif"), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 135.0, 50.0, 50.0),
          child: Column(
            children: <Widget>[
              Text(
                "Login or Create an Account",
                textAlign: TextAlign.center,
                style: TextStyle(
                    letterSpacing: 1.4,
                    wordSpacing: 1.4,
                    color: Colors.brown[300],
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 40.0),
              loginOrSignUpTextFormField(
                  "E-mail",
                  Icon(Icons.person, color: Colors.black),
                  false,
                  emailController,
                  TextInputType.emailAddress),
              SizedBox(height: 40.0),
              loginOrSignUpTextFormField(
                  "Password",
                  Icon(Icons.vpn_key, color: Colors.black),
                  true,
                  passwordController,
                  TextInputType.visiblePassword),
              SizedBox(height: 30.0),
              SizedBox(
                width: 150.0,
                height: 45.0,
                child: RaisedButton(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.amber[600],
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0),
                  ),
                  color: Colors.brown[700],
                  elevation: 30.0,
                  textColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.brown[300])),
                  onPressed: () {
                    controller.login(
                        emailController.text, passwordController.text);
                  },
                ),
              ),
              TextButton(
                child: Text("Doesn't have an account? Tap to Sign in!",
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Get.toNamed("/SignUp");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
