import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nook/controllers/authController.dart';
import 'package:nook/controllers/book_controller.dart';
import 'package:nook/services/database.dart';
import 'package:nook/views/loginPage.dart';

class ListOfBooks extends GetWidget<AuthController> {
  //StatefulBuilder builder(context, setState) => setState(() => { isLogin =true})

  final TextEditingController updateWindowController = TextEditingController();
  List<String> sentBook = List<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Library",
            style: TextStyle(
                fontSize: 23,
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2)),
        elevation: 7.0,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white70,
              ),
              onPressed: () {
                Get.delete<BookController>();
                controller.signOut();
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.amber[200],
            Colors.purple[400],
          ],
        )),
        child: GetX<BookController>(
          init: Get.put<BookController>(BookController()),
          builder: (BookController bookController) {
            if (bookController != null && bookController.books != null) {
              return ListView.builder(
                  itemCount: bookController.books.length,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.chrome_reader_mode),
                          trailing: Text(bookController.books[index].rating),
                          title: Text(bookController.books[index].title),
                          subtitle: Text(bookController.books[index].author),
                          onTap: () async {
                            String indexId = bookController.books[index].id;
                            String indexTitle =
                                bookController.books[index].title;
                            String indexAuthor =
                                bookController.books[index].author;
                            String indexRating =
                                bookController.books[index].rating;
                            String indexComments =
                                bookController.books[index].comments;
                            sentBook = [
                              indexId,
                              indexTitle,
                              indexAuthor,
                              indexRating,
                              indexComments
                            ];
                            Get.toNamed('/BookDetails',
                                arguments: sentBook, preventDuplicates: true);
                          },
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (_) => new AlertDialog(
                                      title: new Text("Update the Book",
                                          textAlign: TextAlign.center),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Obx(() => DropdownButton(
                                                dropdownColor: Colors.lime[100],
                                                hint: Text(
                                                    "${bookController.dropDownHintText}"),
                                                items: [
                                                  DropdownMenuItem(
                                                    onTap: () {
                                                      bookController
                                                          .dropDownHintText
                                                          .value = "Title";
                                                      bookController.fieldValue
                                                          .value = "title";
                                                    },
                                                    value:
                                                        "${bookController.books[index].title}",
                                                    child: Text(
                                                      "Title",
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    onTap: () {
                                                      bookController
                                                          .dropDownHintText
                                                          .value = "Author";
                                                      bookController.fieldValue
                                                          .value = "author";
                                                    },
                                                    value:
                                                        "${bookController.books[index].author}",
                                                    child: Text(
                                                      "Author",
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    onTap: () {
                                                      bookController
                                                          .dropDownHintText
                                                          .value = "Rating";
                                                      bookController.fieldValue
                                                          .value = "rating";
                                                    },
                                                    value:
                                                        "${bookController.books[index].rating}",
                                                    child: Text(
                                                      "Rating",
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    onTap: () {
                                                      bookController
                                                          .dropDownHintText
                                                          .value = "Comments";
                                                      bookController.fieldValue
                                                          .value = "comments";
                                                    },
                                                    value:
                                                        "${bookController.books[index].comments}",
                                                    child: Text("Comment"),
                                                  ),
                                                ],
                                                onChanged: (value) {},
                                              )),
                                          TextField(
                                            controller: updateWindowController,
                                            textAlign: TextAlign.center,
                                            cursorColor: Colors.black,
                                            decoration: InputDecoration(
                                              hintText:
                                                  "Please write your new entry",
                                              hintStyle: TextStyle(
                                                fontSize: 14,
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.0,
                                          ),
                                          Container(
                                            height: 50,
                                            width: 120,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.purple,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                              onPressed: () {
                                                if (updateWindowController
                                                        .text !=
                                                    "") {
                                                  Database().update(
                                                      "${controller.user.uid}",
                                                      "${bookController.books[index].id}",
                                                      "${bookController.fieldValue.value}",
                                                      "${updateWindowController.text}");
                                                  updateWindowController
                                                      .clear();
                                                  bookController
                                                      .dropDownHintText
                                                      .value = "Choose a field";
                                                } else {
                                                  Get.snackbar("Error",
                                                      "Please make sure you have entered a value",
                                                      backgroundColor:
                                                          Colors.red,
                                                      colorText: Colors.black,
                                                      animationDuration:
                                                          Duration(seconds: 1),
                                                      icon: Icon(Icons.error));
                                                }
                                              },
                                              child: Text(
                                                "UPDATE",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text(
                                            'Close',
                                            style: TextStyle(
                                                color: Colors.deepPurple),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                      backgroundColor: Colors.lime[100],
                                    ));
                          },
                        ),
                        Divider(
                          thickness: 2.0,
                          indent: 18,
                        )
                      ],
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        backgroundColor: Colors.orange[100],
        onPressed: () {
          Get.toNamed("/AddingANewBook");
        },
        child: Icon(
          Icons.add,
          color: Colors.purple[300],
        ),
      ),
    );
  }
}
