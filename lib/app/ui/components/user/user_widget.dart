import 'package:live/app/core/constants/color_constants.dart';
import 'package:live/app/core/controller/user_controller.dart';
import 'package:live/app/core/utils/my_image.dart';
import 'package:live/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (controller) {
      return (controller.userModel != null &&
              controller.userModel!.fullName != null)
          ? InkWell(
              onTap: () {
              },
              child: Row(children: [
                Container(
                  width: 25.w,
                  height: 25.w,
                  child: MyImage("ic_person_logo"),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  controller.userModel!.fullName!,
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Container(
                    width: 10.5.w,
                    height: 10.5.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ColorConstants.primaryColor,
                      borderRadius: BorderRadius.circular(5.25.w),
                    ),
                    child: MyImage(
                      "ic_sanjiao_down",
                      width: 5.5.w,
                      height: 3.5.w,
                    ))
              ]),
            )
          : const SizedBox();
    });
  }
}
