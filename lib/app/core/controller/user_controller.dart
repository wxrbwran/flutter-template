import 'package:live/app/core/base/base_controller.dart';
import 'package:live/app/core/constants/app_constants.dart';
import 'package:live/app/core/controller/app_controller.dart';
// import 'package:live/app/core/eventModel/login_evnet_model.dart';
import 'package:live/app/core/utils/common_util.dart';
import 'package:live/app/core/utils/global_event.dart';
import 'package:live/app/data/model/user_model.dart';

import 'package:get/get.dart';

class UserController extends BaseController {
  late AppController appController;
  late UserModel? userModel;

  @override
  void onInit() {
    userModel = null;

    appController = Get.find<AppController>();
    loadData();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  loadData() {
    userModel = CommonUtil.getUser();
    update();
  }

  updataUserInfo(UserModel m) {
    userModel = m;
    CommonUtil.setUser(userModel!);
    CommonUtil.setToken(userModel!.accessToken);
    CommonUtil.setRefreshToken(userModel!.refreshToken);
    update();
  }

  updataOtherInfo() {
    if (userModel != null) {}
  }

  clearUserInfo() {
    CommonUtil.removeRefreshToken();
    CommonUtil.removeToken();
    CommonUtil.removeUser();
  }
}
