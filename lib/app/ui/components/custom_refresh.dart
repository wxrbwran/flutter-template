import 'package:live/app/core/constants/color_constants.dart';
import 'package:live/app/core/enum/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CustomRefresh extends StatefulWidget {
  const CustomRefresh(
      {Key? key,
      this.easyRefreshController,
      this.type = 0,
      this.emptyCount = 0,
      this.emptyType,
      required this.child,
      this.onRefresh,
      this.isSliver = false,
      this.emptyClickAction,
      this.onLoad})
      : super(key: key);
  final EasyRefreshController? easyRefreshController;

  /// header footer 样式
  final int? type;

  final bool? isSliver;

  /**
   * 下面2个属性来控制空页面显示
   */
  final int? emptyCount;
  final EmptyState? emptyType;

  final VoidCallback? emptyClickAction;

  final Widget? child;

  final OnRefreshCallback? onRefresh;
  final OnLoadCallback? onLoad;

  @override
  _CustomRefreshState createState() => _CustomRefreshState();
}

class _CustomRefreshState extends State<CustomRefresh> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return widget.isSliver!
        ? EasyRefresh.custom(
            key: widget.key,
            controller: widget.easyRefreshController,
            slivers: [widget.child!],
            emptyWidget: null,
            // widget.emptyType == null
            //     ? null
            //     : widget.emptyCount == 0
            //         ? EmptyWidget(
            //             state: widget.emptyType,
            //             clickAction: widget.emptyClickAction!,
            //           )
            //         : null,
            onRefresh: widget.onRefresh,
            onLoad: widget.onLoad,
            enableControlFinishLoad: true,
            enableControlFinishRefresh: true,
            header: ClassicalHeader(
              textColor: ColorConstants.black,
              refreshingText: "refreshingText".tr,
              refreshedText: "refreshedText".tr,
              refreshReadyText: "refreshReadyText".tr,
              refreshText: "refreshText".tr,
              refreshFailedText: "refreshFailedText".tr,
              infoColor: ColorConstants.primaryColor,
              infoText:
                  "${"infoTextTime".tr}:${now.hour}${"dian".tr}${now.minute}${"fen".tr}",
            ),
            footer: ClassicalFooter(
              textColor: ColorConstants.black,
              noMoreText: "noMoreText".tr,
              loadText: "loadText".tr,
              loadReadyText: "loadReadyText".tr,
              loadingText: "loadingText".tr,
              loadedText: "loadedText".tr,
              showInfo: true,
              loadFailedText: "loadFailedText".tr,
              infoColor: ColorConstants.primaryColor,
              infoText:
                  "${"infoTextTime".tr}:${now.hour}${"dian".tr}${now.minute}${"fen".tr}",
            ),
          )
        : EasyRefresh(
            key: widget.key,
            controller: widget.easyRefreshController,
            child: widget.child,
            emptyWidget: null,
            // widget.emptyType == null
            //     ? null
            //     : widget.emptyCount == 0
            //         ? EmptyWidget(
            //             state: widget.emptyType,
            //             clickAction: widget.emptyClickAction!,
            //           )
            //         : null,
            enableControlFinishLoad: true,
            enableControlFinishRefresh: true,
            onRefresh: widget.onRefresh,
            onLoad: widget.onLoad,
            header: MaterialHeader(),
            footer: MaterialFooter(),
            // header: ClassicalHeader(
            //   textColor: ColorConstants.black,
            //   refreshingText: "refreshingText".tr,
            //   refreshedText: "refreshedText".tr,
            //   refreshReadyText: "refreshReadyText".tr,
            //   refreshText: "refreshText".tr,
            //   refreshFailedText: "refreshFailedText".tr,
            //   infoColor: ColorConstants.primaryColor,
            //   // infoText:
            //   //     "${"infoTextTime".tr}:${now.hour}${"dian".tr}${now.minute}${"fen".tr}",
            // ),
            // footer: ClassicalFooter(
            //   textColor: ColorConstants.black,
            //   noMoreText: "noMoreText".tr,
            //   loadText: "loadText".tr,
            //   loadReadyText: "loadReadyText".tr,
            //   loadingText: "loadingText".tr,
            //   loadedText: "loadedText".tr,
            //   showInfo: true,
            //   loadFailedText: "loadFailedText".tr,
            //   infoColor: ColorConstants.primaryColor,
            //   // infoText:
            //   //     "${"infoTextTime".tr}:${now.hour}${"dian".tr}${now.minute}${"fen".tr}",
            // ),
          );
  }
}
