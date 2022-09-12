import 'package:bitfest/view/routes/route.dart';
import 'package:bitfest/view/routes/upcomming_bus_schedule/schedule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../route_success.dart';

class UpdateUpcommingBusSchedule extends StatefulWidget {
  UpdateUpcommingBusSchedule({Key? key , required this.busCodeName , required this.routeName , required this.timeSlot , required this.capacity}) : super(key: key);
  String busCodeName ;
  String routeName ;
  String timeSlot ;
  String capacity ;

  @override
  State<UpdateUpcommingBusSchedule> createState() => _UpdateUpcommingBusScheduleState();
}

class _UpdateUpcommingBusScheduleState extends State<UpdateUpcommingBusSchedule> {

  TextEditingController routeNameController = TextEditingController();
  TextEditingController timeSlotController = TextEditingController();
  TextEditingController capacityController = TextEditingController();

  @override
  void dispose() {
    routeNameController.clear();
    timeSlotController.clear();
    capacityController.clear();
    super.dispose();
  }

  @override
  void initState() {
    routeNameController.text = widget.routeName;
    timeSlotController.text = widget.timeSlot;
    capacityController.text = widget.capacity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Bus Schedule'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {

                Navigator.of(context).push(MaterialPageRoute(builder: (_) => UpcommingBusSchedule() ));
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: routeNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Route Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: timeSlotController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Time Slot',
                ),
              ),
            ),



            ElevatedButton(onPressed: (){

              FirebaseFirestore.instance.collection("upcommingBusSchedule").doc(widget.busCodeName).update(
                {
                  "routeName": routeNameController.text ,
                  "timeSlot": timeSlotController.text,
                },
              );
              // FirebaseFirestore.instance.collection("routes").doc(routeNumberController.text).set(route);

              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RouteSuccess(successMessage: "Bus Schedule Updated Successfully",)));
            }, child: Text("Update"))

          ],
        ),
      ),
    );
  }
}
