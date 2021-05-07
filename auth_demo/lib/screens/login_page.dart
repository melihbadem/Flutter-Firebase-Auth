import 'package:auth_demo/screens/home_page.dart';
import 'package:auth_demo/screens/register_page.dart';
import 'package:auth_demo/services/auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget
{
  AuthService _authService = AuthService();

  var txtEmail = TextEditingController();
  var txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            buildLogo(),
            buildEmailField(),
            buildPasswordField(),
            buildLoginButton(context),
            buildRegisterButton(context)
          ],
        ),
      ),
    );
  }

  Widget buildEmailField()
  {
    return TextField(
      decoration: InputDecoration(
          labelText: "Email",
          hintText: "Email adresinizi girin",
          border: OutlineInputBorder()
      ),
      controller: this.txtEmail,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget buildPasswordField()
  {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 5.0),
      child: TextField(
        decoration: InputDecoration(
            labelText: "Şifre",
            hintText: "Şifrenizi girin",
            border: OutlineInputBorder()
        ),
        controller: this.txtPassword,
        obscureText: true,
      ),
    );
  }

  Widget buildLoginButton(context)
  {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.all(8),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("GİRİŞ YAP", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ],
      ),
      onPressed: (){
        _authService.signIn(this.txtEmail.text, this.txtPassword.text).then((value){
          Navigator.pushReplacementNamed(context, "/home");
        })
        .catchError((onError) => showError(context));
      },
    );
  }

  buildRegisterButton(context)
  {
    return Padding(
      padding: const EdgeInsets.only(top: 45.0),
      child: Column(
         children: [
           Text("Hesabın yok mu ?"),
           TextButton(
               child: Text("Kayıt Ol", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
               onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
               }
           )
         ],
      ),
    );
  }

  Future<void> showError(context)
  {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hata'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Kullanıcı adı veya şifre hatalı'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

  buildLogo()
  {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Container(
        height: 150,
        child: Ink.image(image: NetworkImage("https://cdn.icon-icons.com/icons2/2107/PNG/512/file_type_flutter_icon_130599.png")),
      ),
    );
  }
}