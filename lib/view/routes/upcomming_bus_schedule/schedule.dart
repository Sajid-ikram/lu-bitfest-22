import 'package:flutter/material.dart';

class UpcommingBusSchedule extends StatefulWidget {
  const UpcommingBusSchedule({Key? key}) : super(key: key);

  @override
  State<UpcommingBusSchedule> createState() => _UpcommingBusScheduleState();
}

class _UpcommingBusScheduleState extends State<UpcommingBusSchedule> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcomming Bus Schedule'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {

              },
              icon: Icon(Icons.add))
        ],
      ),

      body: Container(
        child: Column(
          children: [

          ],
        ),
      ),

    );
  }
}
