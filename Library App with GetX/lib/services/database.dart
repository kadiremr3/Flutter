import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nook/models/books.dart';
import 'package:nook/models/user.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore
          .collection("users")
          .doc(user.id)
          .set({"name": user.name, "email": user.email});
      return true;
    } catch (e) {
      print(e);
      Get.snackbar(
        "Error on creating the account",
        e.message,
        animationDuration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.black,
        icon: Icon(
          Icons.error,
        ),
      );

      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection("users").doc(uid).get();
      return UserModel.fromDocumentSnapshot(doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addBooks(String id, String title, String author, String rating,
      String comments, String uid) async {
    try {
      await _firestore.collection("users").doc(uid).collection("Books").add({
        'id': id,
        'title': title,
        'author': author,
        'rating': rating,
        'comments': comments
      });
      Get.snackbar(
        "Congratulations",
        "You have succesfully added a new book",
        animationDuration: const Duration(seconds: 1),
        snackPosition: SnackPosition.TOP,
        icon: Icon(
          Icons.done,
          color: Colors.green,
        ),
      );
      new Future.delayed(const Duration(seconds: 2), () {
        Get.offAllNamed("/");
      });
    } catch (e) {}
  }

  Stream<List<Books>> bookStream(String uid) {
    return _firestore
        .collection("users")
        .doc(uid)
        .collection("Books")
        .orderBy("id", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Books> returnVal = [];
      query.docs.forEach((element) {
        returnVal.add(Books.fromDocumentSnapshot(element));
      });
      return returnVal;
    });
  }

  Future<void> update(
      String uid, String indexId, String field, String newValue) async {
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection("Books")
          .where("id", isEqualTo: "$indexId")
          .get()
          .then((value) => value.docs.forEach((element) {
                _firestore
                    .collection("users")
                    .doc(uid)
                    .collection("Books")
                    .doc(element.id)
                    .update({"$field": newValue});
              }));
      Get.snackbar(
        "Congratulations",
        "Update is successfull",
        snackPosition: SnackPosition.TOP,
        animationDuration: const Duration(seconds: 1),
        icon: Icon(
          Icons.done,
          color: Colors.green,
        ),
      );
    } catch (e) {
      print(e);
      Get.snackbar(
        "Error on updating the field",
        e.message,
        animationDuration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.black,
        icon: Icon(
          Icons.error,
        ),
      );
      rethrow;
    }
  }

  Future<void> deleteBook(String uid, String id) async {
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection("Books")
          .where("id", isEqualTo: "$id")
          .get()
          .then((value) => value.docs.forEach((element) {
                _firestore
                    .collection("users")
                    .doc(uid)
                    .collection("Books")
                    .doc(element.id)
                    .delete();
              }));
      Get.snackbar(
        "Congratulations",
        "You have successfully deleted the book",
        snackPosition: SnackPosition.TOP,
        animationDuration: const Duration(seconds: 1),
        icon: Icon(
          Icons.done,
          color: Colors.green,
        ),
      );
    } catch (e) {
      print(e);
      Get.snackbar(
        "Error on deleting the book",
        e.message,
        animationDuration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.amber,
        icon: Icon(
          Icons.error,
        ),
      );
      rethrow;
    }
  }
}
