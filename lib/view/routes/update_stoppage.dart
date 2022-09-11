import 'package:bitfest/view/routes/route_success.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateStoppage extends StatefulWidget {
  UpdateStoppage({Key? key , required this.routeNumber,required this.stoppageLabel , required this.stoppageLatitude , required this.stoppageLongitude}) : super(key: key);
  String routeNumber;
  String stoppageLabel;
  String stoppageLatitude;
  String stoppageLongitude;

  @override
  State<UpdateStoppage> createState() => _UpdateStoppageState();
}

class _UpdateStoppageState extends State<UpdateStoppage> {

  TextEditingController labelController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();

  @override
  void dispose() {
    labelController.clear();
    latitudeController.clear();
    longitudeController.clear();
    super.dispose();
  }

  @override
  void initState() {
    labelController.text = widget.stoppageLabel;
    latitudeController.text = widget.stoppageLatitude;
    longitudeController.text = widget.stoppageLongitude;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Stoppage"),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [

            TextField(
              controller: labelController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter stoppage label',
              ),
            ),
            TextField(
              controller: latitudeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter stoppage Latitude',
              ),
            ),
            TextField(
              controller: longitudeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter stoppage Longitude',
              ),
            ),


            ElevatedButton(onPressed: (){


              FirebaseFirestore.instance.collection("routes").doc(widget.routeNumber).collection("stoppages").doc(widget.stoppageLabel).update(
                {
                  "stoppageLabel": labelController.text,
                  "stoppageLatitude": latitudeController.text ,
                  "stoppageLongitude": longitudeController.text,
                },
              );
              // FirebaseFirestore.instance.collection("routes").doc(routeNumberController.text).set(route);

              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RouteSuccess(successMessage: "Stoppage Updated Successfully",)));
            }, child: Text("Update"))

          ],
        ),
      ),
    );
  }
}
