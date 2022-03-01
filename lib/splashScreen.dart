import 'dart:async';

import 'package:flutter/material.dart';
import 'constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 4);
    return Timer(duration, route);
  }

  route() {
    Navigator.of(context).popAndPushNamed(kAuthScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/weight.png",
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(height: 30,),
                  Text(
                    "Weight Tracker",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff365770), fontSize: 18)
                  )
                ],
              ),
            )),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Powered By ',
                style: TextStyle(fontWeight: FontWeight.normal, color: Color(0xff687078), fontSize: 12),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Chris Technologies',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff365770), fontSize: 12)),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
