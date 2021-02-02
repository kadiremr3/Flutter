import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nook/controllers/authController.dart';
import 'package:nook/models/books.dart';
import 'package:nook/services/database.dart';
import 'package:nook/views/listOfBooks.dart';
import 'package:nook/widgets/addingANewBookTextFormField.dart';

class AddingANewBook extends GetWidget<AuthController> {
  final TextEditingController _idController = new TextEditingController();
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _authorController = new TextEditingController();
  final TextEditingController _ratingController = new TextEditingController();
  final TextEditingController _commentsController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[300],
      appBar: AppBar(
        title: Text("Add A New Book"),
        backgroundColor: Colors.deepPurple,
        elevation: 7.0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              bookinformation(
                  "Enter a 'unique' id for your book", 1, _idController),
              SizedBox(height: 25),
              bookinformation("Enter the title:", 1, _titleController),
              SizedBox(height: 25),
              bookinformation(
                  "Enter the name of the author:", 1, _authorController),
              SizedBox(height: 25),
              bookinformation("Give a rating:", 1, _ratingController),
              SizedBox(height: 25),
              bookinformation("Write your comments about the book:", 4,
                  _commentsController),
              SizedBox(
                height: 60,
              ),
              SizedBox(
                width: 200,
                height: 85,
                child: ElevatedButton(
                    onPressed: () {
                      if (_idController.text != "" &&
                          _titleController.text != "" &&
                          _authorController.text != "" &&
                          _ratingController.text != "" &&
                          _commentsController.text != "") {
                        Database().addBooks(
                            _idController.text,
                            _titleController.text,
                            _authorController.text,
                            _ratingController.text,
                            _commentsController.text,
                            controller.user.uid);
                      } else {
                        Get.snackbar("Error",
                            "Please make sure you have filled all the fields",
                            animationDuration: const Duration(seconds: 1),
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.black,
                            icon: Icon(Icons.error));
                      }
                    },
                    child: Text(
                      "ADD",
                      style: TextStyle(fontSize: 23, color: Colors.white54),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                      elevation: 20.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
