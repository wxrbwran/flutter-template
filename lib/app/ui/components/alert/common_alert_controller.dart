import 'dart:async';
import 'dart:io';

import 'package:live/app/core/base/base_controller.dart';
import 'package:live/app/core/base/response_model.dart';
import 'package:live/app/core/constants/apis.dart';
import 'package:live/app/core/enum/common_alert_enum.dart';
import 'package:live/app/core/eventModel/root_refresh_event.dart';
import 'package:live/app/core/utils/common_util.dart';
import 'package:live/app/core/utils/global_event.dart';
import 'package:live/app/core/utils/requests.dart';
import 'package:live/app/core/utils/toast_util.dart';
import 'package:live/app/data/model/evaluation_list_model.dart';
import 'package:live/app/data/model/user_model.dart';
import 'package:live/app/routes/app_routes.dart';
import 'package:live/app/ui/components/alert/common_alert_model.dart';
// import 'package:live/app/ui/pages/evaluation/evaluation_controller.dart';
import 'package:live/app/ui/pages/game/game_controller.dart';
// import 'package:live/app/ui/pages/report/report_content_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

class CommonAlertController extends BaseController {
  late CommonAlertModel alertModel;
  late String phone;
  late String pw;
  late String pw1;
  late String code;
  late String newPW;
  late String new1PW;
  late String phoneError;
  late String codeError;
  late String pwError;
  late String pw1Error;
  late String newPW1Error;
  late String newPWError;

  /// 游戏相关
  late GameController? gameController;

  /// 加入项目邀请码
  late String inviteCode;
  late String inviteCodeError;
  late bool isInput;

  late ScrollController? scrollController;
  late bool isScrollBottom;
  @override
  void onInit() {
    // TODO: implement onInit
    alertModel = Get.arguments;
    phone = '';
    pw = '';
    pw1 = '';
    code = '';
    newPW = '';
    new1PW = '';
    phoneError = '';
    codeError = '';
    pwError = '';
    pw1Error = '';
    newPW1Error = '';
    newPWError = '';
    inviteCode = '';
    inviteCodeError = '';
    isInput = false;

    if (alertModel.alertEnum == CommonAlertEnum.alertGameOver ||
        alertModel.alertEnum == CommonAlertEnum.alertReport ||
        alertModel.alertEnum == CommonAlertEnum.alertFinish) {
      try {
        gameController = Get.find<GameController>();
      } catch (e) {
        gameController = null;
      }
    }
    isScrollBottom = false;
    scrollController = null;
    if (alertModel.alertEnum == CommonAlertEnum.alertProtocol) {
      scrollController = ScrollController();

      scrollController?.addListener(() {
        if (scrollController!.offset ==
            scrollController!.position.maxScrollExtent) {
          /// 滚动到最底部
          isScrollBottom = true;
          update();
        }
        print("当前滚动距离:${scrollController!.offset.toString()}\n");
        print(
            "最大滚动距离:${scrollController!.position.maxScrollExtent.toString()}\n");
      });
    }
    super.onInit();
  }

  setPhone(String text) {
    phone = text;
    checkInput();
  }

  setPW(String text) {
    pw = text;
    checkInput();
  }

  setPW1(String text) {
    pw1 = text;
    checkInput();
  }

  setCode(String text) {
    code = text;
    checkInput();
  }

  setNewPW(String text) {
    newPW = text;
    checkInput();
  }

  setNewPW1(String text) {
    new1PW = text;
    checkInput();
  }

  setInviteCode(String text) {
    inviteCode = text;
    checkInput();
  }

  resetError() {
    phoneError = '';
    codeError = '';
    pwError = '';
    pw1Error = '';
    newPW1Error = '';
    newPWError = '';
  }

  checkInput() {
    if (alertModel.alertEnum == CommonAlertEnum.alertForgotPW) {
      if (phone.isNotEmpty &&
          pw.isNotEmpty &&
          pw1.isNotEmpty &&
          code.isNotEmpty) {
        isInput = true;
      } else {
        isInput = false;
      }
    } else if (alertModel.alertEnum == CommonAlertEnum.alertEditPW) {
      if (pw.isNotEmpty && new1PW.isNotEmpty && newPW.isNotEmpty) {
        isInput = true;
      } else {
        isInput = false;
      }
    } else if (alertModel.alertEnum == CommonAlertEnum.alertJoin) {
      if (inviteCode.isNotEmpty) {
        isInput = true;
      } else {
        isInput = false;
      }
    } else {
      isInput = true;
    }
    update();
  }

  /// 下一个测评
  jumpToNext() {
    // if (gameController != null) {
    //   gameController!.jumpToNext();
    //   Get.back();
    // } else {
    //   ToastUtil.show("游戏控制器初始化失败");
    // }
  }

  /// 重新开始
  restart() {
    if (gameController != null) {
      gameController!.restart();
      Get.back();
    } else {
      ToastUtil.show("游戏控制器初始化失败");
    }
  }

  /// 游戏继续进行
  gameContinue() {
    if (gameController != null) {
      gameController!.gameContinue();
      Get.back();
    } else {
      ToastUtil.show("游戏控制器初始化失败");
    }
  }

  Future<bool> getCode() async {
    if (!CommonUtil.isMobileExact(phone)) {
      resetError();
      phoneError = '请输入正确的手机号';
      update();
      return false;
    }
    EasyLoading.show(status: "获取中...");
    ResponseModel? resModel = await RequestTool().request<Map<String, dynamic>>(
        Apis.I_User_Send_Code,
        params: {"mobileCountryCode": "86", "mobile": phone});
    if (resModel != null && resModel.success) {
      EasyLoading.dismiss();
      print(resModel.data);
      return true;
    } else {
      return false;
    }
  }

  forgetPW() async {
    if (!CommonUtil.isMobileExact(phone)) {
      resetError();
      phoneError = '请输入正确的手机号';

      update();
      return;
    }
    if (code.isEmpty) {
      resetError();
      codeError = '请输入验证码';
      update();
      return;
    }

    if (!CommonUtil.isMatchPW(pw)) {
      resetError();
      pwError = "密码不符合规范，请设定8-20位密码，至少包含一位以上数字，大小写字母";
      update();
      return;
    }
    if (pw != pw1) {
      resetError();
      pw1Error = "请确保密码一致";
      update();
      return;
    }
    EasyLoading.show(status: "修改中...");
    ResponseModel? resModel = await RequestTool()
        .request<Map<String, dynamic>>(Apis.I_User_Forget_PW, params: {
      "mobileCountryCode": "86",
      "mobile": phone,
      "verificationCode": code,
      "password": pw,
    });
    if (resModel != null && resModel.success) {
      EasyLoading.dismiss();
      ToastUtil.show("修改成功");
      Future.delayed(const Duration(seconds: 1), () {
        Get.back();
      });
    } else if (resModel != null && resModel.error != null) {
      if (resModel.error!.code == 20002) {
        resetError();
        codeError = resModel.error!.message;

        update();
      }
    }
  }

  editPW() async {
    if (!CommonUtil.isMatchPW(newPW)) {
      resetError();
      newPWError = "密码不符合规范，请设定8位密码，包含至少一个大写字母和数字";
      update();
      return;
    }
    if (new1PW != newPW) {
      resetError();
      newPW1Error = "请确保密码一致";
      update();
      return;
    }
    EasyLoading.show(status: "修改中...");
    ResponseModel? resModel = await RequestTool().request<Map<String, dynamic>>(
        Apis.I_User_Edit_PW(CommonUtil.getUserId()),
        params: {
          "newPassword": newPW,
          "password": pw,
        });
    if (resModel != null && resModel.success) {
      EasyLoading.dismiss();
      ToastUtil.show("修改成功");
      Future.delayed(const Duration(seconds: 1), () {
        // Get.offNamedUntil(Routes.Inital, (route) => false);
        // CommonUtil.exitLogin();
        Get.back();
      });
    }
  }

  joinProgram() async {
    UserModel? userModel = CommonUtil.getUser();
    if (userModel != null) {
      EasyLoading.show(status: "加入中...");
      ResponseModel? resModel = await RequestTool()
          .request<Map<String, dynamic>>(Apis.I_Join_Programs(userModel.id),
              method: HttpMethod.POST,
              params: {
            "code": inviteCode,
          });
      if (resModel != null) {
        if (resModel.success) {
          EasyLoading.dismiss();
          Get.back(result: true);
        } else {
          ErrorModel? errorModel = resModel.error;
          if (errorModel != null) {
            inviteCodeError = errorModel.details ?? "异常错误";
            GlobalEvent().eventBus.fire(RootRefreshEvent());
            update();
          }
        }
      }
    } else {
      ToastUtil.show("该用户未登录");
    }
  }

  /// 刷新评测
  refreshEvaluation() async {
    UserModel? userModel = CommonUtil.getUser();
    if (userModel != null) {
      EasyLoading.show(status: "刷新中...");
      ResponseModel? resModel = await RequestTool()
          .request<Map<String, dynamic>>(Apis.I_Report_Flush,
              method: HttpMethod.POST,
              params: {
            "organizationProgramId": alertModel.organizationProgramId,
            "userId": userModel.id,
          });
      if (resModel != null) {
        if (resModel.success) {
          EasyLoading.dismiss();
          // Get.find<EvaluationController>().resetEvaluation();
          Get.back();
        } else {
          Get.back();
        }
        //  else {
        //   ErrorModel? errorModel = resModel.error;
        //   if (errorModel != null) {
        //     inviteCodeError = errorModel.details ?? "异常错误";
        //     GlobalEvent().eventBus.fire(RootRefreshEvent());
        //     update();
        //   }
        // }
      }
    } else {
      ToastUtil.show("该用户未登录");
    }
  }

  /// 生成报告
  createReport() async {
    UserModel? userModel = CommonUtil.getUser();
    if (userModel != null) {
      EasyLoading.show(status: "生成中...");
      ResponseModel? resModel = await RequestTool()
          .request<Map<String, dynamic>>(Apis.I_Report_Create,
              method: HttpMethod.POST,
              params: {
            "organizationProgramId": alertModel.organizationProgramId,
            "userId": userModel.id,
          });
      if (resModel != null) {
        if (resModel.success) {
          // Get.find<EvaluationController>().resetEvaluation();
          Get.back();
          // Get.toNamed(Routes.Report, arguments: {"loading": false});
          Future.delayed(const Duration(milliseconds: 200), () {
            // Get.toNamed(Routes.ReportDetail, arguments: {
            //   "reportId": resModel.data['reportId'].toString(),
            // });
          });
        } else {
          Get.back();
        }
        //  else {
        //   ErrorModel? errorModel = resModel.error;
        //   if (errorModel != null) {
        //     inviteCodeError = errorModel.details ?? "异常错误";
        //     GlobalEvent().eventBus.fire(RootRefreshEvent());
        //     update();
        //   }
        // }
      }
    } else {
      ToastUtil.show("该用户未登录");
    }
  }

  /// 删除报告记录
  deleteReport(BaseController controller) {
    Get.back();
    // ReportContentController contentController =
    //     controller as ReportContentController;
    // contentController.deleteData();
  }

  @override
  loadData() {
    // TODO: implement loadData
    throw UnimplementedError();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    scrollController?.dispose();
    super.onClose();
  }
}
