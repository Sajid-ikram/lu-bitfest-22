import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../providers/profile_provider.dart';

profileRow(
    String hintText, String relatedInfo, BuildContext context, bool editable) {
  var pro = Provider.of<ProfileProvider>(context);

  return Padding(
    padding: EdgeInsets.fromLTRB(20.0.h, 7.0.h, 20.0.h, 7.0.h),
    child: Row(
      children: [
        Text(
          "$hintText:",
          style: TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
            fontSize: 15.h,
          ),
        ),
        const Spacer(),
        Text(
          relatedInfo,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
            fontSize: 15.h,
          ),
        ),
        (editable) //&& pro.role == 'student')
            ? GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    'UpdateProfileInfo',
                  );
                },
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.blueGrey,
                  //size: 15,
                ),
              )
            : const Text(' '),
      ],
    ),
  );
}
