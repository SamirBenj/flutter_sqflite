import 'package:flutter/material.dart';
import 'package:flutter_sqflite/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();

    //initialisation de la base de donnée
    getUserData();
  }

  //Verification si un utilisateur est déja connecté ou non
  //Si Oui alors on met la variable booleen isLoggedIn à true => navigation vers son profile
  //Si Non alors on met la variable booléen isLoggedIn à false => pas de navigation vers son profile
  void getUserData() async {
    final SharedPreferences sp = await _prefs;
    setState(() {
      var test = sp.getString('email');
      if (test != null) {
        setState(() {
          isLoggedIn = true;
        });
      } else {
        isLoggedIn = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //si isLoggedIn == false alors Page de connexion sinon le profile Utilisateur.
      home: isLoggedIn ? HomePage() : WelcomePage(),
    );
  }
}
