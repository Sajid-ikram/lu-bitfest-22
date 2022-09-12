import 'package:bitfest/providers/estimation_provider.dart';
import 'package:bitfest/view/optimal_suggestion/result.dart';
import 'package:bitfest/view/optimal_suggestion/select_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SelectTimeSlot extends StatefulWidget {
  SelectTimeSlot({Key? key, required this.name}) : super(key: key);
  String name;

  @override
  State<SelectTimeSlot> createState() => _SelectTimeSlotState();
}

class _SelectTimeSlotState extends State<SelectTimeSlot> {
  @override
  void initState() {
    //Provider.of<EstimatedProvider>(context,listen: false).getData();
    super.initState();
  }

  List<String> timeSlot = [
    "08:55-9:45AM",
    "9:50-10:40AM",
    "10:45-11:35AM",
    "11:40-12:30PM",
    "12:35-1:25PM",
    "1:30-2:10PM",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select Time Slot",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: ListView.builder(
        itemCount: timeSlot.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
               Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ResultPage(
                    day: widget.name,
                    timeSlot: timeSlot[index],
                  )));
            },
            child: Container(
              height: 50.h,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: Center(
                child: Text(
                  timeSlot[index],
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
