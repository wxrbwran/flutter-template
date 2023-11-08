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


class AlertJoinWidget extends StatelessWidget {
  const AlertJoinWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommonAlertController>(builder: (controller) {
      CommonAlertModel alertModel = controller.alertModel;
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "输入邀请码",
                      style: TextStyle(
                        color: MyColor("#626262"),
                        fontSize: 12.sp,
                      ),
                    ).paddingOnly(top: 2.w),
                    SizedBox(
                      width: 7.w,
                    ),
                    Expanded(
                      child: AlertInputWidget(
                        placeHolder: "请输入邀请码",
                        errorText: controller.inviteCodeError,
                        text: controller.inviteCode,
                        onChange: (String text) {
                          controller.setInviteCode(text);
                        },
                        maxLength: 8,
                        rightWidget: InkWell(
                          onTap: () async {
                            // var result = await Get.toNamed(Routes.QR);
                            // if (result != null) {
                            //   controller.setInviteCode(result);
                            // }
                          },
                          child: MyImage("ic_login_scan",
                              width: 10.5.w, height: 10.w),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonPrimaryButton(
                        enable: true,
                        title: "取消",
                        width: 68.2.w,
                        height: 26.4.w,
                        radius: 13.2.w,
                        clickAction: () {
                          Get.back(result: false);
                        }),
                    SizedBox(
                      width: 25.w,
                    ),
                    CommonPrimaryButton(
                        enable: controller.isInput,
                        title: "确认",
                        width: 68.2.w,
                        height: 26.4.w,
                        radius: 13.2.w,
                        clickAction: () {
                          controller.joinProgram();
                        }),
                  ],
                ),
              ]).paddingOnly(
                  left: 47.5.w, right: 47.5.w, top: 32.5.w, bottom: 19.w),
            ),
            Positioned(
                top: -30.w,
                child: MyImage(
                  alertModel.icon,
                  width: 60.w,
                  height: 60.w,
                  fit: BoxFit.contain,
                ))
          ],
        ),
      );
    });
  }
}
