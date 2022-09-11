import 'package:bitfest/view/routes/models/route_model.dart';
import 'package:bitfest/view/routes/route_success.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddRoutes extends StatefulWidget {
  const AddRoutes({Key? key}) : super(key: key);

  @override
  State<AddRoutes> createState() => _AddRoutesState();
}

class _AddRoutesState extends State<AddRoutes> {

  TextEditingController routeNumberController = TextEditingController();
  TextEditingController labelController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();


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

              FirebaseFirestore.instance.collection("routes").doc(routeNumberController.text).set(
                {
                  "routeNumber": routeNumberController.text,
                  "routeLabel": labelController.text ,
                  "routeLatitude": latitudeController.text,
                  "routeLongitude": longitudeController.text,
                  "startTime": startTimeController.text,

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
