import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/estimation_provider.dart';

class ResultPage extends StatefulWidget {
  ResultPage({Key? key, required this.timeSlot, required this.day})
      : super(key: key);
  String day;
  String timeSlot;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    await Provider.of<EstimatedProvider>(context, listen: false)
        .getData(day: widget.day, timeSlot: widget.timeSlot);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<EstimatedProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Calculated Demand",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 360.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Day : ${widget.day}",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Time Slot : ${widget.timeSlot}",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        width: 360.w,
                        height: 360.h,
                        margin: EdgeInsets.all(15.sp),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: const Offset(0, 7))
                          ],
                        ),
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemCount: 4,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {},
                                child: Container(
                                  width: 150.w,
                                  height: 180.h,
                                  margin: EdgeInsets.all(15.sp),
                                  decoration: BoxDecoration(
                                    color: Color(0xff425C5A),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                          offset: const Offset(0, 7))
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Route ${index + 1}",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 15.h),
                                      Text(
                                        index == 0
                                            ? pro.r1.toString()
                                            : index == 1
                                                ? pro.r2.toString()
                                                : index == 2
                                                    ? pro.r3.toString()
                                                    : pro.r4.toString(),
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      if (pro.r1 + pro.r2 + pro.r3 + pro.r4 > 740)
                        Text(
                          "Bus are out of capacity",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      buildText(pro.r1, "Route1"),
                      SizedBox(height: 5.h),
                      buildText(pro.r2, "Route2"),
                      SizedBox(height: 5.h),
                      buildText(pro.r3, "Route3"),
                      SizedBox(height: 5.h),
                      buildText(pro.r4, "Route4")
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Text buildText(int v1, String text1) {

    int value = 0;

    if(v1 == 0){
      value = 0;
    }
    else if(v1 <= 60 ){
      value = 1;
    } else if( v1 > 60 && v1 <= 100){
      value = 2;
    }  else if( v1 > 120 && v1 <= 180){
      value = 3;
    } else if( v1 > 180 && v1 <= 240){
      value = 4;
    }

    return Text("$text1  required bus $value",
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,

        ));
  }
}
