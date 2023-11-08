import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live/app/core/utils/my_image.dart';
import 'package:live/app/core/constants/color_constants.dart';

import 'package:get/get.dart';

class RootEmptyWidget extends StatelessWidget {
  const RootEmptyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 153.w,
              height: 1.w,
            ),
            SizedBox(
              width: 8.5.w,
            ),
            MyImage("ic_empty", width: 131.5.w, height: 150.w)
                .paddingOnly(top: 10.w),
            SizedBox(
              width: 8.5.w,
            ),
            MyImage("ic_path", width: 153.w, height: 86.5.w),
          ],
        ),
        Text(
          "尚未绑定项目，请点击右上角绑定或联系工作人员",
          style: TextStyle(
            color: ColorConstants.primaryColor,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}