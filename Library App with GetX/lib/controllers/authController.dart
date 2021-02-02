import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nook/controllers/userController.dart';
import 'package:nook/models/user.dart';
import 'package:nook/services/database.dart';

import 'userController.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> _firebaseUser = Rx<User>();

  User get user => _firebaseUser.value;

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  void createUser(String name, String email, String password) async {
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      UserModel _user =
          UserModel(id: _authResult.user.uid, name: name, email: email);
      if (await Database().createNewUser(_user)) {
        Get.find<UserController>().user = _user;
        Get.back();
      }
    } catch (e) {
      Get.snackbar("Error creating an account", e.message,
          animationDuration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.black,
          icon: Icon(Icons.error));
      Future.delayed(Duration(seconds: 2), () {
        Get.offAllNamed("/SignUp");
      });
    }
  }

  void login(String email, String password) async {
    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      Get.find<UserController>().user =
          await Database().getUser(_authResult.user.uid);
      Get.offAllNamed('/');
    } catch (e) {
      Get.snackbar("Error logging in", e.message,
          animationDuration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.black,
          icon: Icon(Icons.error));
      Future.delayed(Duration(seconds: 2), () {
        Get.offAllNamed("/Login");
      });
    }
  }

  void signOut() {
    try {
      Get.find<UserController>().clear();
      _auth.signOut();
      Get.offAllNamed("/Login");
    } catch (e) {
      Get.snackbar("Error signing out", e.message,
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          colorText: Colors.black,
          icon: Icon(Icons.error));
    }
  }
}
