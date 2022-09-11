import 'package:bitfest/view/bus/addBusInventory.dart';
import 'package:bitfest/view/profile/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../providers/profile_provider.dart';

class UpdateProfileInfo extends StatefulWidget {
  const UpdateProfileInfo({Key? key}) : super(key: key);

  @override
  State<UpdateProfileInfo> createState() => _UpdateProfileInfoState();
}

class _UpdateProfileInfoState extends State<UpdateProfileInfo> {
  TextEditingController nameController = TextEditingController();
  TextEditingController batchController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController codeNameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  String choose = "";

  update(String profileUid, String choose) async {
    //await FirebaseFirestore.instance.collection('users').doc(profileUid).update();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProfileProvider>(context);

    nameController.text = pro.profileName;
    batchController.text = pro.batch;
    sectionController.text = pro.section;

    departmentController.text = pro.department;
    codeNameController.text = pro.code_name;
    designationController.text = pro.designation;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.blueGrey,
        ),
        title: const Text(
          "Update Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: pro.role == "Student"
          ? studentUpdate(
              context, nameController, batchController, sectionController)
          : pro.role == "Teacher"
              ? teacherUpdate(context, nameController, departmentController,
                  codeNameController, designationController)
              : Container(),
    );
  }
}

Widget studentUpdate(
    BuildContext context,
    TextEditingController nameController,
    TextEditingController batchController,
    TextEditingController sectionController) {
  var pro = Provider.of<ProfileProvider>(context);
  return Column(
    children: [
      TextField(
        controller: nameController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Name',
        ),
      ),
      TextField(
        controller: batchController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Batch',
        ),
      ),
      TextField(
        controller: sectionController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Section',
        ),
      ),
      ElevatedButton(
          onPressed: () async {
            await FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .update(
              {
                "name": nameController.text,
                "batch": batchController.text,
                "section": sectionController.text,
              },
            );
            pro.getUserInfo();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const Profile()));
          },
          child: const Text("Update"))
    ],
  );
}

Widget teacherUpdate(
    BuildContext context,
    TextEditingController nameController,
    TextEditingController departmentController,
    TextEditingController codeNameController,
    TextEditingController designationController) {
  var pro = Provider.of<ProfileProvider>(context);
  return Column(
    children: [
      // TextField(
      //   controller: nameController,
      //   decoration: const InputDecoration(
      //     border: OutlineInputBorder(),
      //     hintText: 'Name',
      //   ),
      // ),
      TextField(
        controller: departmentController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Batch',
        ),
      ),
      TextField(
        controller: codeNameController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'CodeName',
        ),
      ),
      TextField(
        controller: designationController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Designation',
        ),
      ),
      ElevatedButton(
          onPressed: () async {
            await FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .update(
              {
                "department": departmentController.text,
                "code_name": codeNameController.text,
                "designation": designationController.text,
              },
            );
            pro.getUserInfo();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const Profile()));
          },
          child: const Text("Update"))
      // FirebaseFirestore.instance.collection("routes").doc(.text).set(
      //   {
      //     "routeNumber": routeNumberController.text,
      //     "routeLabel": labelController.text ,
      //     "routeLatitude": latitudeController.text,
      //     "routeLongitude": longitudeController.text,
      //     "startTime": startTimeController.text,
      //
      //   },
      // );
      // FirebaseFirestore.instance.collection("routes").doc(routeNumberController.text).set(route);
    ],
  );
}
