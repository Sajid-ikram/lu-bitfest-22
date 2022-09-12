import 'package:bitfest/view/routes/request_list.dart';
import 'package:bitfest/view/routes/route.dart';
import 'package:bitfest/view/routes/upcomming_bus_schedule/schedule.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/profile_provider.dart';
import 'csv/go_csv.dart';

class RoutesDashBoard extends StatefulWidget {
  const RoutesDashBoard({Key? key}) : super(key: key);

  @override
  State<RoutesDashBoard> createState() => _RoutesDashBoardState();
}

class _RoutesDashBoardState extends State<RoutesDashBoard> {
  @override
  Widget build(BuildContext context) {

    var pro = Provider.of<ProfileProvider>(context);

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
          if(pro.role == "Staff")
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => GOCSV()));
              },
              child: Container(
                decoration: BoxDecoration( borderRadius: BorderRadius.circular(20) , color: Color(0xff425C5A),),
                width: double.infinity ,
                height: 100,
                child: Center(
                  child: Text("Update Automation Database" , style : TextStyle(fontSize: 18 , color: Colors.white)),
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
                decoration: BoxDecoration( borderRadius: BorderRadius.circular(20) , color: Color(0xff425C5A),),
                width: double.infinity ,
                height: 100,
                child: Center(
                  child: Text("Upcomming Bus - Schedule" , style : TextStyle(fontSize: 18 , color: Colors.white)),
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
                decoration: BoxDecoration( borderRadius: BorderRadius.circular(20) , color: Color(0xff425C5A),),
                width: double.infinity ,
                height: 100,
                child: Center(
                  child: Text("View Routes" , style : TextStyle(fontSize: 18 , color: Colors.white)),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => RequestList()));
              },
              child: Container(
                decoration: BoxDecoration( borderRadius: BorderRadius.circular(20) , color: Color(0xff425C5A),),
                width: double.infinity ,
                height: 100,
                child: Center(
                  child: Text("Pending Requests" , style : TextStyle(fontSize: 18 , color: Colors.white)),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
