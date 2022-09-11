import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'add_stoppage.dart';

class ViewRoute extends StatefulWidget {
  ViewRoute({Key? key , required this.routeNumber}) : super(key: key);

  String routeNumber;

  @override
  State<ViewRoute> createState() => _ViewRouteState();
}

class _ViewRouteState extends State<ViewRoute> {

  bool isLoading = true;
  late DocumentSnapshot routeInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    routeInfo = await FirebaseFirestore.instance.collection('routes').doc(widget.routeNumber).get();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stoppage List of Route ${widget.routeNumber}'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddStoppage(routeNumber: widget.routeNumber) ));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(
          children : [

            isLoading ? CircularProgressIndicator() : RouteInfo(context,routeInfo),

            Text("Stoppage List" , style : TextStyle(fontSize: 20)),

            _stoppageList(context , widget.routeNumber),

          ]
      ),
    );
    ;
  }
}

Widget _stoppageList(BuildContext context , String routeNumber){
  return Expanded(
    child: StreamBuilder<QuerySnapshot>(
      stream:
      FirebaseFirestore.instance.collection("routes").doc(routeNumber).collection("stoppages").snapshots(),
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


Widget _buildConsumer(QuerySnapshot data) {
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
                //Navigator.of(context).push(MaterialPageRoute(builder: (_) => ViewRoute( routeNumber: data.docs[index]["routeNumber"],)));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRow("Route Label :", data.docs[index]["stoppageLabel"]),
                ],
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => EditBusInventory(
                //       capacity: data.docs[index]["capacity"],
                //       driverPhone: data.docs[index]["driverPhone"],
                //       driverName: data.docs[index]["driverName"],
                //       isAc: data.docs[index]["isActive"] ,
                //       codeName: data.docs[index]["codename"],
                //       licence: data.docs[index]["licence"],
                //       uid: data.docs[index].id,
                //     ),
                //   ),
                // );
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

Widget RouteInfo(BuildContext context , DocumentSnapshot<Object?> routeInfo) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
        child : Column(
          children: [
            Text("Route Number ${routeInfo['routeNumber']}" , style: TextStyle(fontSize: 20),),
            Text("Route routeLabel : ${routeInfo['routeLabel']}"),
            Text("Route routeLatitude : ${routeInfo['routeLatitude']}"),
            Text("Route routeLongitude : ${routeInfo['routeLongitude']}"),
          ],
        )
    ),
  );
}

