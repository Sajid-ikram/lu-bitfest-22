import 'package:bitfest/view/routes/upcomming_bus_schedule/view_temp_schedule.dart';
import 'package:flutter/material.dart';

class MakeBusSchedule extends StatefulWidget {
  MakeBusSchedule({Key? key , required this.busList , required this.busCapacityList}) : super(key: key);
  
  List<String> busList;
  List<String> busCapacityList;

  @override
  State<MakeBusSchedule> createState() => _MakeBusScheduleState();
}

class _MakeBusScheduleState extends State<MakeBusSchedule> {

  @override
  Widget build(BuildContext context) {

    List<TextEditingController> _routeControllers = [];
    List<TextEditingController> _timeControllers = [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Enter information'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => ViewTempSchedule(timeControllers: _timeControllers, routeControllers: _routeControllers, busList: widget.busList, busCapacityList: widget.busCapacityList,)));
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: ListView.builder(
        // the number of items in the list
          itemCount: widget.busList.length,

          // display each item of the product list
          itemBuilder: (context, index) {

            _routeControllers.add(new TextEditingController());
            _timeControllers.add(new TextEditingController());

            return Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text("${index+1} . ${widget.busList[index]}" , style: TextStyle(fontSize: 20),),
                  Text("Capacity : ${widget.busCapacityList[index]}" , style: TextStyle(fontSize: 15),),

                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      controller: _routeControllers[index],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter route number',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      controller: _timeControllers[index],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter starting time',
                      ),
                    ),
                  ),
                  
                ],
              ),
            );
          })
    );
  }
}
