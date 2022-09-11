import 'package:bitfest/view/profile/widgets/profile_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/profile_provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProfileProvider>(context);

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
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
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

          SizedBox(
            height: 20.w,
          ),
          profileRow("Name", pro.profileName, context, true),
          Divider(
            thickness: 1.w,
          ),
        ],
      ),
    );
  }
}
