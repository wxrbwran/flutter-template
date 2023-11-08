// ignore_for_file: unnecessary_const, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:live/app/core/utils/my_color.dart';

class AppConstants {
  /// 资源 asset
  static const String imageAsset = "assets/images/";

  static const String netImagePrefix =
      "https://wapi.qihuiapp.com/remit-service/profile/";

  // static const String BASEURL = "https://wpg.bacas.com";

  /// http://global-api-staging.bacas.com
  // static const String BASEURL = "https://global-api-staging.bacas.com";

  // global-api-new.bacas.com
  // static const String BASEURL = "https://cc97-116-252-200-100.ngrok.io";

  // static const String BASEURL = "http://163.228.224.4:9091";
  static const String BASEURL = "https://test-api-ocas.wjbrain.com";


  static const String appName = 'bacas';

  static const String tokenPre = 'Bearer ';

  static const bool inProduction =
      const bool.fromEnvironment("dart.vm.product");

  static const bool isTest = true;

  static const String showPrivacy = "showPrivacy";

  static const String PrivacyProtocol = "assets/html/yinsixieyi.html";

  static const String UserProtocol = "assets/html/yonghuxieyi.html";

  ///
  static const String LixiuTabChangeKey = "LixiuTabChangeKey";

  static const String GuideShowKey = "GuideShowKey";

  static const String PushRegisterID = "PushRegisterID";

  static const String APPFirstOpen = "AppFirstOpen";
  static const String APPFirstInstallTime = "APPFirstInstallTime";

  /// location key
  static const String LoationKey = "LoationKey";

  /// locale key
  static const String LocaleKey = "LocaleKey";

  /// history key
  static const String HistoryListKey = "HISTORYLISTKEY";

  // userdata key
  static const String UserDataKey = "UserDataKey";

  /// token
  static const String TokenKey = "TokenKey";

  static const String SlugKey = "SlugKey";

  /// refresh token
  static const String RefreshTokenKey = "RefreshTokenKey";

  static const String MoneyZeroReg = "(\\.\\d+?)0*\$/";

  /// 错误码
  static const int CONNECT_TIMEOUT = 1001;
  static const int SEND_TIMEOUT = 1002;
  static const int RECEIVE_TIMEOUT = 1003;
  static const int RESPONSE = 1004;
  static const int CANCEL = 1005;

  /// 验证码倒计时
  static const int CountBackNumber = 10;

  /// card shadow
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      blurRadius: 10, //阴影范围
      spreadRadius: 0.1, //阴影浓度
      color: MyColor("#CDD4DA"),
    )
  ];

  /// card shadow
  static List<BoxShadow> cardShadow1 = [
    BoxShadow(
      blurRadius: 3, //阴影范围
      spreadRadius: 0.1, //阴影浓度
      color: Colors.grey.withOpacity(0.1),
    )
  ];

  /// 字体样式
  static TextStyle style({
    Color color = Colors.black87,
    double size = 14.0,
    bool isBold = false,
  }) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    );
  }
}
