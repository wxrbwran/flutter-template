import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:live/app/core/constants/color_constants.dart';
import 'package:live/app/core/utils/my_color.dart';
import 'package:live/app/core/utils/my_image.dart';
import 'package:live/app/data/mock/protocal_mock.dart';
import 'package:live/app/ui/components/alert/common_alert.dart';
import 'package:live/app/ui/components/alert/common_alert_controller.dart';
import 'package:live/app/ui/components/alert/common_alert_model.dart';
import 'package:live/app/ui/components/common_border_buttton.dart';
import 'package:live/app/ui/components/common_primary_button.dart';


class AlertDeviceInfoWidget extends StatelessWidget {
  const AlertDeviceInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 290.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.5.w),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              MyColor("#D5E6F8"),
              MyColor("#F3F4FD"),
            ]),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          "查看设备信息",
          style: TextStyle(
            color: ColorConstants.textColor1b1b,
            fontSize: 17.5.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 8.w,
        ),
        Text(
          Platform.isAndroid
              ? "安卓设备"
              : Platform.isIOS
              ? "ios设备"
              : Platform.isFuchsia
              ? "fuchsia设备"
              : Platform.isLinux
              ? "linux设备"
              : Platform.isMacOS
              ? "macos设备"
              : "windows设备",
          style: TextStyle(
            color: MyColor("#363636"),
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 8.w,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonBorderButton(
                enable: true,
                title: "取消",
                width: 80.w,
                height: 26.4.w,
                radius: 13.2.w,
                clickAction: () {
                  Get.back(result: false);
                }),
            SizedBox(
              width: 25.w,
            ),
            CommonPrimaryButton(
                enable: true,
                width: 80.w,
                height: 26.4.w,
                radius: 13.2.w,
                title: "确认",
                clickAction: () {
                  Get.back(result: true);
                }),
          ],
        )
      ]).paddingOnly(left: 25.w, right: 25.w, top: 22.5.w, bottom: 19.5.w),
    );
  }
}
