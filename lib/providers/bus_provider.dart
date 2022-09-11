import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusProvider with ChangeNotifier {

  Future addBusInventory({
    required String licence,
    required String codename,
    required String capacity,
    required String driverName,
    required String driverPhone,
    required bool isActive,
    required BuildContext context,
  }) async {
    try {
      FirebaseFirestore.instance.collection("BusInventory").doc().set(
        {
          "licence": licence,
          "codename": codename,
          "capacity": capacity,
          "driverName": driverName,
          "driverPhone": driverPhone,
          "isActive": isActive,

        },
      );

      notifyListeners();
      return "Success";
    } catch (e) {
      return onError(context, "Having problem connecting to the server");

    }
  }

  changeUI(){
    notifyListeners();
  }

  Future editBusInventory({
    required String uid,
    required String licence,
    required String codename,
    required String capacity,
    required String driverName,
    required String driverPhone,
    required bool isActive,
    required BuildContext context,
  }) async {
    try {
      FirebaseFirestore.instance.collection("BusInventory").doc(uid).update(
        {
          "licence": licence,
          "codename": codename,
          "capacity": capacity,
          "driverName": driverName,
          "driverPhone": driverPhone,
          "isActive": isActive,

        },
      );

      notifyListeners();
      return "Success";
    } catch (e) {
      return onError(context, "Having problem connecting to the server");

    }
  }

}


Future onError(BuildContext context, String massage) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('An error occurred'),
      content: Text(massage),
      actions: <Widget>[
        TextButton(
          child: const Text("OK"),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        )
      ],
    ),
  );
}