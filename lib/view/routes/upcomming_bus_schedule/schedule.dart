import 'package:bitfest/view/routes/upcomming_bus_schedule/update_upcomming_bus_schedule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpcommingBusSchedule extends StatefulWidget {
  const UpcommingBusSchedule({Key? key}) : super(key: key);

  @override
  State<UpcommingBusSchedule> createState() => _UpcommingBusScheduleState();
}

class _UpcommingBusScheduleState extends State<UpcommingBusSchedule> {

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
        FirebaseFirestore.instance.collection('upcommingBusSchedule').snapshots().forEach((querySnapshot) {
          for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
            docSnapshot.reference.delete();
          }
        });

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcomming Bus Schedule'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => UpCommingBusSchedule()));
              },
              icon: Icon(Icons.add_card)),
          IconButton(
              onPressed: () {
                showAlertDialog(context);
              },
              icon: Icon(Icons.delete))
        ],
      ),

      body: Container(
        child: _upcommingBusSchedule(context),
      ),

    );
  }
}

Widget _upcommingBusSchedule (BuildContext context){
  return Container(
    child: StreamBuilder<QuerySnapshot>(
      stream:
      FirebaseFirestore.instance.collection("upcommingBusSchedule").snapshots(),
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


Widget _buildConsumer(QuerySnapshot data ) {
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

                  buildRow("Bus Code Name : ", data.docs[index]["busCodeName"]),
                  buildRow("Route No : ", data.docs[index]["routeName"]),
                  buildRow("Time Slot : ", data.docs[index]["timeSlot"]),
                  buildRow("Capacity : ", data.docs[index]["capacity"]),
                ],
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {

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
