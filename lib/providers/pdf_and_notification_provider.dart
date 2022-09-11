
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import '../public/custom_loading.dart';
import 'bus_provider.dart';

class PDFAndNotificationProvider extends ChangeNotifier {
  Future uploadPDF(File file, BuildContext context, String text) async {
    try {
      buildLoadingIndicator(context);
      final ref =
          storage.FirebaseStorage.instance.ref().child("PDF").child(text);

      final result = await ref.putFile(file);
      final url = await result.ref.getDownloadURL();
      String name = '';
      if (text == "Bus Schedule") {
        name = "busUrl";
      } else {
        name = "routineUrl";
      }
      FirebaseFirestore.instance.collection("PDF").doc(text).set(
        {name: url},
      );
      Navigator.of(context, rootNavigator: true).pop();
      notifyListeners();
    } catch (e) {
      return onError(context, "Having problem connecting to the server");
    }
  }


}
