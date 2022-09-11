import 'package:bitfest/providers/profile_provider.dart';
import 'package:bitfest/view/bus/addBusInventory.dart';
import 'package:bitfest/view/bus/editBusInventory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AllBuses extends StatefulWidget {
  const AllBuses({Key? key}) : super(key: key);

  @override
  State<AllBuses> createState() => _AllBusesState();
}

class _AllBusesState extends State<AllBuses> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProfileProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Inventry',style:  TextStyle(color: Colors.black),),

        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          if(pro.role == "Staff")
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "AddBusInventory");
              },
              icon: Icon(Icons.add,color: Colors.black,))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection("BusInventory").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final data = snapshot.data;

          return _buildConsumer(data!, context);
        },
      ),
    );
  }
}

Widget _buildConsumer(QuerySnapshot data, BuildContext context) {
  var pro = Provider.of<ProfileProvider>(context,listen: false);
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    padding: EdgeInsets.only(bottom: 65.h),
    itemBuilder: (context, index) {
      return Container(
        padding: EdgeInsets.all(20.sp),
        margin: EdgeInsets.fromLTRB(25.w, 10.h, 25.w, 10.h),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffE3E3E3), width: 1.7),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildRow("Licence Number :", data.docs[index]["licence"]),
                buildRow("CodeName :", data.docs[index]["codename"]),
                buildRow("Capacity :", data.docs[index]["capacity"]),
                buildRow("Driver Name :", data.docs[index]["driverName"]),
                buildRow("Driver Phone :", data.docs[index]["driverPhone"]),
                buildRow("Is Active :",
                    data.docs[index]["isActive"] ? "Active" : "Not Active"),
              ],
            ),
            Spacer(),
            if(pro.role == "Staff")
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditBusInventory(
                      capacity: data.docs[index]["capacity"],
                      driverPhone: data.docs[index]["driverPhone"],
                      driverName: data.docs[index]["driverName"],
                      isAc: data.docs[index]["isActive"] ,
                      codeName: data.docs[index]["codename"],
                      licence: data.docs[index]["licence"],
                      uid: data.docs[index].id,
                    ),
                  ),
                );
              },
              icon: Icon(Icons.edit),
            )
          ],
        ),
      );
    },
    itemCount: data.docs.length,
  );
}

Row buildRow(String text1, String text2) {
  return Row(
    children: [
      Text(
        text1,
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
      ),
      Row(
        children: [
          Text(
            text2,
            style: TextStyle(
              fontSize: 15.sp,
              decoration:
                  text1 == "Contact : " ? TextDecoration.underline : null,
            ),
          ),
          text1 == "Contact : "
              ? Padding(
                  padding: EdgeInsets.only(left: 15.w),
                  child: Icon(
                    Icons.phone,
                    color: Colors.green,
                    size: 16.sp,
                  ),
                )
              : const SizedBox(),
        ],
      )
    ],
  );
}
