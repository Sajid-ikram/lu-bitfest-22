import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewRoute extends StatefulWidget {
  ViewRoute({Key? key , required this.routeNumber}) : super(key: key);
  String routeNumber;

  @override
  State<ViewRoute> createState() => _ViewRouteState();
}

class _ViewRouteState extends State<ViewRoute> {
  
  bool isLoading = true;
  late DocumentSnapshot routeInfo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  
  Future<void> getData() async {
    routeInfo = await FirebaseFirestore.instance.collection('routes').doc(widget.routeNumber).get();
    setState(() {
      isLoading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Route Number ${widget.routeNumber}"),),
      body: Center(
        child: Column(
            children : [

            isLoading ? CircularProgressIndicator() : RouteInfo(context,routeInfo),

              ElevatedButton(onPressed: (){
                //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddRoutes()));
              }, child: Text("Update Route")),
              ElevatedButton(onPressed: (){
                //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddRoutes()));
              }, child: Text("Add Stoppage")),
              ElevatedButton(onPressed: (){
                //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> UpdateRoutes()));
              }, child: Text("Update Stopage")),
            ]
        ),
      ),
    );
  }
}

  Widget RouteInfo(BuildContext context , DocumentSnapshot<Object?> routeInfo) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      child : Column(
        children: [
          Text("Route Number ${routeInfo['routeNumber']}" , style: TextStyle(fontSize: 20),),
          Text("Route routeLabel : ${routeInfo['routeLabel']}"),
          Text("Route routeLatitude : ${routeInfo['routeLatitude']}"),
          Text("Route routeLongitude : ${routeInfo['routeLongitude']}"),
        ],
      )
    ),
  );
}
