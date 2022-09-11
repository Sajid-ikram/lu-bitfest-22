import 'package:bitfest/view/routes/upcomming_bus_schedule/schedule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewTempSchedule extends StatefulWidget {

  ViewTempSchedule({Key? key , required this.busList , required this.busCapacityList , required this.routeControllers , required this.timeControllers}) : super(key: key);

  List<String> busList;
  List<String> busCapacityList;
  List<TextEditingController> routeControllers ;
  List<TextEditingController> timeControllers ;

  @override
  State<ViewTempSchedule> createState() => _ViewTempScheduleState();
}

class _ViewTempScheduleState extends State<ViewTempSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout final information'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {

                for(int i=0 ; i < widget.busList.length ; i++ ){
                  FirebaseFirestore.instance.collection("upcommingBusSchedule").doc(widget.busList[i]).set(
                    {
                      "busCodeName": widget.busList[i],
                      "routeName": widget.routeControllers[i].text ,
                      "timeSlot": widget.timeControllers[i].text,
                      "capacity": widget.busCapacityList[i],

                    },
                  );
                }

                Navigator.of(context).push(MaterialPageRoute(builder: (_) => UpcommingBusSchedule()));
              },
              icon: Icon(Icons.check)),
        ],
      ),
      body : ListView.builder(
        // the number of items in the list
          itemCount: widget.busList.length,

          // display each item of the product list
          itemBuilder: (context, index) {



            return Container(
              padding: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Bus Code Name : ${widget.busList[index]}" , style: TextStyle(fontSize: 20),),
                    Text("Route Number : ${widget.routeControllers[index].text}" , style: TextStyle(fontSize: 18),),
                    Text("Time Slot : ${widget.timeControllers[index].text}" , style: TextStyle(fontSize: 17),),
                    Text("Capacity : ${widget.busCapacityList[index]}" , style: TextStyle(fontSize: 17),),

                  ],
                ),
              ),
            );
          }),
    );
  }
}
