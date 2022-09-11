import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

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
              onPressed: () {
                Navigator.pushNamed(context, "ikram");
              },
              child: Text("Ikram")),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "route");
              },
              child: Text("dipon")),
          TextButton(
              onPressed: () {
                Provider.of<Authentication>(context,listen: false).signOut();
              },
              child: Text("logout")),
        ],
      ),
    );
  }
}
