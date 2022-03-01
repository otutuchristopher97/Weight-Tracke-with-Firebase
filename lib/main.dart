import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/constants.dart';
import 'package:weight_tracker/provider/service.dart';
import 'package:weight_tracker/screen/authentication/login_screen.dart';
import 'package:weight_tracker/screen/dashboard/dashboard_screen.dart';
import 'package:weight_tracker/splashScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthService(),
        ),
      ],
      child: MaterialApp(
          title: 'Weight Tracker',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashScreen(),
          routes: {
            kAuthScreen: (ctx) => AuthScreen(),
            KDashboardScreen: (ctx) => DashboardScreen(),
          },

      ),
    );
  }
}
