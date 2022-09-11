import 'package:bitfest/view/profile/update_profile_info.dart';
import 'package:bitfest/view/profile/widgets/profile_row.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/profile_provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}
// void ince() async {
//   for(var i = 0; i < 3; i++) {
//     List<String> list = ["CSE", "EEE", "CIVIL"];
//     for(var j = 0; j < 10; j++) {
//       int id = 1912020112;
//       int road = j % 4 + 1;
//       String roadString = road.toString();
//       String idString = id.toString();
//       await FirebaseFirestore.instance.collection("Department").doc(list[i]).collection("Student").doc().set({"name": "Tanzim", "preference": road, "batch": 50, "section": "C"});
//       id++;
//     }
//   }
// }

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProfileProvider>(context);
    // ince();
    return Scaffold(
      //backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "My Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back_ios,
        //   ),
        // ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.w,
          ),
          Stack(
            children: [
              CircleAvatar(
                radius: 80.w,
                backgroundColor: Colors.blueGrey,
              ),
              Icon(
                Icons.person,
                size: 160.w,
                color: Colors.white,
              ),
            ],
          ),
          (pro.role == "Student")
              ? Column(
                  children: [
                    profileRow("Name", pro.profileName, context, false),
                    Divider(
                      thickness: 1.w,
                    ),
                    profileRow("Batch no", pro.batch, context, false),
                    Divider(
                      thickness: 1.w,
                    ),
                    profileRow("Section", pro.section, context, false),
                    Divider(
                      thickness: 1.w,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const UpdateProfileInfo()));
                      },
                      child: const Text(
                        "Update Profile",
                      ),
                    ),
                  ],
                )
              : (pro.role == "Teacher")
                  ? Column(
                      children: [
                        profileRow(
                            "Department", pro.department, context, false),
                        Divider(
                          thickness: 1.w,
                        ),
                        profileRow("Code name", pro.code_name, context, false),
                        Divider(
                          thickness: 1.w,
                        ),
                        profileRow(
                            "Designation", pro.designation, context, false),
                        Divider(
                          thickness: 1.w,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => const UpdateProfileInfo()));
                          },
                          child: const Text(
                            "Update Profile",
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        profileRow("Name", pro.profileName, context, false),
                        Divider(
                          thickness: 1.w,
                        ),
                        profileRow("Role", pro.role, context, false),
                        Divider(
                          thickness: 1.w,
                        ),
                        profileRow(
                            "Contact number", pro.number, context, false),
                        Divider(
                          thickness: 1.w,
                        ),
                      ],
                    ),
        ],
      ),
    );
  }
}
