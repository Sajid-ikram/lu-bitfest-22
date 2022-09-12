import 'package:bitfest/view/routes/add_routes.dart';
import 'package:bitfest/view/routes/upcomming_bus_schedule/schedule.dart';
import 'package:bitfest/view/routes/update_route.dart';
import 'package:bitfest/view/routes/view_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/profile_provider.dart';
import 'csv/go_csv.dart';

class CustomRoute extends StatefulWidget {
  const CustomRoute({Key? key}) : super(key: key);

  @override
  State<CustomRoute> createState() => _CustomRouteState();
}

class _CustomRouteState extends State<CustomRoute> {
  
  @override
  Widget build(BuildContext context) {
    
    var size = MediaQuery.of(context).size;
    var pro = Provider.of<ProfileProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text('Routes'),
        backgroundColor: Colors.black,
        actions: [
          if(pro.role == "Staff")
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddRoutes()));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
        FirebaseFirestore.instance.collection("routes").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final data = snapshot.data;

          return _buildConsumer(data! , pro);
        },
      ),
    );
  }
}

Widget _buildConsumer(QuerySnapshot data , ProfileProvider pro) {
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
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => ViewRoute( routeNumber: data.docs[index]["routeNumber"],)));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRow("Route Label :", data.docs[index]["routeLabel"]),
                  buildRow("Start Time :", data.docs[index]["startTime"]),
                ],
              ),
            ),
            Spacer(),
            if(pro.role == "Staff")
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UpdateRoute(routeLatitude: data.docs[index]["routeLatitude"], startTime: data.docs[index]["startTime"], routeLongitude: data.docs[index]["routeLongitude"], routeNumber: data.docs[index]["routeNumber"], routeLabel: data.docs[index]["routeLabel"],
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