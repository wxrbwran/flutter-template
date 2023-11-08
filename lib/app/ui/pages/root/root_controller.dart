import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:live/app/core/base/base_controller.dart';
import 'package:live/app/core/controller/app_controller.dart';
import 'package:live/app/core/base/response_model.dart';
import 'package:live/app/core/constants/apis.dart';
import 'package:live/app/core/constants/color_constants.dart';
import 'package:live/app/core/enum/common_alert_enum.dart';
import 'package:live/app/core/eventModel/root_refresh_event.dart';
import 'package:live/app/core/utils/common_util.dart';
import 'package:live/app/core/utils/global_event.dart';
import 'package:live/app/core/utils/requests.dart';
import 'package:live/app/core/utils/toast_util.dart';
import 'package:live/app/data/mock/report_mock.dart';
import 'package:live/app/data/model/report_list_model.dart';
import 'package:live/app/data/model/user_model.dart';
import 'package:live/app/routes/app_routes.dart';
import 'package:live/app/ui/components/alert/common_alert_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';


class RootController extends BaseController {
  List<ReportModel> list = [];
  late ReportListModel? listModel;
  late MethodChannel gamePlatform;
  late UserModel? userModel;
  late EasyRefreshController easyRefreshController;
  late bool hasReport;
  @override
  void onInit() {
    // TODO: implement onInit
    easyRefreshController = EasyRefreshController();
    gamePlatform = AppController.gamePlatform;

    userModel = null;
    listModel = null;
    hasReport = false;
    if (CommonUtil.isLogin() && CommonUtil.getUser() != null) {
      userModel = CommonUtil.getUser();
      loadData();
      GlobalEvent().eventBus.on<RootRefreshEvent>().listen(
        (event) {
          loadData();
        },
      );
    }

    super.onInit();
  }

  @override
  void onReady() {
    if (!CommonUtil.isLogin()) {
      Get.toNamed(Routes.Login);
    } else {
      UserModel? userModel = CommonUtil.getUser();
      if (userModel != null && userModel.fullName == null) {
        // Get.toNamed(Routes.RegisterInfo);
        Get.toNamed(Routes.Login);
      }
    }
    // CommonAlertModel alertModel = CommonAlertModel(
    //     icon: "", title: "查看设备信息", alertEnum: CommonAlertEnum.alertDeviceInfo);
    // Get.toNamed(Routes.Alert, arguments: alertModel);
    super.onReady();
  }


  @override
  loadData() async {
    EasyLoading.show(status: "加载中...");
    easyRefreshController.finishRefresh();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    easyRefreshController.dispose();
    super.onClose();
  }


  selectRecord(ReportModel model) {
    if (model.status == 0) {
      ToastUtil.show("项目已暂停");
      return;
    }
    for (var m in list) {
      if (m.id == model.id) {
        m.isSelected = true;
      } else {
        m.isSelected = false;
      }
    }
    // Get.toNamed(Routes.Evaluation, arguments: {"model": model});
    update();
  }

  handlePlatformInit() async {
    await CommonUtil.getCameraPermission();
    await CommonUtil.getPhotoPermission();
    log("init");
    // final res = await gamePlatform.invokeMethod("getBatteryLevel");
    final res = await gamePlatform.invokeMethod("initVisionSDK");
    log('res $res');
  }

  showDialog() {
    CommonAlertModel alertModel = CommonAlertModel(
      icon: "ic_alert_6",
      title: "完成评测",
      finish: true,
      alertEnum: CommonAlertEnum.alertGameOver,
    );
    Get.toNamed(Routes.Alert, arguments: alertModel);
    log("showDialog");

  }
}
