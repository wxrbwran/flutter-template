import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:get_storage/get_storage.dart';
// import 'package:jpush_flutter/jpush_flutter.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:live/app/core/base/base_controller.dart';
import 'package:live/app/core/base/response_model.dart';
import 'package:live/app/core/constants/apis.dart';
import 'package:live/app/core/constants/app_constants.dart';
import 'package:live/app/core/constants/color_constants.dart';
import 'package:live/app/core/controller/user_controller.dart';
import 'package:live/app/core/enum/category_enum.dart';
import 'package:live/app/core/eventModel/app_life_resumed_model.dart';
import 'package:live/app/core/utils/common_util.dart';
import 'package:live/app/core/utils/global_event.dart';
import 'package:live/app/core/utils/requests.dart';

// import 'package:mobpush_plugin/mobpush_plugin.dart';

class AppController extends BaseController with WidgetsBindingObserver {
  AppController();
  late bool isEle;
  static const MethodChannel gamePlatform = MethodChannel('live.wjbrain.com/fiture');
  @override
  void onInit() async {
    WidgetsBinding.instance.addObserver(this); //添加观察者
    bool? isFirst = GetStorage().read<bool>(AppConstants.APPFirstOpen);
    if (isFirst == null || !isFirst) {
      GetStorage().write(AppConstants.APPFirstOpen, true);
    }

    super.onInit();
  }

  /// 初始化快捷登录
  initLogin() async {}

  // 获取版本
  Future<dynamic> initPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // version = packageInfo.version;
  }

  // 检查是否需要版本更新
  void _checkUpdateVersion() async {
    await initPackageInfo();
  }

  @override
  loadData() {
    // TODO: implement loadData
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        //  应用程序处于闲置状态并且没有收到用户的输入事件。
        //注意这个状态，在切换到后台时候会触发，所以流程应该是先冻结窗口，然后停止UI
        print('YM----->AppLifecycleState.inactive 应用程序处于闲置状态并且没有收到用户的输入事件。');
        break;
      case AppLifecycleState.paused:
//      应用程序处于不可见状态
        print('YM----->AppLifecycleState.paused 应用程序处于不可见状态');
        break;
      case AppLifecycleState.resumed:
        //    进入应用时候不会触发该状态
        //  应用程序处于可见状态，并且可以响应用户的输入事件。它相当于 Android 中Activity的onResume。
        print('YM----->AppLifecycleState.resumed 应用程序处于可见状态，并且可以响应用户的输入事件');

        GlobalEvent().eventBus.fire(AppLifeResumedModel());

        EasyLoading.dismiss();
        break;
      case AppLifecycleState.detached:
        //当前页面即将退出
        print('YM----->AppLifecycleState.detached 当前页面即将退出');
        break;
    }
  }
}
