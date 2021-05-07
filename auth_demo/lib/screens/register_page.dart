import 'package:auth_demo/services/auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget
{
  AuthService _authService = AuthService();

  var txtEmail = TextEditingController();
  var txtPassword = TextEditingController();
  var txtUsername = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Colors.black),
          ),
          title: Text("Kayıt Ol", style: TextStyle(color: Colors.black)),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              buildLogo(),
              buildUsernameField(),
              buildEmailField(),
              buildPasswordField(),
              buildSubmitButton(context)
            ],
          ),
        )
    );
  }

  Widget buildUsernameField()
  {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: TextField(
        decoration: InputDecoration(labelText: "Kullanıcı Adı", border: OutlineInputBorder()),
        controller: this.txtUsername,
      ),
    );
  }

  Widget buildEmailField()
  {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: TextField(
        decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder()),
        controller: this.txtEmail,
      ),
    );
  }

  Widget buildPasswordField()
  {
    return TextField(
      decoration: InputDecoration(labelText: "Şifre", border: OutlineInputBorder()),
      controller: this.txtPassword,
      obscureText: true,
    );
  }

  Widget buildSubmitButton(context)
  {
    return ElevatedButton(
      style:ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
      ),
      child: Row(
        children: [
          Icon(Icons.app_registration),
          SizedBox(width: 5.0),
          Text("KAYIT OL")
        ],
      ),
      onPressed: (){
        _authService.createPerson(this.txtUsername.text, this.txtEmail.text, this.txtPassword.text).then((value){
          Navigator.pop(context);
        });
      },
    );
  }

  buildLogo()
  {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Container(
        height: 150,
        child: Ink.image(image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/768px-User_icon_2.svg.png")),
      ),
    );
  }
}