import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRoute extends StatefulWidget {
  const CustomRoute({Key? key}) : super(key: key);

  @override
  State<CustomRoute> createState() => _CustomRouteState();
}

class _CustomRouteState extends State<CustomRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('route'),
      ),
    );
  }
}

