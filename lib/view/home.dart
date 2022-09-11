import 'package:bitfest/view/optimal_suggestion/passenges_estimation.dart';
import 'package:bitfest/view/profile/profile.dart';
import 'package:bitfest/view/seat_request/seat_request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../providers/map_provider.dart';
import 'bus_and_class_routine/bus_and_routine.dart';
import 'bus_tracking/custom_map.dart';
import 'bus_tracking/gps_settings.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<IconData> icons = [
    Icons.map,
    Icons.share,
    Icons.book_online,
    Icons.calendar_month,
    Icons.calendar_today_outlined,
    Icons.calculate_outlined,
  ];
  List<String> titles = [
    "Track Bus",
    "Enable Tracking",
    "Request Seat",
    "Bus Schedule",
    "Class Routine",
    "Estimate",
  ];

  Future<bool> requestLocationPermission() async {
    /// status can either be: granted, denied, restricted or permanentlyDenied
    var status = await Permission.location.status;
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      if (await Permission.location.request().isGranted) {
        // Either the permission was already granted before or the user just granted it.
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  getLocation() async {
    bool result = await requestLocationPermission();
    if (result) {
      if (mounted) {
        Provider.of<MapProvider>(context, listen: false)
            .getUserCurrentLocation();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: icons.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  if (index == 0) {
                    bool result = await requestLocationPermission();
                    if (result) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CustomMap()));
                    } else {
                      snackBar(context, "Location is not granted");
                    }
                  } else if (index == 1) {
                    bool result = await requestLocationPermission();
                    if (result) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const GPSSetting()));
                    } else {
                      snackBar(context, "Location is not granted");
                    }
                  } else if (index == 2) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => RequestSeat()));
                  } else if (index == 3) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BusSchedule(
                              name: 'Bus Schedule',
                            )));
                  } else if (index == 4) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BusSchedule(
                              name: 'Routine',
                            )));
                  } else if (index == 5) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PassengerEstimation()));
                  }
                },
                child: Container(
                  width: 150.w,
                  height: 180.h,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icons[index],
                        size: 50.sp,
                        color: Colors.white,
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        titles[index],
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

snackBar(BuildContext context, String text) {
  final snackBar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

/*body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('login'),
          ),
          TextButton(
              onPressed: ()  {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TrackingPage()));
              },
              child: Text("Ikram")),



        ],
      ),*/
