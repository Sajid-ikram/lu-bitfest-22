import 'package:bitfest/providers/auth_provider.dart';
import 'package:bitfest/providers/bus_provider.dart';
import 'package:bitfest/providers/map_provider.dart';
import 'package:bitfest/providers/pdf_and_notification_provider.dart';
import 'package:bitfest/providers/profile_provider.dart';
import 'package:bitfest/public/custom_loading.dart';
import 'package:bitfest/view/auth/login.dart';
import 'package:bitfest/view/auth/verification.dart';
import 'package:bitfest/view/bus/addBusInventory.dart';
import 'package:bitfest/view/bus/bus.dart';
import 'package:bitfest/view/home.dart';
import 'package:bitfest/view/profile/update_profile_info.dart';
import 'package:bitfest/view/routes/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,

      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Authentication()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => BusProvider()),
        ChangeNotifierProvider(create: (_) => MapProvider()),
        ChangeNotifierProvider(create: (_) => PDFAndNotificationProvider()),

      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (context, child) {

          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'bitfest',

              home: const Initial(),
              routes: {
                "home": (ctx) => const Home(),
                "route": (ctx) =>  const CustomRoute(),
                "ikram": (ctx) => const AllBuses(),
                "AddBusInventory": (ctx) => const AddBusInventory(),
                "UpdateProfileInfo": (ctx) => const UpdateProfileInfo(),

              });
        },
      ),
    );
  }
}

class Initial extends StatefulWidget {
  const Initial({Key? key}) : super(key: key);

  @override
  State<Initial> createState() => _InitialState();
}

class _InitialState extends State<Initial> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(body: Center(child: Text("Error")));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return const MiddleOfHomeAndSignIn();
        }
        return const Scaffold(body: Center(child: Text("Something Went Wrong")));
      },
    );
  }
}


class MiddleOfHomeAndSignIn extends StatefulWidget {
  const MiddleOfHomeAndSignIn({Key? key}) : super(key: key);

  @override
  _MiddleOfHomeAndSignInState createState() => _MiddleOfHomeAndSignInState();
}

class _MiddleOfHomeAndSignInState extends State<MiddleOfHomeAndSignIn> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false).getUserInfo();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream:
      FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildLoadingWidget();
        }
        if (snapshot.data != null) {
          return const Home();
        }
        return  const LogIn();

      },
    );
  }
}


