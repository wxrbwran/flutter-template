import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:live/app/core/base/base_controller.dart';
import 'package:live/app/core/base/response_model.dart';
import 'package:live/app/core/constants/apis.dart';
import 'package:live/app/core/controller/app_controller.dart';
import 'package:live/app/core/enum/common_alert_enum.dart';
import 'package:live/app/core/utils/common_util.dart';
import 'package:live/app/core/utils/requests.dart';
import 'package:live/app/core/utils/toast_util.dart';
import 'package:live/app/data/model/evaluation_list_model.dart';
import 'package:live/app/data/model/user_model.dart';
import 'package:live/app/routes/app_routes.dart';
import 'package:live/app/ui/components/alert/common_alert_model.dart';
// import 'package:live/app/ui/pages/evaluation/evaluation_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class GameController extends BaseController {
  late WebViewController webViewController;
  late MethodChannel gamePlatform;
  late EvaluationModel? gameModel;
  late String programId;
  late String gameId;
  late String practiceId;
  late String organizationProgramId;
  late bool isReady;

  /// 增加60s倒计时
  late Timer? timer;
  late int count;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isReady = false;
    gamePlatform = AppController.gamePlatform;
    count = 0;
    try {
      gameModel = Get.arguments['model'];
      practiceId = gameModel!.organizationProgramPracticeId.toString();
      gameId = gameModel!.gameId.toString();
    } catch (e) {
      gameModel = null;
      gameId = "";
      practiceId = "";
    }
    try {
      programId = Get.arguments['programId'];
    } catch (e) {
      programId = '';
    }
    try {
      organizationProgramId = Get.arguments['organizationProgramId'];
    } catch (e) {
      organizationProgramId = '';
    }
  }


  @override
  void onReady() async {
    // TODO: implement onReady
    showLoading();
    await callMethodChanel();
    super.onReady();
  }
  Future<void> callMethodChanel() async {
    final int result = await gamePlatform.invokeMethod("getBatteryLevel");
    debugPrint("getBatteryLevel $result");
  }
  @override
  loadData() {
    // TODO: implement loadData
    // throw UnimplementedError();
  }

  countDownTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      count++;
      if (count > 100) {
        t.cancel();
        ToastUtil.show("测评进入失败");
        Future.delayed(const Duration(seconds: 2), () {
          Get.back();
        });
      }
    });
  }

  /// 重置webview尺寸
  resetWebViewFrame() {
    isReady = true;
    // hideLoading();
    update();
  }

  showLoading() {
    // countDownTimer();
    // Get.context!.loaderOverlay.show();
  }

  hideLoading() {
    // timer?.cancel();
    // count = 0;
    // Get.context!.loaderOverlay.hide();
    debugPrint("举双手～");
    Future.delayed(const Duration(seconds: 3))
        .then((value){
        webViewController.runJavascript("window.onHandUp('Left')");
        webViewController.runJavascript("window.onHandUp('Right')");
      }
    );
    // Future.delayed(const Duration(seconds: 15))
    //     .then((value){
    //        webViewController.runJavascript("window.onHandUp('Left')");
    //   }
    // );
  }

  /// 重新开始
  restart() {
    try {
      Map<String, dynamic> map = {"type": "3", "data": "game_restart"};
      String str = json.encode(map);
      webViewController.runJavascript('window.godot_send(\'$str\')');
    } catch (e) {
      print("js执行失败");
    }
  }

  /// 游戏重新开始
  gameContinue() {
    try {
      Map<String, dynamic> map = {"type": "5", "data": "game_continue"};
      String str = json.encode(map);
      webViewController.runJavascript('window.godot_send(\'$str\')');
    } catch (e) {
      print("js执行失败");
    }
  }

  uploadGameData(String json) async {
    UserModel? userModel = CommonUtil.getUser();
    if (userModel != null) {
      EasyLoading.show(status: "数据正在上传...");
      debugPrint(json);
      debugPrint('uploadGameData: ${json.toString()}');
      ResponseModel? resModel =
          await RequestTool().request<Map<String, dynamic>>(
        Apis.I_Program_Data_Upload(
          userModel.id.toString(),
          programId,
          gameModel!.organizationProgramPracticeId.toString(),
        ),
        method: HttpMethod.POST,
        data: json,
        params: {},
      );
      if (resModel != null && resModel.success) {
        EasyLoading.dismiss();
        gameFinish();
        // update();
      } else {
        Get.back();
      }
    } else {
      ToastUtil.show("该用户未登录");
    }
  }

  gameFinish() {
    /// 游戏结束
    if (gameModel!.isLast) {
      CommonAlertModel alertModel = CommonAlertModel(
        icon: "ic_alert_6",
        title: "完成评测",
        finish: gameModel!.isLast,
        alertEnum: CommonAlertEnum.alertGameOver,
      );
      Get.toNamed(Routes.Alert, arguments: alertModel);
    } else {
      CommonAlertModel alertModel = CommonAlertModel(
        icon: "ic_alert_6",
        title: "完成评测",
        finish: gameModel!.isLast,
        alertEnum: CommonAlertEnum.alertGameOver,
      );
      Get.toNamed(Routes.Alert, arguments: alertModel);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    // webViewController.clearCache();
    // webViewController = null;
    timer?.cancel();
    super.onClose();
  }
}
