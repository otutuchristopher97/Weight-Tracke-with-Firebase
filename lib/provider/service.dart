import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  final _firestore = FirebaseFirestore.instance;

  // sign in anon
  Future signInAnon() async {
    try {
      final result = await _auth.signInAnonymously();
      user = result.user;
      print(user.uid);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOutAnon() async {
    try {
      await _auth.signOut();
      user = null;
      print(user.uid);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> enterWeight(weight, data) async {
    print({
        'weight': weight,
        'time':data,
      });
    try {
      await _firestore.collection('weight_tracker').add({
        'weight': weight,
        'time':data,
      });
      print(user.uid);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
