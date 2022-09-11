import 'package:bitfest/providers/bus_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../public/custom_loading.dart';

class RequestSeat extends StatefulWidget {
  const RequestSeat({Key? key}) : super(key: key);

  @override
  State<RequestSeat> createState() => _RequestSeatState();
}

class _RequestSeatState extends State<RequestSeat> {
  int route = 2;
  int slot = 8;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  validate() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (_formKey.currentState!.validate()) {
      try {
        buildLoadingIndicator(context);
        FirebaseFirestore.instance.collection("request").doc().set(
          {
            "route": route,
            "slot": slot,
            "uid": user!.uid,
          },
        );
        Navigator.of(context, rootNavigator: true).pop();
        snackBar(context, "Success");

      } catch (e) {
        Navigator.of(context, rootNavigator: true).pop();
        snackBar(context, "Some error occur");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: Text('Seat Request'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: 800.h,
          width: 360.w,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60.h),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      Text(
                        "Route :",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 70.h,
                        width: 360.w,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  route = 1;
                                });
                              },
                              child: buildContainer(
                                  route == 1 ? Colors.black : Colors.grey,
                                  route == 1 ? Colors.white : Colors.black,
                                  50,
                                  '1'),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  route = 2;
                                });
                              },
                              child: buildContainer(
                                  route == 2 ? Colors.black : Colors.grey,
                                  route == 2 ? Colors.white : Colors.black,
                                  50,
                                  '2'),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  route = 3;
                                });
                              },
                              child: buildContainer(
                                  route == 3 ? Colors.black : Colors.grey,
                                  route == 3 ? Colors.white : Colors.black,
                                  50,
                                  '3'),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  route = 4;
                                });
                              },
                              child: buildContainer(
                                  route == 4 ? Colors.black : Colors.grey,
                                  route == 4 ? Colors.white : Colors.black,
                                  50,
                                  '4'),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Slot :",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 70.h,
                        width: 360.w,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  slot = 8;
                                });
                              },
                              child: buildContainer(
                                  slot == 8 ? Colors.black : Colors.grey,
                                  slot == 8 ? Colors.white : Colors.black,
                                  50,
                                  '8am'),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  slot = 9;
                                });
                              },
                              child: buildContainer(
                                  slot == 9 ? Colors.black : Colors.grey,
                                  slot == 9 ? Colors.white : Colors.black,
                                  50,
                                  '9am'),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  slot = 10;
                                });
                              },
                              child: buildContainer(
                                  slot == 10 ? Colors.black : Colors.grey,
                                  slot == 10 ? Colors.white : Colors.black,
                                  50,
                                  '10am'),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  slot = 11;
                                });
                              },
                              child: buildContainer(
                                  slot == 11 ? Colors.black : Colors.grey,
                                  slot == 11 ? Colors.white : Colors.black,
                                  50,
                                  '11am'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 70.h,
                        width: 360.w,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  slot = 12;
                                });
                              },
                              child: buildContainer(
                                  slot == 12 ? Colors.black : Colors.grey,
                                  slot == 12 ? Colors.white : Colors.black,
                                  50,
                                  '12pm'),
                            ),
                            SizedBox(width: 35.w),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  slot = 1;
                                });
                              },
                              child: buildContainer(
                                  slot == 1 ? Colors.black : Colors.grey,
                                  slot == 1 ? Colors.white : Colors.black,
                                  50,
                                  '1pm'),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 17.h),
                GestureDetector(
                  onTap: () {
                    print(now.hour);
                    if (now.hour > slot) {
                      snackBar(context, "Selected Slot is not available");
                    }

                    validate();
                  },
                  child: Container(
                    height: 50.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    child: Center(
                      child: Text(
                        "Request",
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildContainer(
      Color btnColor, Color textColor, double width, String value) {
    return Container(
      height: 50.h,
      width: width.w,
      decoration: BoxDecoration(
        color: btnColor,
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Center(
          child: Text(
        value,
        style: TextStyle(
          color: textColor,
          fontSize: 14.sp,
        ),
      )),
    );
  }
}

Container customTextField(TextEditingController controller, String text,
    BuildContext context, IconData iconData) {
  return Container(
    height: 50.h,
    width: 340.w,
    padding: EdgeInsets.fromLTRB(10, 2, 10, 0),
    decoration: BoxDecoration(
      color: const Color(0xffC4C4C4).withOpacity(0.2),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: TextFormField(
          controller: controller,
          keyboardAppearance: Brightness.light,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              snackBar(context, "Field can not be empty!");
              return "Field can not be empty!";
            }
            return null;
          },
          decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 0.01),
            filled: true,
            fillColor: Colors.transparent,
            border: InputBorder.none,
            hintText: text,
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 14.sp,
            ),
          )),
    ),
  );
}

snackBar(BuildContext context, String text) {
  final snackBar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
