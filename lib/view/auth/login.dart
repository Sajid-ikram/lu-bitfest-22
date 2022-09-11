import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('login'),
          ),
          TextButton(onPressed: () {
            Navigator.pushNamed(context, "ikram");
          }, child: Text("Ikram")),

          TextButton(onPressed: () {
            Navigator.pushNamed(context, "route");
          }, child: Text("dipon")),
        ],
      ),
    );
  }
}