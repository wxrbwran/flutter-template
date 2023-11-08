import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:live/app/core/utils/my_color.dart';
import 'package:live/app/core/utils/my_image.dart';
import 'package:live/app/ui/components/alert/common_alert.dart';
import 'package:live/app/ui/components/alert/common_alert_controller.dart';
import 'package:live/app/ui/components/alert/common_alert_model.dart';
import 'package:live/app/ui/components/common_primary_button.dart';


class AlertEditPWWidget extends StatelessWidget {
  const AlertEditPWWidget({Key? key}) : super(key: key);

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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 40.w,
                  ),
                  Text(
                    alertModel.title,
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
                      AlertInputWidget(
                        placeHolder: '请输入旧密码',
                        errorText: controller.pwError,
                        text: controller.pw,
                        maxLength: 20,
                        obscureText: true,
                        onChange: (String text) {
                          controller.setPW(text);
                        },
                      ),
                      AlertInputWidget(
                        placeHolder: '请输入新密码',
                        errorText: controller.newPWError,
                        text: controller.newPW,
                        obscureText: true,
                        maxLength: 20,
                        onChange: (String text) {
                          controller.setNewPW(text);
                        },
                      ),
                      AlertInputWidget(
                        placeHolder: '请再次输入新密码',
                        obscureText: true,
                        text: controller.new1PW,
                        errorText: controller.newPW1Error,
                        maxLength: 20,
                        onChange: (String text) {
                          controller.setNewPW1(text);
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
                                controller.editPW();
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
