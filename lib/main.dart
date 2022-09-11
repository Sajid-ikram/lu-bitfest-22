import 'package:bitfest/providers/auth_provider.dart';
import 'package:bitfest/providers/profile_provider.dart';
import 'package:bitfest/public/custom_loading.dart';
import 'package:bitfest/view/auth/login.dart';
import 'package:bitfest/view/auth/verification.dart';
import 'package:bitfest/view/home.dart';
import 'package:bitfest/view/ikram/ikram.dart';
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

      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (context, child) {

          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'LU Bird',

              home: const Initial(),
              routes: {
                "home": (ctx) => const Home(),
                "route": (ctx) =>  const CustomRoute(),
                "ikram": (ctx) => const Ikram(),

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
        if (snapshot.data != null && snapshot.data!.emailVerified) {
          return const Home();
        }
        return snapshot.data == null
            ? const Login()
            : const Verification();
      },
    );
  }
}


