import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:live/app/core/utils/my_color.dart';
import 'package:live/app/core/utils/my_image.dart';
import 'package:live/app/ui/components/custom_refresh.dart';

class CommonBgContainer extends StatelessWidget {
  const CommonBgContainer({
    Key? key,
    required this.navBar,
    required this.child,
    this.horizontalPadding,
    this.onRefresh,
    this.refreshController,
  }) : super(key: key);
  final Widget navBar;
  final Widget child;
  final double? horizontalPadding;
  final OnRefreshCallback? onRefresh;
  final EasyRefreshController? refreshController;

  @override
  Widget build(BuildContext context) {
    // print(ScreenUtil().screenHeight);
    // print(ScreenUtil().screenWidth);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              MyColor("#D5E6F8"),
              MyColor("#F3F4FD"),
            ]),
      ),
      child: SafeArea(
          child: Column(
        children: [
          navBar,
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: (refreshController != null && onRefresh != null)
                    ? CustomRefresh(
                        easyRefreshController: refreshController,
                        onRefresh: onRefresh,
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Container(
                            height: ScreenUtil().screenHeight -
                                78.w -
                                ScreenUtil().bottomBarHeight,
                            padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding ?? 24.w),
                            child: Stack(children: [
                              MyImage(
                                "ic_login_bg",
                                // width: 531.5.w,
                                // height: 298.5.w,
                              ),
                              Positioned.fill(child: child),
                            ]),
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Container(
                          height: ScreenUtil().screenHeight -
                              78.w -
                              ScreenUtil().bottomBarHeight,
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding ?? 24.w),
                          child: Stack(children: [
                            MyImage(
                              "ic_login_bg",
                              // width: 531.5.w,
                              // height: 298.5.w,
                            ),
                            Positioned.fill(child: child),
                          ]),
                        ),
                      ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
