import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ikram extends StatefulWidget {
  const Ikram({Key? key}) : super(key: key);

  @override
  State<Ikram> createState() => _IkramState();
}

class _IkramState extends State<Ikram> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('ikram'),
      ),
    );
  }
}
