import 'package:flutter/material.dart';

class RouteSuccess extends StatefulWidget {
  RouteSuccess({Key? key , required this.successMessage}) : super(key: key);
  String successMessage;

  @override
  State<RouteSuccess> createState() => _RouteSuccessState();
}

class _RouteSuccessState extends State<RouteSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.successMessage),
      ),
    );
  }
}
