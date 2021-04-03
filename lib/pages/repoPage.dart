import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/models/repo.dart';

// ignore: must_be_immutable
class RepoPage extends StatelessWidget {
  List<String> names = [];
  List<String> images = [];
  var namesConverted;
  var imagesConverted;
  Future<dynamic> getNamesFromLocalMemory(String names) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var name = pref.getStringList(names) ?? null;
    return name;
  }

  Future<dynamic> getImagesFromLocalMemory(String images) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var image = pref.getStringList(images) ?? null;
    return image;
  }

  Future<void> saveNamesInLocalMemory(String key, List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }

  Future<void> saveImagesInLocalMemory(String key, List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }

  Future<String> getUsernameFromLocalMemory() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String username = pref.getString("username") ?? null;
    return username;
  }

  List<Repo> repos = [];
  Future<List<Repo>> _getRepos() async {
    try {
      //checks if there is internet connection
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        String username = await getUsernameFromLocalMemory() as String;
        var url = 'https://api.github.com/users/$username/repos';
        await http.get(Uri.parse(url)).then((response) {
          Iterable list = json.decode(response.body);
          for (var temp in list) {
            repos.add(Repo.fromJson(temp));
            names.add(Repo.fromJson(temp).name);
            images.add(Repo.fromJson(temp).owner.avatarUrl);
          }
          saveNamesInLocalMemory("names", names);
          saveImagesInLocalMemory("images", images);
        });
      }
    } on SocketException catch (_) {
      List<String> names = await getNamesFromLocalMemory("names");
      List<String> images = await getImagesFromLocalMemory("images");
      for (int x = 0; x < names.length; x++) {
        var tmpObj = new Repo();
        tmpObj.owner = new Owner();
        tmpObj.name = names[x];
        tmpObj.owner.avatarUrl = images[x];
        repos.add(tmpObj);
      }
    }
    return repos;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Home",
          style: TextStyle(color: Colors.blue),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Repositories",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
          ),
          FutureBuilder(
              future: _getRepos(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text(
                        "Loading...",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                              leading: Image.network(
                                snapshot.data[index].owner.avatarUrl,
                                height: 50,
                                width: 50,
                              ),
                              title: Text(
                                snapshot.data[index].name,
                                style: TextStyle(color: Colors.white),
                              )),
                        );
                      },
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
