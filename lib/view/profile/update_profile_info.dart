import 'package:cloud_firestore/cloud_firestore.dart';
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

  update(String profileUid) async {
    var pro = Provider.of<ProfileProvider>(context, listen: false);
    await FirebaseFirestore.instance.collection('users').doc(profileUid).update({'name': nameController.text});
    pro.getUserInfo();
    nameController.clear();
    if(!mounted) return;
    //showDialogProfileUpdate(context, pro.profileUid);
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProfileProvider>(context);

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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0.w),
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 15.w),
                fillColor: Colors.blueGrey,
                focusedBorder: const OutlineInputBorder(
                  //borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blueGrey,
                  ),
                ),
                label: Padding(
                  padding: EdgeInsets.all(8.0.w),
                  child: const Text('Update Name'),
                ),
                hintText: pro.profileName,
                border: const OutlineInputBorder(
                  gapPadding: 0,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              try {
                update(pro.currentUserUid);
                //showDialogProfileUpdate(context, pro.profileUid);
              }
              catch(e){
                //...ignored
              }
            },
            child: const Text(
              "save",
            ),
          ),
        ],
      ),
    );
  }
}
