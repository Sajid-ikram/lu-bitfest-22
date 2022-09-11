import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier {
  String profileUrl = '';
  String profileName = '';
  String role = '';
  String email = '';
  String department = '';
  String currentUserUid = '';

  getUserInfo() async {


    final User? user = FirebaseAuth.instance.currentUser;
    if(user!=null){
      DocumentSnapshot userInfo =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      profileUrl = userInfo["url"];
      profileName = userInfo["name"];
      role = userInfo["role"];
      email = userInfo["email"];
      department = userInfo["department"];
      currentUserUid = user.uid;
      notifyListeners();
    }

  }
}
