import 'package:bitfest/view/auth/verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bus/addBusInventory.dart';
import 'login.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);
  static String verify = "";
  static String name = "";
  static String number = "";
  static String id = "";
  static String role = "";

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController countryController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  var phone = "";
  bool isUser = true;
  String role = "Student";


  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+88";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(role);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              const Text(
                "Registration",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Give tour name and phone number",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 70.h,
                width: 360.w,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isUser = true;
                        });
                      },
                      child: Container(
                        height: 50.h,
                        width: 130.w,
                        decoration: BoxDecoration(
                          color: isUser ? Colors.black : Colors.grey,
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: Center(
                            child: Text(
                              "User",
                              style: TextStyle(
                                color: isUser ? Colors.white : Colors.black,
                              ),
                            )),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isUser = false;
                        });
                      },
                      child: Container(
                        height: 50.h,
                        width: 130.w,
                        decoration: BoxDecoration(
                          color: isUser ? Colors.grey : Colors.black,
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: Center(
                            child: Text(
                              "Official",
                              style: TextStyle(
                                color: isUser ? Colors.black : Colors.white,
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              if(isUser)
              SizedBox(
                height: 70.h,
                width: 360.w,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          role = "Student";
                        });
                      },
                      child: Container(
                        height: 50.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: role == "Student" ? Colors.black : Colors.grey,
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: Center(
                            child: Text(
                              "Student",
                              style: TextStyle(
                                color: role == "Student" ? Colors.white : Colors.black,
                              ),
                            )),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          role = "Teacher";
                        });
                      },
                      child: Container(
                        height: 50.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: role == "Teacher" ? Colors.black : Colors.grey,
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: Center(
                            child: Text(
                              "Teacher",
                              style: TextStyle(
                                color:  role == "Teacher" ? Colors.white : Colors.black,
                              ),
                            )),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          print(":");
                          role = "Staff";
                        });
                      },
                      child: Container(
                        height: 50.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: role == "Staff" ? Colors.black : Colors.grey,
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: Center(
                            child: Text(
                              "Staff",
                              style: TextStyle(
                                color: role == "Staff" ? Colors.white : Colors.black,
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              customTextField(
                  nameController, "Name", context, Icons.email_outlined),

              SizedBox(height: 15.h),
              if(isUser)
                customTextField(
                    idController, "Id", context, Icons.email_outlined),

              SizedBox(height: 10.h),



              SizedBox(height: 10.h),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    color: Color(0xffC4C4C4).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      onChanged: (value) {
                        phone = value;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone",
                      ),
                    ))
                  ],
                ),
              ),
              const SizedBox(height: 20),
              switchPageButton(
                  "Already Have An Account", "LogIn", context),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: GestureDetector(
                  onTap: () async {
                    if (phone.isEmpty || nameController.text.isEmpty) {
                      snackBar(context, "Please fill all field");
                      return;
                    }

                    if(isUser && idController.text.isEmpty){
                      snackBar(context, "Please fill all field");
                      return;
                    }


                    try{
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: countryController.text + phone,
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {
                          print(e);
                          print("v fail -------------------------------------");
                        },
                        codeSent: (String verificationId, int? resendToken) {

                          Registration.verify = verificationId;
                          Registration.name = nameController.text;
                          Registration.number = countryController.text + phone;
                          Registration.id = idController.text;
                          Registration.role = role;

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MyVerify(pageName: "registration"),
                            ),
                          );
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {
                          print("timeout fail -------------------------------------");
                        },
                      );
                    }catch(e){
                      print(e);
                      print("eee fail -------------------------------------");
                    }
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
                        "Register",
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
