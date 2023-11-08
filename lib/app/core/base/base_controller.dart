import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:live/app/core/constants/app_constants.dart';
import 'package:live/app/core/enum/http_net_state.dart';

abstract class BaseController extends GetxController {
  late HttpNetState netState;

  loadData();
  @override
  void onInit() {
    // TODO: implement onInit
    netState = HttpNetState.none;
    // GetStorage().listenKey(AppConstants.LocaleKey, (value) {
    //   loadData();
    // });
    super.onInit();
  }

  @override
  void onClose() {
    EasyLoading.dismiss();
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    super.onClose();
  }
}
