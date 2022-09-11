import 'package:bitfest/view/routes/route_success.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddStoppage extends StatefulWidget {
  AddStoppage({Key? key , required this.routeNumber}) : super(key: key);

  String routeNumber;

  @override
  State<AddStoppage> createState() => _AddStoppageState();
}

class _AddStoppageState extends State<AddStoppage> {

  TextEditingController labelController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Stoppage to Route No ${widget.routeNumber}"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [

            TextField(
              controller: labelController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Stoppage Label',
              ),
            ),
            Divider(height: 3,),
            TextField(
              controller: latitudeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Latitude',
              ),
            ),
            Divider(height: 3,),
            TextField(
              controller: longitudeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Longitude',
              ),
            ),

            ElevatedButton(onPressed: (){

              FirebaseFirestore.instance.collection("routes").doc(widget.routeNumber).collection("stoppages").doc(labelController.text).set(
                {
                  "stoppageLabel": labelController.text ,
                  "stoppageLatitude": latitudeController.text,
                  "stoppageLongitude": longitudeController.text,

                },
              );
              // FirebaseFirestore.instance.collection("routes").doc(routeNumberController.text).set(route);

              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RouteSuccess(successMessage: "Route Added Successfully",)));
            }, child: Text("Add"))

          ],
        ),
      ),
    );
  }
}
