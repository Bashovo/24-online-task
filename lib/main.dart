import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/pages/login.dart';
import 'package:task/pages/repoPage.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  bool repoPage = false;
  //checks if the user has logged in before
  isLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String username = pref.getString("username") ?? null;
    if (username != null) {
      repoPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
            future: isLoggedIn(),
            builder: (context, snapshot) {
              return repoPage ? RepoPage() : LoginPage();
            }));
  }
}
