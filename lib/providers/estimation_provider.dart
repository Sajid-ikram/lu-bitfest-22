import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class EstimatedProvider extends ChangeNotifier {
  getData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      /*DocumentSnapshot userInfo =
      await FirebaseFirestore.instance.collection('stats').doc("Monday").collection('50').doc().get();*/

      List<String> col = [
        "50",
        "51",
        "52",
        "53",
        "54",
        "55",
        "56",
        "57",
        "58",
        "59",
        "60"
      ];

      List<List<int>> batch = [
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
      ];

      //1:30-2:10PM
      //9:50-10:40AM

      for (int i = 0; i < col.length; i++) {
        await FirebaseFirestore.instance
            .collection('stats')
            .doc("Monday")
            .collection(col[i])
            .get()
            .then((QuerySnapshot querySnapshot) {
          for (var doc in querySnapshot.docs) {
            String starting = doc['starting_time'];
            String st = '';
            String end = '';
            String ending = doc['ending_time'];

            for (int j = 0; j < starting.length; j++) {
              if (starting[j] == ':') {
                if (j == 1) {
                  st = starting[0];
                } else {
                  st = starting[0] + starting[1];
                }
                break;
              }
            }

            for (int j = 0; j < ending.length; j++) {
              if (ending[j] == '-') {
                if (ending[j + 3] == ":") {
                  end = ending[j + 1] + ending[j + 2];
                } else {
                  end = ending[j + 1];
                }
                break;
              }
            }

            print("----------------------------------- start");

            FirebaseFirestore.instance
                .collection('Department')
                .doc("CSE")
                .collection("Student")
                .where('batch', isEqualTo: int.parse(doc['batch']))
                .where('section', isEqualTo: doc['section'])
                .get()
                .then((QuerySnapshot querySnapshot) {
              print('*******************************************');

              for (var docc in querySnapshot.docs) {
                print(doc['preference']);
                batch[i][docc['preference']]++;
              }
            });
            print("----------------------------------- rnd");
            st = '';
            end = '';
          }
        });
      }

      for (int i = 0; i < batch.length; i++) {
        print(batch[i][0] + batch[i][1] + batch[i][2] + batch[i][3]);
      }

      notifyListeners();
    }
  }
}
