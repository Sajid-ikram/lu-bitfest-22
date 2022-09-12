import 'package:bitfest/view/routes/upcomming_bus_schedule/update_upcomming_bus.dart';
import 'package:bitfest/view/routes/upcomming_bus_schedule/update_upcomming_bus_schedule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../providers/profile_provider.dart';

class RequestList extends StatefulWidget {
  const RequestList({Key? key}) : super(key: key);

  @override
  State<RequestList> createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {

  showAlertDialog(BuildContext context) {

    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Delete"),
      onPressed:  () {



        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Are you sure to delete"),
      content: Text("This will clear the bus schedule for upcomming hours"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    var pro = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Requests'),
        backgroundColor: Colors.black,
        actions: [
          if(pro.role == "Staff")
            IconButton(
                onPressed: () {
                  //Navigator.of(context).push(MaterialPageRoute(builder: (_) => UpCommingBusSchedule()));
                },
                icon: Icon(Icons.add_card)),
          if(pro.role == "Staff")
            IconButton(
                onPressed: () {
                  showAlertDialog(context);
                },
                icon: Icon(Icons.delete))
        ],
      ),

      body: Container(
        child: _reqList(context , pro),
      ),

    );
  }
}

Widget _reqList(BuildContext context , ProfileProvider pro){
  return Container(
    child: StreamBuilder<QuerySnapshot>(
      stream:
      FirebaseFirestore.instance.collection("request").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final data = snapshot.data;

        return _buildConsumer(data!,pro);
      },
    ),
  );
}


Widget _buildConsumer(QuerySnapshot data ,ProfileProvider pro ) {
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
                //Navigator.of(context).push(MaterialPageRoute(builder: (_) => Upa( routeNumber: data.docs[index]["routeNumber"],)));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  buildRow(context , "UID : ", data.docs[index]["uid"]),
                  buildRow(context ,"Route No : ", data.docs[index]["route"].toString()),
                  buildRow(context ,"Time Slot : ", data.docs[index]["slot"].toString()),
                ],
              ),
            ),
            Spacer(),
            if(pro.role == "Staff")
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => UpdateUpcommingBusSchedule( busCodeName : data.docs[index]["busCodeName"] , routeName : data.docs[index]["routeName"], timeSlot : data.docs[index]["timeSlot"], capacity : data.docs[index]["capacity"])));
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

Row buildRow(BuildContext context , String text1, String text2) {
  return Row(
    children: [
      Text(
        text1,
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
      ),
      Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Text(
              text2,
              style: TextStyle(
                fontSize: 15.sp,
                decoration:
                text1 == "Contact : " ? TextDecoration.underline : null,
              ),
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
