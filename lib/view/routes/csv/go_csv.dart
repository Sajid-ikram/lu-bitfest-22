import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle, rootBundle;
import 'package:csv/csv.dart';

class GOCSV extends StatefulWidget {
  const GOCSV({Key? key}) : super(key: key);

  @override
  State<GOCSV> createState() => _GOCSVState();
}

class _GOCSVState extends State<GOCSV> {
  List<List<dynamic>> _data = [];
  String? filePath;

  // This function is triggered when the  button is pressed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          title: const Text("Bulk Upload",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              )),
        ),
        body: Column(
          children: [
            ElevatedButton(
              child: const Text("Upload FIle"),
              onPressed: () {
                _pickFile();
              },
            ),

            // Expanded(
            //   child: ListView.builder(
            //     itemCount: _data.length,
            //     scrollDirection: Axis.vertical,
            //     shrinkWrap: true,
            //     itemBuilder: (_, index) {
            //       return Card(
            //         margin: const EdgeInsets.all(3),
            //         color: index == 0 ? Colors.amber : Colors.white,
            //         child: ListTile(
            //           leading: Text(_data[index][0].toString(),textAlign: TextAlign.center,
            //             style: TextStyle(fontSize: index == 0 ? 18 : 15, fontWeight:index == 0 ? FontWeight.bold :FontWeight.normal,color: index == 0 ? Colors.red : Colors.black),),
            //           title: Text(_data[index][1],textAlign: TextAlign.center,
            //             style: TextStyle(fontSize: index == 0 ? 18 : 15, fontWeight: index == 0 ? FontWeight.bold :FontWeight.normal,color: index == 0 ? Colors.red : Colors.black),),
            //           trailing: Text(_data[index][2].toString(),textAlign: TextAlign.center,
            //             style: TextStyle(fontSize: index == 0 ? 18 : 15, fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,color: index == 0 ? Colors.red : Colors.black),),
            //
            //         ),
            //
            //       );
            //
            //     },
            //
            //   ),
            // ),
            Container(
              child: ElevatedButton(
                onPressed: () async {
                  // set loading to true here

                  bool routineActive = false;

                  String day = "";
                  String batch = "";
                  String section = "";
                  String startingTime = "";
                  String endingTime = "";
                  List<dynamic> timeTable = [];

                  for (var element in _data) // for skip first value bcs its contain name
                  {


                    if (element[0] == 'SUNDAY') {
                      routineActive = true;
                      day = "SUNDAY";
                      timeTable = element;
                    } else if (element[0] == "" && routineActive) {
                      batch = element[2].toString();
                      section = element[1].toString();

                      for (int i = 3; i < 10; i++) {
                        if(element[i].toString() != ""){
                          startingTime = timeTable[i].toString();
                          break;
                        }
                      }

                      for (int i = 11; i > 0; i--) {
                        if(element[i].toString() != ""){
                          endingTime = timeTable[i].toString();
                          break;
                        }
                      }

                      if(day == "SUNDAY"){
                        FirebaseFirestore.instance.collection("stats").doc(day).collection("${batch}${section}").doc().set(
                          {
                            "starting_time": startingTime,
                            "ending_time": endingTime ,
                            "batch": batch,
                            "section": section,
                            "day": day,

                          },
                        );
                      }


                      print("starting_time : $startingTime");
                      print("ending time : $endingTime");
                      print("batch : $batch ");
                      print("section : $section");
                      print("day : $day");

                      batch = "";
                      section = "";
                      startingTime = "";
                      endingTime = "";
                    }
                  }
                },
                child: const Text("Iterate Data"),
              ),
            ),
          ],
        ));
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if no file is picked
    if (result == null) return;
    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    print(result.files.first.name);
    filePath = result.files.first.path!;

    final input = File(filePath!).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();

    setState(() {
      _data = fields;
    });
  }
}