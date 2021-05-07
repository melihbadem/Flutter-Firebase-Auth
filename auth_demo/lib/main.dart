import 'package:auth_demo/screens/home_page.dart';
import 'package:auth_demo/screens/login_page.dart';
import 'package:auth_demo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    title: "Auth Demo",
    routes: {
      "/home": (context) => HomePage(),
      "/login": (context) => MyApp()
    },
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: LoginPage()
    );
  }
}