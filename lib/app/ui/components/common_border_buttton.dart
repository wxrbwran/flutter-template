import 'package:live/app/core/constants/color_constants.dart';
import 'package:live/app/core/utils/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonBorderButton extends StatelessWidget {
  const CommonBorderButton(
      {super.key,
      this.width,
      this.height,
      this.radius,
      required this.enable,
      required this.title,
      required this.clickAction});
  final double? width;
  final double? height;
  final double? radius;
  final bool enable;
  final String title;
  final VoidCallback clickAction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: clickAction,
      child: Container(
        width: width ?? 68.2.w,
        height: height ?? 26.4.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(radius ?? 13.2.w),
          border: Border.all(
              color: enable
                  ? ColorConstants.primaryColor
                  : ColorConstants.unPrimaryColor,
              width: 1.w),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: enable
                ? ColorConstants.primaryColor
                : ColorConstants.unPrimaryColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
