import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:live/app/core/constants/app_constants.dart';
import 'package:live/app/core/constants/color_constants.dart';
import 'package:live/app/core/utils/my_color.dart';

class CommonPrimaryButton extends StatelessWidget {
  const CommonPrimaryButton({
    Key? key,
    this.width,
    this.height,
    this.radius,
    required this.enable,
    required this.title,
    required this.clickAction,
  }) : super(key: key);
  final double? width;
  final double? height;
  final double? radius;
  final bool enable;
  final String title;
  final VoidCallback clickAction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (enable) {
          clickAction();
        }
      },
      child: Container(
        width: width ?? 68.2.w,
        height: height ?? 26.4.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: enable
              ? ColorConstants.primaryColor
              : ColorConstants.unPrimaryColor,
          borderRadius: BorderRadius.circular(radius ?? 13.2.w),
          boxShadow: [
            BoxShadow(
              blurRadius: 10, //阴影范围
              spreadRadius: 0.1, //阴影浓度
              color: MyColor("#A6C0E9"),
            )
          ],
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
