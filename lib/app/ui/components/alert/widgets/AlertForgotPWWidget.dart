import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:live/app/core/utils/my_color.dart';
import 'package:live/app/core/utils/my_image.dart';
import 'package:live/app/ui/components/alert/common_alert.dart';
import 'package:live/app/ui/components/alert/common_alert_controller.dart';
import 'package:live/app/ui/components/common_primary_button.dart';


class AlertForgotPWWidget extends StatelessWidget {
  const AlertForgotPWWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommonAlertController>(builder: (controller) {
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 40.w,
                  ),
                  Text(
                    "忘记密码",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 18.w,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AlertInputWidget(
                              placeHolder: '请输入手机号',
                              maxLength: 11,
                              errorText: controller.phoneError,
                              text: controller.phone,
                              onChange: (String text) {
                                controller.setPhone(text);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          const AlertCodeWidget().paddingOnly(top: 0.w),
                        ],
                      ),
                      AlertInputWidget(
                        placeHolder: '请输入验证码',
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        text: controller.code,
                        errorText: controller.codeError,
                        onChange: (String text) {
                          controller.setCode(text);
                        },
                      ),
                      AlertInputWidget(
                        placeHolder: '请输入8-20位密码',
                        errorText: controller.pwError,
                        text: controller.pw,
                        obscureText: true,
                        maxLength: 20,
                        onChange: (String text) {
                          controller.setPW(text);
                        },
                      ),
                      AlertInputWidget(
                        placeHolder: '请确认密码',
                        errorText: controller.pw1Error,
                        obscureText: true,
                        text: controller.pw1,
                        maxLength: 20,
                        onChange: (String text) {
                          controller.setPW1(text);
                        },
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonPrimaryButton(
                              enable: true,
                              title: "取消",
                              width: 68.w,
                              height: 27.w,
                              radius: 13.5.w,
                              clickAction: () {
                                Get.back(result: false);
                              }),
                          SizedBox(
                            width: 25.w,
                          ),
                          CommonPrimaryButton(
                              enable: controller.isInput,
                              width: 68.w,
                              height: 27.w,
                              radius: 13.5.w,
                              title: "确认",
                              clickAction: () {
                                controller.forgetPW();
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 18.5.w,
                      )
                    ],
                  ).paddingSymmetric(horizontal: 49.5)
                ],
              ),
            ),
            Positioned(
                top: -30.w,
                child: MyImage(
                  "ic_alert_2",
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
