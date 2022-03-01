import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:weight_tracker/provider/service.dart';
import 'package:weight_tracker/utils/shared/CustomRaisedButton.dart';

import '../../constants.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // User user;
  bool _isloading = false;
  final AuthService _auth = AuthService();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  

  authenticateUser() async {
    try {
      setState(() {
        _isloading = true;
      });
      final user = await Provider.of<AuthService>(context, listen: false).signInAnon();
      if (user != null) {
        setState(() {
          _isloading = false;
        });
        Future.delayed(Duration(seconds: 2));
        Navigator.of(context).pushNamedAndRemoveUntil(KDashboardScreen, (route) => false);
      }
    } catch (e) {
      print(e.toString());
      setState(() {
          _isloading = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //Expanded(child: Container()),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Welcome to Weight Tracker',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Create a personalized weight record plan based on daily activity and eating habits',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Color(0xff273B4A),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 55,
                    child: CustomRaisedButton(
                      title: 'Get Started',
                      size: 16,
                      isLoading: _isloading,
                      buttonColor: Color(0xff3168F4),
                      titleColor: Colors.white,
                      onPress: () {
                        authenticateUser();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
