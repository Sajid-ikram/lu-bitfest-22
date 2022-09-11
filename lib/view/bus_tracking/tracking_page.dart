import 'package:bitfest/view/bus_tracking/gps_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../providers/map_provider.dart';
import '../bus/addBusInventory.dart';
import 'custom_map.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({Key? key}) : super(key: key);

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('GPS SEtting'),
          ),
          TextButton(
              onPressed: () async {
                bool result = await requestLocationPermission();
                if (result) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CustomMap()));
                } else {
                  snackBar(context, "Location is not granted");
                }
              },
              child: Text("track location")),

          TextButton(
              onPressed: () async {
                bool result = await requestLocationPermission();
                if (result) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const GPSSetting()));
                } else {
                  snackBar(context, "Location is not granted");
                }
              },
              child: Text("give location")),


        ],
      ),
    );
  }
}
