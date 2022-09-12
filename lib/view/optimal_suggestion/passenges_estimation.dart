import 'package:bitfest/providers/estimation_provider.dart';
import 'package:bitfest/view/optimal_suggestion/select_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PassengerEstimation extends StatefulWidget {
  const PassengerEstimation({Key? key}) : super(key: key);

  @override
  State<PassengerEstimation> createState() => _PassengerEstimationState();
}

class _PassengerEstimationState extends State<PassengerEstimation> {
  @override
  void initState() {
    //Provider.of<EstimatedProvider>(context,listen: false).getData();
    super.initState();
  }

  List<String> days = [
    "SUNDAY",
    "Monday",
    "TUESDAY",
    "WEDNESDAY",
    "THURSDAY",
    "SATURDAY",
    "FRIDAY",
    "SATURDAY",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select Day",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: ListView.builder(
        itemCount: days.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => SelectTimeSlot(
                        name: days[index],
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
                  days[index],
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