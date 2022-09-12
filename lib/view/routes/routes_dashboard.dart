import 'package:bitfest/view/routes/route.dart';
import 'package:bitfest/view/routes/upcomming_bus_schedule/schedule.dart';
import 'package:flutter/material.dart';

import 'csv/go_csv.dart';

class RoutesDashBoard extends StatefulWidget {
  const RoutesDashBoard({Key? key}) : super(key: key);

  @override
  State<RoutesDashBoard> createState() => _RoutesDashBoardState();
}

class _RoutesDashBoardState extends State<RoutesDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dashboard",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => GOCSV()));
              },
              child: Container(
                color: Colors.blueGrey.withOpacity(0.2),
                width: double.infinity ,
                height: 100,
                child: Center(
                  child: Text("Update Automation Database" , style : TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => UpcommingBusSchedule()));
              },
              child: Container(
                color: Colors.blueGrey.withOpacity(0.2),
                width: double.infinity ,
                height: 100,
                child: Center(
                  child: Text("Live Bus Schedule" , style : TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => CustomRoute()));
              },
              child: Container(
                color: Colors.blueGrey.withOpacity(0.2),
                width: double.infinity ,
                height: 100,
                child: Center(
                  child: Text("Update Automation Database" , style : TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}