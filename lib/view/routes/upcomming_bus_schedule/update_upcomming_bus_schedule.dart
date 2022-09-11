import 'package:bitfest/providers/bus_provider.dart';
import 'package:bitfest/providers/profile_provider.dart';
import 'package:bitfest/view/bus/addBusInventory.dart';
import 'package:bitfest/view/bus/editBusInventory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'make_bus_schedule.dart';

class UpCommingBusSchedule extends StatefulWidget {
  const UpCommingBusSchedule({Key? key}) : super(key: key);

  @override
  State<UpCommingBusSchedule> createState() => _UpCommingBusScheduleState();
}

class _UpCommingBusScheduleState extends State<UpCommingBusSchedule> {

  List<String> busList = [];
  List<String> busCapacityList = [];

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProfileProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Buses'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => MakeBusSchedule(busList : busList , busCapacityList : busCapacityList)));
              },
              icon: Icon(Icons.check))
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

          return _buildConsumer(data!, context, busList , busCapacityList);
        },
      ),
    );
  }
}

Widget _buildConsumer(QuerySnapshot data, BuildContext context , List<String> busList , List<String> busCapacityList) {
  var pro = Provider.of<ProfileProvider>(context,listen: false);
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    padding: EdgeInsets.only(bottom: 10.h),
    itemBuilder: (context, index) {
      return Container(
        padding: EdgeInsets.all(10.sp),
        margin: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffE3E3E3), width: 1.7),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildRow("CodeName :", data.docs[index]["codename"]),
                buildRow("Licence Number :", data.docs[index]["licence"]),
                buildRow("Capacity :", data.docs[index]["capacity"]),
                buildRow("Driver Name :", data.docs[index]["driverName"]),
                buildRow("Is Active :",
                    data.docs[index]["isActive"] ? "Active" : "Not Active"),
              ],
            ),
            Spacer(),
            if(pro.role == "Staff")
        Consumer<BusProvider>(
          builder: (_, foo, __) => IconButton(
        onPressed: () {

          if(!busList.contains(data.docs[index]["codename"])){
            busList.add(data.docs[index]["codename"]);
            busCapacityList.add(data.docs[index]["capacity"]);

            print(busList);
            Provider.of<BusProvider>(context,listen: false).changeUI();
          } else {
            busList.remove(data.docs[index]["codename"]);
            busCapacityList.remove(data.docs[index]["capacity"]);

            print(busList);
            Provider.of<BusProvider>(context,listen: false).changeUI();
          }

        },
        icon: Icon(Icons.check_circle , color: busList.contains(data.docs[index]["codename"]) ? Colors.green : Colors.grey,),
      )
        ),

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
