import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:live/app/core/constants/color_constants.dart';
import 'package:live/app/core/enum/common_nav_bar_enum.dart';
import 'package:live/app/core/utils/my_image.dart';

class CommonNavBarWidget extends StatelessWidget {
  const CommonNavBarWidget({
    Key? key,
    required this.navBarEnum,
    required this.title,
    this.centerWidget,
    this.rightWidget,
    required this.leftAction,
  }) : super(key: key);
  final CommonNavBarEnum navBarEnum;
  final String title;
  final Widget? centerWidget;
  final Widget? rightWidget;
  final VoidCallback leftAction;

  Widget getWidget() {
    Widget widget;
    if (navBarEnum == CommonNavBarEnum.navBarTitle) {
      widget = Row(
        children: [
          MyImage(
            "ic_logo",
            width: 30.w,
            height: 30.w,
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      );
    }
    else if (navBarEnum == CommonNavBarEnum.navBarPerson) {
      widget = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              MyImage(
                "ic_logo",
                width: 30.w,
                height: 30.w,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          rightWidget ?? Container()
        ],
      );
    }
    else if (navBarEnum == CommonNavBarEnum.navBarBack) {
      widget = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    leftAction();
                  },
                  child: SizedBox(
                    width: 42.5.w,
                    height: 47.w,
                    child: MyImage("ic_back"),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                centerWidget != null
                    ? Expanded(child: centerWidget!)
                    : const SizedBox(),
              ],
            ),
          ),
          rightWidget ?? Container()
        ],
      );
    }
    else {
      widget = Row(
        children: [
          MyImage(
            "ic_logo",
            width: 30.w,
            height: 30.w,
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      );
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      height: 66.w,
      child: getWidget(),
    );
  }
}
