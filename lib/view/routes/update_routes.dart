import 'package:bitfest/view/routes/view_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateRoutes extends StatefulWidget {
  const UpdateRoutes({Key? key}) : super(key: key);

  @override
  State<UpdateRoutes> createState() => _UpdateRoutesState();
}

class _UpdateRoutesState extends State<UpdateRoutes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Routes"),),
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

          return _buildConsumer(data!);
        },
      ),
    );
  }




}

Widget _buildConsumer(QuerySnapshot data) {
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    padding: EdgeInsets.only(bottom: 65.h),
    itemBuilder: (context, index) {

      return Padding(
        padding: const EdgeInsets.all(3.0),
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => ViewRoute( routeNumber: data.docs[index]["routeNumber"],)));
          },
          child: Container(
            color: Colors.grey,
            padding: EdgeInsets.all(30.sp),
            child: Column(
              children: [
                buildRow("Route Label :", data.docs[index]["routeLabel"]),
                buildRow("Start Time :", data.docs[index]["startTime"]),
              ],
            ),
          ),
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
