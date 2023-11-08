
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


class AlertReportHistoryWidget extends StatelessWidget {
  const AlertReportHistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommonAlertController>(builder: (controller) {
      CommonAlertModel alertModel = controller.alertModel;
      return Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.topCenter,
        children: [
          Container(
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
                alertModel.title,
                style: TextStyle(
                  color: ColorConstants.textColor1b1b,
                  fontSize: 17.5.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 12.5.w,
              ),
              Text(
                "尚未完成测评，请完成测评后查看报告。",
                style: TextStyle(color: MyColor("#626262"), fontSize: 13.sp),
              ),
              SizedBox(
                height: 24.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonBorderButton(
                      width: 80.w,
                      height: 26.4.w,
                      radius: 13.2.w,
                      enable: true,
                      title: "取消",
                      clickAction: () {
                        Get.back();
                      }),
                  SizedBox(
                    width: 25.w,
                  ),
                  CommonPrimaryButton(
                      enable: true,
                      title: "查看其他报告",
                      width: 80.w,
                      height: 26.4.w,
                      radius: 13.2.w,
                      clickAction: () {
                        Get.back();
                        // Get.toNamed(Routes.Report);
                      }),
                ],
              ),
            ]).paddingOnly(
                left: 38.5.w, right: 38.5.w, top: 32.5.w, bottom: 19.w),
          ),
          Positioned(
              top: -30.w,
              child: MyImage(
                alertModel.icon.isEmpty ? "ic_alert_1" : alertModel.icon,
                width: 60.w,
                height: 60.w,
                fit: BoxFit.contain,
              ))
        ],
      );
    });
  }
}
