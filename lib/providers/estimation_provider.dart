import 'dart:developer';

import 'package:bitfest/object/customModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class EstimatedProvider extends ChangeNotifier {
  int r1 = 0, r2 = 0, r3 = 0, r4 = 0;

  getData({required String day, required String timeSlot}) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
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

      r1 = 0;
      r2 = 0;
      r3 = 0;
      r4 = 0;

      List<CustomModel> value = [];

      for (int i = 0; i < col.length; i++) {
        await FirebaseFirestore.instance
            .collection('stats')
            .doc(day)
            .collection(col[i])
            .where('starting_time', isEqualTo: timeSlot)
            .get()
            .then((QuerySnapshot querySnapshot) {
          for (var doc in querySnapshot.docs) {
            value.add(CustomModel(
                doc['starting_time'], doc['batch'], doc['section']));
          }
        });
      }

      for (int i = 0; i < value.length; i++) {
        await FirebaseFirestore.instance
            .collection('Department')
            .doc("CSE")
            .collection("Student")
            .where('batch', isEqualTo: value[i].batch)
            .get()
            .then((QuerySnapshot querySnapshot) {
          for (var doc in querySnapshot.docs) {
            if (doc['section'] == value[i].section || doc['section'] == "") {
              print("${doc['preference']} ==========preeeeeeeeeeeeeeeeeeee");
              if (doc['preference'] == 1) {
                r1++;
              } else if (doc['preference'] == 2) {
                r2++;
              } else if (doc['preference'] == 3) {
                r3++;
              } else if (doc['preference'] == 4) {
                r4++;
              }
            }
          }
        });
      }

      print(r1);
      print(r2);
      print(r3);
      print(r4);

      for (int i = 0; i < value.length; i++) {
        print("${value[i].batch} ==========11111111111111");
        print("${value[i].section} ===555555555555555");
      }
      print("${value.length} =========================");
    }
  }

/*  getData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      */ /*DocumentSnapshot userInfo =
      await FirebaseFirestore.instance.collection('stats').doc("Monday").collection('50').doc().get();*/ /*

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

        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],

      ];

      //1:30-2:10PM
      //9:50-10:40AM

      for (int i = 0; i < col.length; i++) {
        await FirebaseFirestore.instance
            .collection('stats')
            .doc("SUNDAY")
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



            print("Batch ${doc['batch']} Staring $st Ending $end");
            print("----------------------------------- start");

            FirebaseFirestore.instance
                .collection('Department')
                .doc("CSE")
                .collection("Student")
                .where('batch', isEqualTo: int.parse(doc['batch']))

                .get()
                .then((QuerySnapshot querySnapshot) {



              for (var docc in querySnapshot.docs) {
                print('111111111111111111111111111111111');
                print(doc['batch']);
                print(doc['section']);
                print(docc['batch']);
                print(docc['section']);
                print('00000000000000000000000000000000');
                if(doc['section'] == docc['section']){
                  print('*******************************************');
                  print(docc['preference']);
                  batch[i][docc['preference']]++;
                }

              }
            });
            print("----------------------------------- rnd");
            st = '';
            end = '';
          }
        });
      }

      for (int i = 0; i < batch.length; i++) {
        print('${batch[i][0]} ----- ${batch[i][1]} --- ${batch[i][2]} ----- ${batch[i][3]}');
      }

      notifyListeners();
    }
  }*/
}
