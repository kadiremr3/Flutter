import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nook/controllers/authController.dart';
import 'package:nook/controllers/book_controller.dart';
import 'package:nook/controllers/userController.dart';
import 'package:nook/services/database.dart';
import 'package:nook/views/listOfBooks.dart';

class BookDetails extends GetWidget<BookController> {
  List dataFromListOfBooks = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      appBar: AppBar(
        backgroundColor: Colors.amber[300],
        title: Text(
          "Information",
          style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2),
        ),
        centerTitle: true,
        elevation: 15,
        actions: <Widget>[
          IconButton(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => new AlertDialog(
                          title: Text("WARNING!",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.3,
                              ),
                              textAlign: TextAlign.center),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "This book is going to be deleted from your library",
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  RaisedButton(
                                      color: Colors.red,
                                      onPressed: () {
                                        Database().deleteBook(
                                            Get.find<AuthController>().user.uid,
                                            dataFromListOfBooks[0]);
                                        Future.delayed(Duration(seconds: 1),
                                            () {
                                          Get.offAllNamed("/");
                                        });
                                      },
                                      child: Text("Delete",
                                          style:
                                              TextStyle(color: Colors.white))),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancel",
                                          style: TextStyle(
                                              color: Colors.blueGrey)))
                                ],
                              )
                            ],
                          ),
                          elevation: 10.0,
                          backgroundColor: Colors.yellow[50],
                        ));
              })
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30.0),
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 40.0),
              Row(
                children: <Widget>[
                  bookDetail("Id: ", 0),
                ],
              ),
              SizedBox(height: 25.0),
              Row(
                children: <Widget>[
                  bookDetail("Name: ", 1),
                ],
              ),
              SizedBox(height: 25.0),
              Row(
                children: <Widget>[
                  bookDetail("Author: ", 2),
                ],
              ),
              SizedBox(height: 25.0),
              Row(
                children: <Widget>[
                  bookDetail("Rating: ", 3),
                ],
              ),
              SizedBox(height: 80.0),
              Text(
                "Comments: ",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.4,
                ),
              ),
              Divider(
                color: Colors.black45,
                height: 15,
                indent: 0,
                endIndent: 15,
              ),
              Center(
                child: Text(dataFromListOfBooks[4],
                    style: TextStyle(
                      color: Colors.yellow[200],
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bookDetail(String propertyName, int index) {
    int bookParameterIndex = index;

    return Row(
      children: [
        Text(
          "$propertyName ",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 25.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.4,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: 220,
            child: Text("${dataFromListOfBooks[bookParameterIndex]}",
                style: TextStyle(
                  color: Colors.amber[200],
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold,
                )),
          ),
        )
      ],
    );
  }
}
