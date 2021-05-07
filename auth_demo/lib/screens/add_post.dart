import 'package:auth_demo/services/post_service.dart';
import 'package:flutter/material.dart';

class AddPost extends StatelessWidget
{
  var txtTitle = TextEditingController();
  var txtShort = TextEditingController();

  PostService _postService = PostService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.network("https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png", height: 30),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: [
          IconButton(icon: Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context))
        ],
      ),
      body: buildBody(context),
    );
  }

  buildBody(context)
  {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [
          buildTitleField(),
          buildShortField(),
          buildSubmitButton(context)
        ],
      ),
    );
  }

  buildTitleField()
  {
    return TextField(
      decoration: InputDecoration(labelText: "Başlık", hintText: "Başlığı girin", border: OutlineInputBorder()),
      controller: this.txtTitle,
    );
  }

  buildShortField()
  {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: TextField(
        decoration: InputDecoration(labelText: "Kısa içerik", hintText: "Kısa içerik", border: OutlineInputBorder()),
        controller: this.txtShort,
        maxLines: 3,
      ),
    );
  }

  buildSubmitButton(context)
  {
    return ElevatedButton(
      child: Row(
        children: [
          Icon(Icons.add),
          SizedBox(width: 5.0),
          Text("Ekle")
        ],
      ),
      onPressed: (){
          _postService.addPost(this.txtTitle.text, this.txtShort.text).then((value){
            Navigator.pop(context);
          });
      },
    );
  }
}