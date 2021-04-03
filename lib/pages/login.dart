import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/loginWidgets/terms.dart';
import 'package:task/loginWidgets/text_field.dart';
import 'package:task/pages/repoPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool signInClicked = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<void> saveUsernameInLocalMemory(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    //this function the commented because github has canceled the basic auth api which is the whole purpose of the task
    // data() async {
    //   var uname = 'Bashovo';
    //   var res = await http.get(Uri.parse('https://api.github.com/user'),
    //       headers: {'Authorization': 'token ' + oAuthToken});
    //   var authn = 'Basic ' + base64Encode(utf8.encode('$uname:$pword'));
    //   if (res.statusCode != 200)
    //     throw Exception('http.get error: statusCode= ${res.statusCode}');
    //   print(res.body);
    // }

    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.30,
                    bottom: MediaQuery.of(context).size.height * 0.05),
                child: Center(
                    child: Image(
                  height: 100,
                  width: 100,
                  color: Colors.white,
                  image: AssetImage(
                    "assets/images/github-logo.png",
                  ),
                )),
              ),
              !signInClicked
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.25),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            signInClicked = !signInClicked;
                          });
                        },
                        child: Text(
                          "Sign in with github",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.25,
                            right: MediaQuery.of(context).size.width * 0.25,
                            top: 20,
                            bottom: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        TextFieldLogin(
                          hint: "Username",
                          controller: usernameController,
                        ),
                        TextFieldLogin(
                          hint: "password",
                          controller: passwordController,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05),
                          child: TextButton(
                            onPressed: () {
                              var url =
                                  'https://api.github.com/users/${usernameController.text}/repos';
                              http.get(Uri.parse(url)).then((response) {
                                if (response.statusCode != 404) {
                                  saveUsernameInLocalMemory(
                                      "username", usernameController.text);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RepoPage()),
                                  );
                                }
                              });
                            },
                            child: Text(
                              "Continue",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.35,
                                right: MediaQuery.of(context).size.width * 0.35,
                                top: 20,
                                bottom: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
              Terms()
            ],
          ),
        ));
  }
}
