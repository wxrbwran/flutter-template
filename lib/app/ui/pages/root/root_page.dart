import 'package:live/app/core/constants/color_constants.dart';
import 'package:live/app/core/enum/common_alert_enum.dart';
import 'package:live/app/core/enum/common_nav_bar_enum.dart';
import 'package:live/app/core/utils/my_color.dart';
import 'package:live/app/core/utils/my_image.dart';
import 'package:live/app/core/utils/toast_util.dart';
import 'package:live/app/routes/app_routes.dart';
import 'package:live/app/ui/components/alert/common_alert_model.dart';
import 'package:live/app/ui/components/common_bg_container.dart';
import 'package:live/app/ui/components/common_nav_bar.dart';
import 'package:live/app/ui/components/user/user_widget.dart';
import 'package:live/app/ui/pages/root/root_controller.dart';
import 'package:dio_log/overlay_draggable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RootPageView extends StatelessWidget {
  const RootPageView({super.key});

  @override
  Widget build(BuildContext context) {
    // showDebugBtn(context, btnColor: ColorConstants.primaryColor);
    RootController controller = Get.put(RootController());

    return Scaffold(
      body: CommonBgContainer(
        onRefresh: () async {
          controller.loadData();
        },
        navBar: CommonNavBarWidget(
          navBarEnum: CommonNavBarEnum.navBarPerson,
          title: "体感镜",
          rightWidget: const UserWidget(),
          leftAction: () {},
        ),
        horizontalPadding: 10.w,
        refreshController: controller.easyRefreshController,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  controller.handlePlatformInit();
                },
                child: const Text("点击初始化1"),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.showDialog();
                },
                child: const Text("点击弹窗2"),
              )
            ],
          ),
        ),
      ),
    );
  }
}





