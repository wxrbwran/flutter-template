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


class AlertProtocolWidget extends StatelessWidget {
  const AlertProtocolWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommonAlertController>(builder: (controller) {
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
            "用户协议及隐私条款",
            style: TextStyle(
              color: ColorConstants.textColor1b1b,
              fontSize: 17.5.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 8.w,
          ),
          Expanded(
            child: Scrollbar(
              controller: controller.scrollController,
              child: SingleChildScrollView(
                controller: controller.scrollController,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "八观认知评估系统用户服务协议",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.w,
                      ),
                      Text(
                        serverProtocal,
                        style: TextStyle(
                          color: MyColor("#363636"),
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 2.w,
                      ),
                      Text(
                        "八观认知评估App个人信息保护政策",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.w,
                      ),
                      Text(
                        userProtocal,
                        style: TextStyle(
                          color: MyColor("#363636"),
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ]),
              ),
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
                  title: "不同意",
                  width: 80.w,
                  height: 26.4.w,
                  radius: 13.2.w,
                  clickAction: () {
                    Get.back(result: false);
                  }),
              SizedBox(
                width: 25.w,
              ),
              const CommonAlertCountDownBtn(),
            ],
          )
        ]).paddingOnly(
            left: 25.w, right: 25.w, top: 22.5.w, bottom: 19.5.w),
      );
    });
  }
}
