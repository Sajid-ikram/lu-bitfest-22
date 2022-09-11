import 'package:bitfest/view/bus_tracking/tracking_page.dart';
import 'package:bitfest/view/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/map_provider.dart';
import 'auth/login.dart';
import 'bus/addBusInventory.dart';
import 'bus_tracking/custom_map.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "route");
              },
              child: Text("dipon")),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ),
                );
              },
              child: Text("profile")),
          TextButton(
              onPressed: () {
                Provider.of<Authentication>(context, listen: false).signOut();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ),
                );
              },
              child: Text("logout")),
        ],
      ),
    );
  }
}
