import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart' as loc;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import '../../providers/map_provider.dart';
import '../../public/custom_loading.dart';
import '../bus/addBusInventory.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({Key? key}) : super(key: key);

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  final loc.Location location = loc.Location();
  bool isIconSelected = false;
  bool _added = false;
  StreamSubscription<loc.LocationData>? _locationSub;
  late GoogleMapController _controller;

  Uint8List? userLocationIcon;
  Uint8List? busLocationIcon;
  CameraPosition? userCameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMarkers();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _locationSub!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MapProvider>(context, listen: false);
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("location").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildLoadingWidget();
          }

          final data = snapshot.data;

          if (data != null && data.docs.isEmpty) {
            return const SizedBox();
          } else {
            return isIconSelected
                ? Consumer<MapProvider>(
                    builder: (BuildContext context, value, Widget? child) {
                      return buildGoogleMap(snapshot, pro);
                    },
                  )
                : buildLoadingWidget();
          }
        },
      ),
    );
  }

  GoogleMap buildGoogleMap(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, MapProvider pro) {
    print("----------------------------------");
    return GoogleMap(

      zoomGesturesEnabled: true,
      zoomControlsEnabled: true,
      onCameraMove: (CameraPosition cameraPosition) {
        userCameraPosition = cameraPosition;
      },

      initialCameraPosition: CameraPosition(
        target: pro.userLocation == null
            ? const LatLng(24.89489077447926, 91.86879280019157)
            : LatLng(pro.userLocation!.latitude!, pro.userLocation!.longitude!),
        zoom: 15,
      ),
      mapType: MapType.normal,
      markers: Set<Marker>.of(
        snapshot.data!.docs.map(
          (element) {
            return element['name'] != "forUserLocation"
                ? Marker(
                    position: LatLng(element['latitude'], element['longitude']),
                    markerId: MarkerId(element.id),
                    infoWindow: const InfoWindow(
                      title: "Route 1",
                    ),
                    icon: BitmapDescriptor.fromBytes(busLocationIcon!),
                  )
                : Marker(
                    position: pro.userLocation == null
                        ? const LatLng(24.89489077447926, 91.86879280019157)
                        : LatLng(pro.userLocation!.latitude!,
                            pro.userLocation!.longitude!),
                    markerId: MarkerId(element.id),
                    icon: BitmapDescriptor.fromBytes(userLocationIcon!),
                  );
          },
        ),
      ),
      onMapCreated: (GoogleMapController controller) async {
        if (!_added) {
          _controller = controller;
          _added = true;
          _onUserLocationChange(pro);
        }
      },
    );
  }

  Future<void> changeMyMap(MapProvider pro) async {
    await _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: userCameraPosition == null
              ? pro.userLocation == null
                  ? const LatLng(24.89489077447926, 91.86879280019157)
                  : LatLng(
                      pro.userLocation!.latitude!, pro.userLocation!.longitude!)
              : userCameraPosition!.target,
          zoom: userCameraPosition == null ? 15 : userCameraPosition!.zoom,
          tilt: userCameraPosition == null ? 0 : userCameraPosition!.tilt,
          bearing: userCameraPosition == null ? 0 : userCameraPosition!.bearing,
        ),
      ),
    );
  }

  getMarkers() async {
    userLocationIcon = await getBytesFromAssets("assets/user.png", 100);
    busLocationIcon = await getBytesFromAssets("assets/bus.png", 80);

    if (userLocationIcon != null && busLocationIcon != null) {
      setState(() {
        isIconSelected = true;
      });
    } else {
      return snackBar(context, "Something Went Wrong");
    }
  }

  Future<void> _onUserLocationChange(MapProvider pro) async {
    _locationSub = location.onLocationChanged.handleError((onError) {
      _locationSub!.cancel();
      setState(() {
        _locationSub = null;
      });
    }).listen((loc.LocationData currentLocation) async {
      pro.userLocation = currentLocation;
      if (mounted) {
        Provider.of<MapProvider>(context, listen: false).onLocationChange();
      }

      changeMyMap(pro);
    });
  }

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
