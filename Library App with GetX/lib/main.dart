import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nook/controllers/bindings/authBinding.dart';
import 'package:nook/utils/root.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nook/views/addingANewBook.dart';
import 'package:nook/views/bookDetailsPage.dart';
import 'package:nook/views/listOfBooks.dart';
import 'package:nook/views/loginPage.dart';
import 'package:nook/views/signUpPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Nook());
}

class Nook extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: AuthBinding(),
        title: 'Nook',
        home: Root(),
        theme: ThemeData(
            cursorColor: Colors.white70,
            textSelectionColor: Colors.white70,
            textSelectionHandleColor: Colors.white70,
            fixTextFieldOutlineLabel: true),
        getPages: [
          GetPage(
              name: '/',
              page: () => ListOfBooks(),
              transition: Transition.zoom),
          GetPage(
              name: '/Login',
              page: () => Login(),
              transition: Transition.topLevel),
          GetPage(
              name: '/SignUp',
              page: () => SignUp(),
              transition: Transition.rightToLeftWithFade),
          GetPage(
              name: '/BookDetails',
              page: () => BookDetails(),
              transition: Transition.rightToLeft),
          GetPage(
              name: '/AddingANewBook',
              page: () => AddingANewBook(),
              transition: Transition.downToUp)
        ]);
  }
}
