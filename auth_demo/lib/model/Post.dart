import 'package:cloud_firestore/cloud_firestore.dart';

class Post
{
  String id;
  String title;
  String short;
  String image;

  Post({this.id, this.title, this.short});
  Post.withImage(this.id, this.title, this.short, this.image);

  factory Post.fromSnapShot(DocumentSnapshot snapshot)
  {
    return Post(
      id: snapshot.id,
      title: snapshot["title"],
      short: snapshot["short"]
    );
  }
}