import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:live/app/core/constants/app_constants.dart';
import 'package:live/app/core/constants/color_constants.dart';
import 'package:live/app/core/enum/common_alert_enum.dart';
import 'package:live/app/core/utils/my_color.dart';
import 'package:live/app/ui/components/alert/common_alert_controller.dart';
import 'package:live/app/ui/components/alert/common_alert_model.dart';
import 'package:live/app/ui/components/alert/widgets/AlertDeviceInfoWidget.dart';
import 'package:live/app/ui/components/alert/widgets/AlertEditPWWidget.dart';
import 'package:live/app/ui/components/alert/widgets/AlertFinishWidget.dart';
import 'package:live/app/ui/components/alert/widgets/AlertForgotPWWidget.dart';
import 'package:live/app/ui/components/alert/widgets/AlertGameOverWidget.dart';
import 'package:live/app/ui/components/alert/widgets/AlertJoinWidget.dart';
import 'package:live/app/ui/components/alert/widgets/AlertProtocolWidget.dart';
import 'package:live/app/ui/components/alert/widgets/AlertReportDeleteWidget.dart';
import 'package:live/app/ui/components/alert/widgets/AlertReportDoneWidget.dart';
import 'package:live/app/ui/components/alert/widgets/AlertReportHistoryWidget.dart';
import 'package:live/app/ui/components/alert/widgets/AlertReportRefreshWidget.dart';
import 'package:live/app/ui/components/alert/widgets/AlertReportTipWidget.dart';
import 'package:live/app/ui/components/alert/widgets/AlertReportWidget.dart';
import 'package:live/app/ui/components/common_primary_button.dart';

class CommonAlert extends StatelessWidget {
  const CommonAlert({
    Key? key,
  }) : super(key: key);

  Widget getWidget(CommonAlertController controller, BuildContext context) {
    Widget widget;
    CommonAlertModel alertModel = controller.alertModel;
    switch (alertModel.alertEnum) {
      case CommonAlertEnum.alertForgotPW:
        widget = const AlertForgotPWWidget();
        break;
      case CommonAlertEnum.alertEditPW:
        widget = const AlertEditPWWidget();
        break;
      case CommonAlertEnum.alertProtocol:
        widget = const AlertProtocolWidget();
        break;
      case CommonAlertEnum.alertPersonInfo:
        widget = Container();
        break;
      case CommonAlertEnum.alertDeviceInfo:
        widget = const AlertDeviceInfoWidget();
        break;
      case CommonAlertEnum.alertJoin:
        widget = const AlertJoinWidget();
        break;
      case CommonAlertEnum.alertReportRefresh:
        widget = const AlertReportRefreshWidget();
        break;
      case CommonAlertEnum.alertEvaluation:
        widget = Container();
        break;
      case CommonAlertEnum.alertReport:
        widget =const AlertReportWidget();
        break;
      case CommonAlertEnum.alertReportHistory:
        widget = const AlertReportHistoryWidget();
        break;
      case CommonAlertEnum.alertReportTip:
        widget = const AlertReportTipWidget();
        break;
      case CommonAlertEnum.alertFinish:
        widget = const AlertFinishWidget();
        break;
      case CommonAlertEnum.alertGameOver:
        widget = const AlertGameOverWidget();
        break;
      case CommonAlertEnum.alertReportDone:
        widget = const AlertReportDoneWidget();
        break;
      case CommonAlertEnum.alertReportDelete:
        widget = const AlertReportDeleteWidget();
        break;
      default:
        widget = Container();
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    CommonAlertController controller = Get.put(CommonAlertController());
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              CommonAlertModel alertModel = controller.alertModel;

              if (alertModel.alertEnum == CommonAlertEnum.alertJoin ||
                  alertModel.alertEnum == CommonAlertEnum.alertForgotPW ||
                  alertModel.alertEnum == CommonAlertEnum.alertEditPW) {
                Get.back();
              }
            },
            child: Container(
              alignment: Alignment.center,
              color: MyColor("#000000", alpha: 0.3),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: getWidget(controller, context),
          ).paddingSymmetric(horizontal: 135.5.w)
        ],
      ),
    );
  }
}

class CommonAlertCountDownBtn extends StatefulWidget {
  const CommonAlertCountDownBtn({
    Key? key,
  }) : super(key: key);

  @override
  State<CommonAlertCountDownBtn> createState() =>
      _CommonAlertCountDownBtnState();
}

class _CommonAlertCountDownBtnState extends State<CommonAlertCountDownBtn> {
  late Timer? timer;
  late bool isCountDown;
  int countDown = 10;
  String tTitle = "10s";
  @override
  void initState() {
    // TODO: implement initState
    isCountDown = false;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      countDown -= 1;
      if (countDown < 1) {
        isCountDown = true;
        tTitle = "";
      } else {
        tTitle = "${countDown}s";
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CommonAlertController controller = Get.find();
    return GetBuilder<CommonAlertController>(builder: (_) {
      return CommonPrimaryButton(
          enable: (controller.isScrollBottom && isCountDown),
          width: 80.w,
          height: 26.4.w,
          radius: 13.2.w,
          title: isCountDown ? "同意" : "同意($tTitle)",
          clickAction: () {
            Get.back(result: true);
          });
    });
  }
}

class AlertCodeWidget extends StatefulWidget {
  const AlertCodeWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AlertCodeWidget> createState() => _AlertCodeWidgetState();
}

class _AlertCodeWidgetState extends State<AlertCodeWidget> {
  late int count;
  late Timer? timer;
  late String text;
  @override
  void initState() {
    super.initState();
    count = 0;
    text = "获取验证码";
  }

  countBack() {
    count = AppConstants.CountBackNumber;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      count--;
      if (count <= 0) {
        t.cancel();
        text = "获取验证码";
      } else {
        text = "${count}s";
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    CommonAlertController controller = Get.find();

    return InkWell(
      onTap: () async {
        if (count > 0) {
          return;
        }
        bool ok = await controller.getCode();
        if (ok) {
          countBack();
        }
      },
      child: Container(
        width: 73.5.w,
        height: 22.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorConstants.primaryColor,
          borderRadius: BorderRadius.circular(11.w),
          boxShadow: [
            BoxShadow(
              blurRadius: 10, //阴影范围
              spreadRadius: 0.1, //阴影浓度
              color: MyColor("#A6C0E9"),
            )
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class AlertInputWidget extends StatefulWidget {
  const AlertInputWidget({
    Key? key,
    this.text = "",
    required this.placeHolder,
    this.maxLength = 30,
    this.enable = true,
    this.keyboardType,
    this.errorText,
    this.rightWidget,
    required this.onChange,
    this.obscureText = false,
  }) : super(key: key);
  final String text;
  final String placeHolder;
  final int maxLength;
  final bool enable;
  final TextInputType? keyboardType;
  final String? errorText;
  final Widget? rightWidget;
  final ValueChanged<String> onChange;
  final bool obscureText;

  @override
  State<AlertInputWidget> createState() => _AlertInputWidgetState();
}

class _AlertInputWidgetState extends State<AlertInputWidget> {
  late TextEditingController _textEditingController;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController.fromValue(
      TextEditingValue(
        // 设置内容
        text: widget.text,
        // 保持光标在最后
        selection: TextSelection.fromPosition(
          TextPosition(
              affinity: TextAffinity.downstream, offset: widget.text.length),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _textEditingController = TextEditingController.fromValue(
      TextEditingValue(
        // 设置内容
        text: widget.text,
        // 保持光标在最后
        selection: TextSelection.fromPosition(
          TextPosition(
              affinity: TextAffinity.downstream, offset: widget.text.length),
        ),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 23.w,
          padding: EdgeInsets.only(left: 9.w, right: 9.w),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(3.w),
            border: Border.all(
              color: ColorConstants.primaryColor,
              width: 1.w,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    SizedBox(
                      height: 23.w,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        controller: _textEditingController,
                        cursorColor: ColorConstants.primaryColor,
                        enabled: widget.enable,
                        obscureText: widget.obscureText,
                        maxLength: widget.maxLength,
                        keyboardType: widget.keyboardType,
                        onChanged: (String text) {
                          if (_textEditingController
                              .value.isComposingRangeValid) {
                            return;
                          }
                          widget.onChange(text);
                        },
                        style: TextStyle(
                          color: MyColor("#333333"),
                          fontWeight: FontWeight.w500,
                          fontSize: 11.sp,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          // contentPadding: EdgeInsets.only(top: 1.w),
                          contentPadding: EdgeInsets.only(
                            bottom: GetPlatform.isAndroid ? 8.w : 4.w,
                          ),
                          hintText: widget.placeHolder,
                          hintStyle: TextStyle(
                            color: MyColor("#7F7F7F"),
                            fontWeight: FontWeight.w400,
                            fontSize: 11.sp,
                          ),
                          counterText: "",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              widget.rightWidget == null
                  ? const SizedBox()
                  : Padding(
                      padding: EdgeInsets.only(
                        left: 8.w,
                      ),
                      child: widget.rightWidget,
                    ),
            ],
          ),
        ),
        widget.errorText == null || widget.errorText!.isEmpty
            ? SizedBox(
                height: 15.w,
              )
            : Text(
                widget.errorText!,
                style: TextStyle(
                    color: MyColor("#F93B3B"),
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w400),
              ).paddingOnly(top: 3.5.w, left: 9.w)
      ],
    );
  }
}
