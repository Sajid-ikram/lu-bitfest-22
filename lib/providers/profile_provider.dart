import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier {
  String profileUrl = '';

  String profileName = '';
  String batch = '';
  String section = '';
  String department = '';
  String code_name = '';
  String designation = '';

  String role = '';
  String email = '';

  String currentUserUid = '';
  String number = '';

  getUserInfo() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if(user!=null){
      DocumentSnapshot userInfo =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      role = userInfo["role"];
      number = userInfo["number"];
      currentUserUid = user.uid;

      profileName = userInfo["name"];
      batch = userInfo["batch"];
      section = userInfo["section"];
      department = userInfo["department"];
      code_name = userInfo["code_name"];
      designation = userInfo["designation"];

      notifyListeners();
    }

  }
}
