import 'package:bitfest/view/routes/add_routes.dart';
import 'package:bitfest/view/routes/update_routes.dart';
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
      appBar: AppBar(title: Text("Routes"),),
      body: Center(
        child: Container(
          child: Column(
            children : [
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddRoutes()));
              }, child: Text("Add Routes")),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> UpdateRoutes()));
              }, child: Text("Update Routes")),
            ]
          ),
        ),
      ),
    );
  }
}

