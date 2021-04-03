import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width * 0.7,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "By signing in you accept our ",
          style: TextStyle(color: Colors.white),
          children: <TextSpan>[
            TextSpan(
                text: 'Terms of use ',
                style: TextStyle(color: Colors.blueAccent)),
            TextSpan(text: 'and ', style: TextStyle(color: Colors.white)),
            TextSpan(
                text: 'Privacy policy.',
                style: TextStyle(color: Colors.blueAccent)),
          ],
        ),
      ),
    );
  }
}
