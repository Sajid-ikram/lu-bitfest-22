import 'package:bitfest/view/routes/route_success.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateRoute extends StatefulWidget {
  UpdateRoute({Key? key , required this.routeNumber , required this.routeLabel , required this.routeLatitude , required this.routeLongitude , required this.startTime}) : super(key: key);

  String routeNumber;
  String routeLabel;
  String routeLatitude;
  String routeLongitude;
  String startTime;

  @override
  State<UpdateRoute> createState() => _UpdateRouteState();
}

class _UpdateRouteState extends State<UpdateRoute> {

  TextEditingController routeNumberController = TextEditingController();
  TextEditingController labelController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();

  @override
  void dispose() {
    routeNumberController.clear();
    labelController.clear();
    latitudeController.clear();
    longitudeController.clear();
    startTimeController.clear();
    super.dispose();
  }

  @override
  void initState() {
    routeNumberController.text = widget.routeNumber;
    labelController.text = widget.routeLabel;
    latitudeController.text = widget.routeLatitude;
    longitudeController.text = widget.routeLatitude;
    startTimeController.text = widget.startTime;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Routes"),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [

            TextField(
              controller: routeNumberController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter route number',
              ),
            ),
            Text("Start Location"),
            TextField(
              controller: labelController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Label',
              ),
            ),
            TextField(
              controller: latitudeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Latitude',
              ),
            ),
            TextField(
              controller: longitudeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Longitude',
              ),
            ),
            TextField(
              controller: startTimeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Start time',
              ),
            ),

            ElevatedButton(onPressed: (){


              FirebaseFirestore.instance.collection("routes").doc(widget.routeNumber).update(
                {
                  "routeNumber": routeNumberController.text,
                  "routeLabel": labelController.text ,
                  "routeLatitude": latitudeController.text,
                  "routeLongitude": longitudeController.text,
                  "startTime": startTimeController.text,
                },
              );
              // FirebaseFirestore.instance.collection("routes").doc(routeNumberController.text).set(route);

              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RouteSuccess(successMessage: "Route Updated Successfully",)));
            }, child: Text("Add"))

          ],
        ),
      ),
    );
  }
}
