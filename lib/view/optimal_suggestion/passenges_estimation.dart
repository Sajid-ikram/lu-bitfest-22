import 'package:bitfest/providers/estimation_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PassengerEstimation extends StatefulWidget {
  const PassengerEstimation({Key? key}) : super(key: key);

  @override
  State<PassengerEstimation> createState() => _PassengerEstimationState();
}

class _PassengerEstimationState extends State<PassengerEstimation> {


  @override
  void initState() {
    Provider.of<EstimatedProvider>(context,listen: false).getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Estimate"),
      ),
    );
  }
}
