import 'package:bitfest/providers/bus_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../public/custom_loading.dart';

class ManualDemandInput extends StatefulWidget {
  const ManualDemandInput({Key? key}) : super(key: key);

  @override
  State<ManualDemandInput> createState() => _ManualDemandInputState();
}

class _ManualDemandInputState extends State<ManualDemandInput> {
  TextEditingController r1Demand8 = TextEditingController();
  TextEditingController r1Demand9 = TextEditingController();
  TextEditingController r1Demand10 = TextEditingController();
  TextEditingController r1Demand11 = TextEditingController();
  TextEditingController r1Demand12 = TextEditingController();
  TextEditingController r1Demand1 = TextEditingController();

  TextEditingController r2Demand8 = TextEditingController();
  TextEditingController r2Demand9 = TextEditingController();
  TextEditingController r2Demand10 = TextEditingController();
  TextEditingController r2Demand11 = TextEditingController();
  TextEditingController r2Demand12 = TextEditingController();
  TextEditingController r2Demand1 = TextEditingController();

  TextEditingController r3Demand8 = TextEditingController();
  TextEditingController r3Demand9 = TextEditingController();
  TextEditingController r3Demand10 = TextEditingController();
  TextEditingController r3Demand11 = TextEditingController();
  TextEditingController r3Demand12 = TextEditingController();
  TextEditingController r3Demand1 = TextEditingController();

  TextEditingController r4Demand8 = TextEditingController();
  TextEditingController r4Demand9 = TextEditingController();
  TextEditingController r4Demand10 = TextEditingController();
  TextEditingController r4Demand11 = TextEditingController();
  TextEditingController r4Demand12 = TextEditingController();
  TextEditingController r4Demand1 = TextEditingController();

  bool isActive = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    r1Demand8.clear();
    r1Demand9.clear();
    r1Demand10.clear();
    r1Demand11.clear();
    r1Demand12.clear();
    r1Demand1.clear();

    r2Demand8.clear();
    r2Demand9.clear();
    r2Demand10.clear();
    r2Demand11.clear();
    r2Demand12.clear();
    r2Demand1.clear();

    r3Demand8.clear();
    r3Demand9.clear();
    r3Demand10.clear();
    r3Demand11.clear();
    r3Demand12.clear();
    r3Demand1.clear();

    r4Demand8.clear();
    r4Demand9.clear();
    r4Demand10.clear();
    r4Demand11.clear();
    r4Demand12.clear();
    r4Demand1.clear();

    super.dispose();
  }

  validate() async {
    List<String> names = [
      "Route1",
      "Route2",
      "Route3",
      "Route4",
    ];
    if (_formKey.currentState!.validate()) {
      try {
        buildLoadingIndicator(context);
        for (int i = 0; i < 4; i++) {
          FirebaseFirestore.instance
              .collection("ManualDemand")
              .doc(names[i])
              .set(
            {
              "r${i+1}Demand8": r1Demand8.text,
              "r${i+1}Demand9": r1Demand9.text,
              "r${i+1}Demand10": r1Demand10.text,
              "r${i+1}Demand11": r1Demand11.text,
              "r${i+1}Demand12": r1Demand12.text,
              "r${i+1}Demand1": r1Demand1.text,
              "dateTime" : DateTime.now(),
            },
          ).then(
            (value) {
              Navigator.of(context, rootNavigator: true).pop();

            },
          );
        }
      } catch (e) {
        Navigator.of(context, rootNavigator: true).pop();
        snackBar(context, "Some error occur");
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Manual Demand Input'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          /*  mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,*/
          children: [
            SizedBox(height: 20.h),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Route 1 : ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  customTextField(r1Demand8, "8am Bus demand", context,
                      Icons.email_outlined),
                  SizedBox(height: 25.h),
                  customTextField(r1Demand9, "9am Bus demand", context,
                      Icons.lock_outline_rounded),
                  SizedBox(height: 25.h),
                  customTextField(r1Demand10, "10am Bus demand", context,
                      Icons.lock_outline_rounded),
                  SizedBox(height: 25.h),
                  customTextField(r1Demand11, "11am Bus demand", context,
                      Icons.lock_outline_rounded),
                  SizedBox(height: 25.h),
                  customTextField(r1Demand12, "12am Bus demand", context,
                      Icons.lock_outline_rounded),
                  SizedBox(height: 25.h),
                  customTextField(r1Demand1, "1am Bus demand", context,
                      Icons.lock_outline_rounded),
                  SizedBox(height: 20.h),
                  Text(
                    "Route 2 : ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  customTextField(r2Demand8, "8am Bus demand", context,
                      Icons.email_outlined),
                  SizedBox(height: 25.h),
                  customTextField(r2Demand9, "9am Bus demand", context,
                      Icons.lock_outline_rounded),
                  SizedBox(height: 25.h),
                  customTextField(r2Demand10, "10am Bus demand", context,
                      Icons.lock_outline_rounded),
                  SizedBox(height: 25.h),
                  customTextField(r2Demand11, "11am Bus demand", context,
                      Icons.lock_outline_rounded),
                  SizedBox(height: 25.h),
                  customTextField(r2Demand12, "12am Bus demand", context,
                      Icons.lock_outline_rounded),
                  SizedBox(height: 25.h),
                  customTextField(r2Demand1, "1am Bus demand", context,
                      Icons.lock_outline_rounded),
                  SizedBox(height: 20.h),
                  Text(
                    "Route 3 : ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  customTextField(r3Demand8, "8am Bus demand", context,
                      Icons.email_outlined),
                  SizedBox(height: 25.h),
                  customTextField(r3Demand9, "9am Bus demand", context,
                      Icons.lock_outline_rounded),
                  SizedBox(height: 25.h),
                  customTextField(r3Demand10, "10am Bus demand", context,
                      Icons.lock_outline_rounded),
                  SizedBox(height: 25.h),
                  customTextField(r3Demand11, "11am Bus demand", context,
                      Icons.lock_outline_rounded),
                  SizedBox(height: 25.h),
                  customTextField(r3Demand12, "12am Bus demand", context,
                      Icons.lock_outline_rounded),
                  SizedBox(height: 25.h),
                  customTextField(r3Demand1, "1am Bus demand", context,
                      Icons.lock_outline_rounded),
                  SizedBox(height: 20.h),

                  Text(
                    "Route 4 : ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  customTextField(r4Demand8, "8am Bus demand", context,
                      Icons.email_outlined),
                  SizedBox(height: 25.h),
                  customTextField(r4Demand9, "9am Bus demand", context,
                      Icons.lock_outline_rounded),
                  SizedBox(height: 25.h),
                  customTextField(r4Demand10, "10am Bus demand", context,
                      Icons.lock_outline_rounded),
                  SizedBox(height: 25.h),
                  customTextField(r4Demand11, "11am Bus demand", context,
                      Icons.lock_outline_rounded),
                  SizedBox(height: 25.h),
                  customTextField(r4Demand12, "12am Bus demand", context,
                      Icons.lock_outline_rounded),
                  SizedBox(height: 25.h),
                  customTextField(r4Demand1, "1am Bus demand", context,
                      Icons.lock_outline_rounded),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
            SizedBox(height: 17.h),
            GestureDetector(
              onTap: () {
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
                    "Upload Demand",
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
