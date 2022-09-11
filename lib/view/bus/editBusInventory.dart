import 'package:bitfest/providers/bus_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../public/custom_loading.dart';

class EditBusInventory extends StatefulWidget {
  EditBusInventory({
    Key? key,
    required this.licence,
    required this.driverName,
    required this.codeName,
    required this.capacity,
    required this.driverPhone,
    required this.isAc,
    required this.uid,
  }) : super(key: key);

  String licence;
  String codeName;
  String capacity;
  String driverName;
  String driverPhone;
  String uid;
  bool isAc;

  @override
  State<EditBusInventory> createState() => _EditBusInventoryState();
}

class _EditBusInventoryState extends State<EditBusInventory> {
  TextEditingController licenceNumber = TextEditingController();
  TextEditingController codeName = TextEditingController();
  TextEditingController capacity = TextEditingController();
  TextEditingController driverName = TextEditingController();
  TextEditingController driverNumber = TextEditingController();
  bool isActive = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    licenceNumber.clear();
    codeName.clear();
    capacity.clear();
    driverName.clear();
    driverNumber.clear();
    super.dispose();
  }

  @override
  void initState() {
    licenceNumber.text = widget.licence;
    codeName.text = widget.codeName;
    capacity.text = widget.capacity;
    driverName.text = widget.driverName;
    driverNumber.text = widget.driverPhone;
    isActive = widget.isAc;
    super.initState();
  }

  validate() async {
    if (_formKey.currentState!.validate()) {
      try {
        buildLoadingIndicator(context);
        Provider.of<BusProvider>(context, listen: false)
            .editBusInventory(
          capacity: capacity.text,
          codename: codeName.text,
          driverName: driverName.text,
          driverPhone: driverNumber.text,
          isActive: isActive,
          licence: licenceNumber.text,
          context: context,
          uid: widget.uid,
        )
            .then(
          (value) {
            Navigator.of(context, rootNavigator: true).pop();
            if (value != "Success") {
              snackBar(context, value);
            } else {
              snackBar(context, "Success");
              Navigator.of(context).pop();
            }
          },
        );
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
        title: Text('Bus Inventry'),
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
                SizedBox(height: 30.h),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('License number'),
                      customTextField(licenceNumber, "License number", context,
                          Icons.email_outlined),
                      SizedBox(height: 25.h),
                      Text('Codename'),
                      customTextField(codeName, "Codename", context,
                          Icons.lock_outline_rounded),
                      SizedBox(height: 25.h),
                      Text('Capacity'),
                      customTextField(capacity, "Capacity", context,
                          Icons.lock_outline_rounded),
                      SizedBox(height: 25.h),
                      Text('Full Name'),
                      customTextField(driverName, "Full Name", context,
                          Icons.lock_outline_rounded),
                      SizedBox(height: 25.h),
                      Text('Contact Number'),
                      customTextField(driverNumber, "Contact Number", context,
                          Icons.lock_outline_rounded),
                      SizedBox(height: 20.h),
                      SizedBox(
                        height: 70.h,
                        width: 360.w,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  isActive = true;
                                });
                              },
                              child: Container(
                                height: 50.h,
                                width: 130.w,
                                decoration: BoxDecoration(
                                  color: isActive ? Colors.black : Colors.grey,
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                child: Center(
                                    child: Text(
                                      "Active",
                                      style: TextStyle(
                                        color: isActive ? Colors.white : Colors.black,
                                      ),
                                    )),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  isActive = false;
                                });
                              },
                              child: Container(
                                height: 50.h,
                                width: 130.w,
                                decoration: BoxDecoration(
                                  color: isActive ? Colors.grey : Colors.black,
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                child: Center(
                                    child: Text(
                                      "Not Active",
                                      style: TextStyle(
                                        color: isActive ? Colors.black : Colors.white,
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      )
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
                        "Update",
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
