import 'package:bitfest/view/auth/registration.dart';
import 'package:bitfest/view/auth/verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bus/addBusInventory.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);
  static String verify = "";

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController countryController = TextEditingController();

  var phone = "";

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+88";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                "LogIn",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Login with Phone number ",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              SizedBox(height: 15.h),
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
                  "Don't have an account", "Register now", context),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: GestureDetector(
                  onTap: () async {
                    if (phone.isEmpty) {
                      snackBar(context, "Please enter a number");
                      return;
                    }
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: countryController.text + phone,
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        LogIn.verify = verificationId;

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MyVerify(pageName: "login"),
                          ),
                        );
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
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
                        "LogIn",
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

Padding switchPageButton(String text1, String text2, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style:
              TextStyle(fontSize: 13.sp, color: Theme.of(context).primaryColor),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            if (text2 == "Register now") {
              Navigator.of(context).push(
                MaterialPageRoute(

                  builder: (context) => Registration(),

                ),
              );
            } else {
              Navigator.of(context).pushReplacementNamed("SignIn");
            }
          },
          child: Text(
            text2,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        )
      ],
    ),
  );
}
