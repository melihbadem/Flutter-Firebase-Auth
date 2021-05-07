import 'package:auth_demo/model/Post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostService
{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addPost(String title, String short) async
  {
    var ref = _firestore.collection("Post");

    var documentRef = await ref.add({
      'title': title,
      'short': short
    });

    return Post(id: documentRef.id, title: title, short: short);
  }

  Stream<QuerySnapshot> getPost()
  {
    var ref = _firestore.collection("Post").snapshots();
    return ref;
  }

  Future<void> removePost(String docId)
  {
    var ref = _firestore.collection("Post").doc(docId).delete();
    return ref;
  }
}