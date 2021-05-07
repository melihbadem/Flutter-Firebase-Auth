import 'package:auth_demo/screens/add_post.dart';
import 'package:auth_demo/services/auth.dart';
import 'package:auth_demo/services/post_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget
{
  AuthService _authService = AuthService();
  PostService _postService = PostService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.network("https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png", height: 30),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.black,),
              onPressed: (){
                _authService.signOut();
                Navigator.pushReplacementNamed(context, "/login");
              },)
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddPost())),
        ),
        body: buildBody(context)
    );
  }

  Widget buildBody(context)
  {
    return StreamBuilder(
      stream: _postService.getPost(),
      builder: (context, snapshot){
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot mypost = snapshot.data.documents[index];

              return InkWell(
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Ink.image(
                          height: 200,
                          image: NetworkImage("https://wallpaperaccess.com/full/4609570.jpg"),
                          fit: BoxFit.fitWidth,
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              Text("${mypost['title']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0), textAlign: TextAlign.left),
                              Text("${mypost['short']}", textAlign: TextAlign.left)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                onTap: (){
                  _showClosedDialog(context, mypost.id);
                },
              );
            },
          );
      },
    );
  }

  Future<void> _showClosedDialog(BuildContext context, id)
  {
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Silmek istediğinize emin misiniz ?"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            content: Container(
              child: Row(
                children: [
                  InkWell(child: Text("Evet"), onTap: () {
                    _postService.removePost(id);
                    Navigator.pop(context);
                 }),
                  SizedBox(width: 5.0),
                  InkWell(child: Text("Hayır"), onTap: () => Navigator.pop(context))
                ],
              ),
            ),
          );
        }
    );
  }
}