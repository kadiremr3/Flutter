import 'package:cloud_firestore/cloud_firestore.dart';

class Books {
  String id;
  String title;
  String author;
  String rating;
  String comments;

  Books(this.id, this.title, this.author, this.rating, this.comments);

  Books.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc["id"];
    title = doc["title"];
    author = doc["author"];
    rating = doc["rating"];
    comments = doc["comments"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "title": this.title,
      "author": this.author,
      "rating": this.rating,
      "comments": this.comments
    };
  }
}
