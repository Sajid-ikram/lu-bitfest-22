import 'package:bitfest/view/routes/add_stoppage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewStoppage extends StatefulWidget {
  ViewStoppage({Key? key , required this.routeNumber}) : super(key: key);
  String routeNumber;

  @override
  State<ViewStoppage> createState() => _ViewStoppageState();
}

class _ViewStoppageState extends State<ViewStoppage> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("View Stoppage"),),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream:
            FirebaseFirestore.instance.collection("routes").doc(widget.routeNumber).collection("stoppages").snapshots(),
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
        ],
      )
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
            //Navigator.of(context).push(MaterialPageRoute(builder: (_) => ViewRoute( routeNumber: data.docs[index]["routeNumber"],)));
          },
          child: Container(
            color: Colors.grey,
            padding: EdgeInsets.all(30.sp),
            child: Column(
              children: [
                buildRow(data.docs[index]["stoppageLabel"]),
              ],
            ),
          ),
        ),
      );
    },
    itemCount: data.docs.length,
  );
}

Row buildRow(String text2) {
  return Row(
    children: [
      Row(
        children: [
          Text(
            text2,
            style: TextStyle(
              fontSize: 15.sp,
            ),
          ),
        ],
      )
    ],
  );
}

