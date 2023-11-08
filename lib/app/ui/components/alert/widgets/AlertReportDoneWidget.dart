import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:live/app/core/constants/color_constants.dart';
import 'package:live/app/core/utils/my_color.dart';
import 'package:live/app/core/utils/my_image.dart';
import 'package:live/app/ui/components/alert/common_alert_controller.dart';
import 'package:live/app/ui/components/alert/common_alert_model.dart';
import 'package:live/app/ui/components/common_border_buttton.dart';


class AlertReportDoneWidget extends StatelessWidget {
  const AlertReportDoneWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommonAlertController>(builder: (controller) {
      CommonAlertModel alertModel = controller.alertModel;
      return Container(
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 29.w,
            ),
            MyImage(alertModel.icon, width: 60.5.w, height: 59.5.w),
            SizedBox(
              height: 10.w,
            ),
            Text(
              alertModel.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17.5.w,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 3.w,
            ),
            Text(
              "恭喜完成所有任务！",
              style: TextStyle(
                color: ColorConstants.textColor6262,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(
              height: 40.w,
            ),
            CommonBorderButton(
              enable: true,
              title: "返回",
              width: 110.w,
              height: 26.w,
              radius: 13.w,
              clickAction: () {
                if (alertModel.fromGame != null && alertModel.fromGame!) {
                  Get.back();
                }
                Get.back();
              },
            ),
            SizedBox(
              height: 13.w,
            ),
            InkWell(
              onTap: () {
                if (alertModel.fromGame != null && alertModel.fromGame!) {
                  Get.back();
                }
                controller.createReport();
              },
              child: Text(
                "查看报告",
                style: TextStyle(
                  color: ColorConstants.primaryColor,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ).paddingOnly(left: 54.w, right: 54.w, top: 0.w, bottom: 19.w),
      );
    });
  }
}
