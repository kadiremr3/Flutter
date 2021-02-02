import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nook/controllers/authController.dart';
import 'package:nook/views/loginPage.dart';
import 'package:nook/widgets/loginOrSignUpPageTextFormFields.dart';

class SignUp extends GetWidget<AuthController> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/candleBook.gif"),
                  fit: BoxFit.cover)),
          child: Column(
            children: <Widget>[
              SizedBox(height: 100.0),
              Text(
                "Create an Account",
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
                  "Your Name",
                  Icon(Icons.person_rounded, color: Colors.black54),
                  false,
                  nameController,
                  TextInputType.name),
              SizedBox(height: 40.0),
              loginOrSignUpTextFormField(
                  "E-mail",
                  Icon(Icons.person, color: Colors.black54),
                  false,
                  emailController,
                  TextInputType.emailAddress),
              SizedBox(height: 40.0),
              loginOrSignUpTextFormField(
                  "Password",
                  Icon(Icons.vpn_key, color: Colors.black54),
                  true,
                  passwordController,
                  TextInputType.visiblePassword),
              SizedBox(height: 30.0),
              SizedBox(
                width: 150.0,
                height: 45.0,
                child: RaisedButton(
                  child: Text(
                    "Sign Up",
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
                    controller.createUser(nameController.text,
                        emailController.text, passwordController.text);
                    Get.offAll(Login());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Scaffold(
    //     appBar: AppBar(title: Text("Login Screen")),
    //     body: Center(
    //       child: Container(
    //         child: Column(
    //           children: <Widget>[
    //             TextFormField(
    //               controller: nameController,
    //             ),
    //             TextFormField(
    //               keyboardType: TextInputType.emailAddress,
    //               controller: emailController,
    //             ),
    //             TextFormField(
    //               obscureText: true,
    //               controller: passwordController,
    //             ),
    //             RaisedButton(
    //               onPressed: () {
    //                 controller.createUser(nameController.text,
    //                     emailController.text, passwordController.text);
    //                 Get.offAll(Login());
    //               },
    //               child: Text("SignUp"),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ));
  }
}
