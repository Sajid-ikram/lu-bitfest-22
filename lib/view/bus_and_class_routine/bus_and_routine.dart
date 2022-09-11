import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

//import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../providers/pdf_and_notification_provider.dart';
import '../../providers/profile_provider.dart';

class BusSchedule extends StatefulWidget {
  BusSchedule({Key? key, required this.name}) : super(key: key);
  String name;

  @override
  _BusScheduleState createState() => _BusScheduleState();
}

class _BusScheduleState extends State<BusSchedule> {
  pickFile() async {
    print("fghf--------------------------------");
    FilePickerResult? result =
    await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      var pro = Provider.of<PDFAndNotificationProvider>(context, listen: false);
      pro.uploadPDF(file, context, widget.name);
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.name,
          style: TextStyle(
            fontSize: 19.sp,
            fontWeight: FontWeight.w500,
            color: Colors.cyan,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20.sp,
          ),
        ),
        actions: [
          if(pro.role != "Student" || true)
            IconButton(
              onPressed: () {
                print("============================");
                pickFile();
              },
              icon: Icon(
                Icons.add,
                color: Colors.black,
                size: 24.sp,
              ),
            )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("PDF").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshot.data;
          var a = data?.docs.length;

          /*if (widget.name == "Bus Schedule") {
            for (int i = 0; i < a!; i++) {
              if (data?.docs[i].id == "Bus Schedule") {
                return SfPdfViewer.network(data?.docs[i]["busUrl"]);
              }
            }
            return pdfUnavailable();
          }
          for (int i = 0; i < a!; i++) {
            if (data?.docs[i].id == "Routine") {
              return SfPdfViewer.network(data?.docs[i]["routineUrl"]);
            }
          }*/
          return pdfUnavailable();
        },
      ),
    );
  }

  Center pdfUnavailable() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.name == "Bus Schedule"
                ? "No Schedule added yet!"
                : "No routine yet! Add one",
            style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.w500,
              color: Colors.cyan,
            ),
          ),

        ],
      ),
    );
  }
}