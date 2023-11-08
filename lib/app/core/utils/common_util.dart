// ignore_for_file: prefer_const_declarations, non_constant_identifier_names

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:live/app/core/constants/app_constants.dart';
import 'package:live/app/data/model/user_model.dart';
import 'package:live/app/routes/app_routes.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';

import 'my_color.dart';

class CommonUtil {
  /// Regex of simple mobile.
  static final String regexMobileSimple = '^[1]\\d{10}\$';

  /// Regex of exact mobile.
  ///  <p>china mobile: 134(0-8), 135, 136, 137, 138, 139, 147, 150, 151, 152, 157, 158, 159, 165, 172, 178, 182, 183, 184, 187, 188, 195, 198</p>
  ///  <p>china unicom: 130, 131, 132, 145, 155, 156, 166, 167, 171, 175, 176, 185, 186</p>
  ///  <p>china telecom: 133, 153, 162, 173, 177, 180, 181, 189, 199, 191</p>
  ///  <p>global star: 1349</p>
  ///  <p>virtual operator: 170</p>
  static final String regexMobileExact =
      '^((13[0-9])|(14[57])|(15[0-35-9])|(16[2567])|(17[01235-8])|(18[0-9])|(19[1589]))\\d{8}\$';

  static final String pwExact =
      '^(?![0-9]+\$)(?![a-zA-Z]+\$)[0-9A-Za-z]{8,20}\$';

  static void commonAlert({
    String title = "提示",
    required Widget content,
    bool isDismiss = true,
    Color bgColor = Colors.white,
    Widget? confirm,
    Widget? cancel,
    String? textCancel,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    VoidCallback? onCustom,
    Future<bool> Function()? onWillPop,
  }) {
    Get.defaultDialog(
      title: title,
      content: content,
      radius: 10,
      textCancel: textCancel,
      onCancel: onCancel,
      onConfirm: onConfirm,
      onCustom: onCustom,
      titlePadding: const EdgeInsets.symmetric(vertical: 10),
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      buttonColor: MyColor("#F12E52"),
      confirm: confirm,
      cancel: cancel,
      onWillPop: () async {
        return true;
      },
      backgroundColor: bgColor,
      barrierDismissible: isDismiss,
    );
  }

  static showBarBottomSheet({
    required Widget child,
    Color? barrierColor,
    Color backgroundColor = Colors.black,
    bool expand = false,
    double radius = 20,
  }) {
    showBarModalBottomSheet(
        context: Get.context!,
        barrierColor: barrierColor ?? MyColor("#000000", alpha: 0.3),
        backgroundColor: Colors.black,
        expand: expand,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        builder: (context) {
          return child;
        });
  }

  // static bool isFloatRex(String value) {
  //   RegExp regExp = RegExp("^\\d+(.\\d+)?\$");
  //   return regExp.hasMatch(value);
  // }

  // 邮箱判断
  static bool isEmail(String input) {
    String regexEmail =
        "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$";
    if (input.isEmpty) return false;
    return RegExp(regexEmail).hasMatch(input);
  }

  static bool isLogin() {
    if (GetStorage().hasData(AppConstants.TokenKey)) {
      return true;
    } else {
      return false;
    }
  }

  static String getUserId() {
    if (GetStorage().hasData(AppConstants.UserDataKey)) {
      return UserModel.fromJson(
              GetStorage().read<String>(AppConstants.UserDataKey)!)
          .id
          .toString();
    } else {
      return "";
    }
  }

  static UserModel? getUser() {
    if (GetStorage().hasData(AppConstants.UserDataKey)) {
      return UserModel.fromJson(
          GetStorage().read<String>(AppConstants.UserDataKey)!);
    } else {
      return null;
    }
  }

  static Future<void> setUser(UserModel user) async {
    await GetStorage().write(AppConstants.UserDataKey, user.toJson());
  }

  static Future<void> removeUser() async {
    await GetStorage().remove(AppConstants.UserDataKey);
  }

  static String getToken() {
    if (GetStorage().hasData(AppConstants.TokenKey)) {
      return GetStorage().read<String>(AppConstants.TokenKey)!;
    } else {
      return "";
    }
  }

  static String getSlug() {
    if (GetStorage().hasData(AppConstants.SlugKey)) {
      return GetStorage().read<String>(AppConstants.SlugKey)!;
    } else {
      return "";
    }
  }

  static String getRefreshToken() {
    if (GetStorage().hasData(AppConstants.RefreshTokenKey)) {
      return GetStorage().read<String>(AppConstants.RefreshTokenKey)!;
    } else {
      return "";
    }
  }

  static Future<void> setToken(String token) async {
    await GetStorage().write(AppConstants.TokenKey, token);
  }

  static Future<void> setRefreshToken(String token) async {
    await GetStorage().write(AppConstants.RefreshTokenKey, token);
  }

  static Future<void> setSlug(String slug) async {
    await GetStorage().write(AppConstants.SlugKey, slug);
  }

  static Future<void> removeToken() async {
    await GetStorage().remove(AppConstants.TokenKey);
  }

  static Future<void> removeRefreshToken() async {
    await GetStorage().remove(AppConstants.RefreshTokenKey);
  }

  static Future<void> removeSlug() async {
    await GetStorage().remove(AppConstants.SlugKey);
  }

  static Future<void> exitLogin() async {
    removeUser();
    removeToken();
    removeRefreshToken();
  }

  // static int getUserId() {
  //   if (GetStorage().hasData(AppConstants.UserDataKey)) {
  //     UserModel userModel = UserModel.fromJson(
  //         GetStorage().read<Map<String, dynamic>>(AppConstants.UserDataKey)!);
  //     return userModel.id;
  //   } else {
  //     return -1;
  //   }
  // }

  /// 跳转页面
  static void jumpToPage(String page, {dynamic arguments}) {
    if (!isLogin()) {
      jumpLoginPage();
      return;
    }
    Get.toNamed(page, arguments: arguments);
  }

  /// 跳转到登录页
  static void jumpLoginPage() {
    Get.toNamed(Routes.Login);
  }

  /// 检测并跳转登录页面
  static bool checkAndJumpToLogin() {
    if (!isLogin()) {
      jumpLoginPage();
      return false;
    } else {
      return true;
    }
  }

  // // static offAllToLoginPage() {
  // //   if (LoginUtil().isNetSuccess) {
  // //     LoginUtil().loginAuth(offAll: true);
  // //   } else {
  // //     jumpAndOffLoginPage();
  // //   }
  // // }

  // static String getMoneyStyleStr(String text, {bool isZero = true}) {
  //   try {
  //     if (text.isEmpty) {
  //       return "";
  //     } else {
  //       String temp = "";
  //       String t = "";
  //       if (text.contains(".")) {
  //         var list = text.split(".");
  //         text = list[0];
  //         t = list[1];
  //       }
  //       if (text.length <= 3) {
  //         temp = text;
  //         // return temp;
  //       } else {
  //         int count = ((text.length) ~/ 3); //切割次数
  //         int startIndex = text.length % 3; //开始切割的位置
  //         if (startIndex != 0) {
  //           if (count == 1) {
  //             temp = text.substring(0, startIndex) +
  //                 "," +
  //                 text.substring(startIndex, text.length);
  //           } else {
  //             temp = text.substring(0, startIndex) + ","; //第一次切割0-startIndex
  //             int syCount = count - 1; //剩余切割次数
  //             for (int i = 0; i < syCount; i++) {
  //               temp += text.substring(
  //                       startIndex + 3 * i, startIndex + (i * 3) + 3) +
  //                   ",";
  //             }
  //             temp += text.substring(
  //                 (startIndex + (syCount - 1) * 3 + 3), text.length);
  //           }
  //         } else {
  //           for (int i = 0; i < count; i++) {
  //             if (i != count - 1) {
  //               temp += text.substring(3 * i, (i + 1) * 3) + ",";
  //             } else {
  //               temp += text.substring(3 * i, (i + 1) * 3);
  //             }
  //           }
  //         }
  //       }
  //       if (t.isNotEmpty) {
  //         if (isZero) {
  //           if (t.length == 1) {
  //             return temp + "." + t + "0";
  //           }
  //         }
  //         return temp + "." + t;
  //       } else {
  //         if (isZero) {
  //           return temp + ".00";
  //         } else {
  //           return temp;
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     return "0";
  //   }
  // }

  static String fourStarString({required String phone}) {
    phone = phone.replaceRange(3, phone.length - 4, "****");
    return phone;
  }

  ///Return whether input matches regex of simple mobile.
  static bool isMobileSimple(String input) {
    return matches(regexMobileSimple, input);
  }

  ///Return whether input matches regex of exact mobile.
  static bool isMobileExact(String input) {
    return matches(regexMobileExact, input);
  }

  static bool isMatchPW(String input) {
    return matches(pwExact, input);
  }

  /// scroll to top
  static scrollTop(ScrollController controller) {
    controller.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.decelerate,
    );
  }

  static bool matches(String regex, String input) {
    if (input.isEmpty) return false;
    return RegExp(regex).hasMatch(input);
  }

  // /// 时区转换 DateTime=>DateTime ()
  // static changeTimeZoneByDateTime(DateTime dateTime, [int timeZone = 3]) {}

  // static String dateFormatByString(String? dateString) {
  //   if (dateString != null) {
  //     String format = '';
  //     if (Get.locale!.languageCode == "en") {
  //       format = "dd-MM-yyyy";
  //       return DateUtil.formatDateStr(dateString, format: format);
  //     } else {
  //       format = "yyyy-MM-dd";
  //       return DateUtil.formatDateStr(dateString, format: format);
  //     }
  //   } else {
  //     return "";
  //   }
  // }

  // static String dateHourFormatByString(String? dateString) {
  //   if (dateString != null) {
  //     String format = '';
  //     if (Get.locale!.languageCode == "en") {
  //       format = "dd-MM-yyyy HH:mm:ss";
  //       return DateUtil.formatDateStr(dateString, format: format);
  //     } else {
  //       format = "yyyy-MM-dd HH:mm:ss";
  //       return DateUtil.formatDateStr(dateString, format: format);
  //     }
  //   } else {
  //     return "";
  //   }
  // }

  //申请存本地相册权限
  static Future<bool> getPhotoPermission() async {

    if (Platform.isIOS) {
      var status = await Permission.photos.status;
      if (status.isDenied) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.photos,
        ].request();
        // saveImage(globalKey);
      }
      return status.isGranted;
    } else {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      int sdk = androidInfo.version.sdkInt;
      var status;
      var permission = Permission.storage;
      if (sdk <= 32) {
        status = await Permission.storage.status;
        // permission = Permission.storage;
      }
      if (sdk > 32) {
        status = await Permission.photos.status;
        permission = Permission.photos;
      }
      debugPrint("status2 $status ");
      if (status == PermissionStatus.denied) {
        Map<Permission, PermissionStatus> statuses = await [
          permission
          // Permission.storage,
          // Permission.photos,
          // Permission.manageExternalStorage,
        ].request();
      }
      return status == PermissionStatus.granted;
    }
  }

  //保存到相册
  static void savePhoto(Uint8List list, {String name = "报告"}) async {
    //获取保存相册权限，如果没有，则申请改权限
    bool permission = await getPhotoPermission();

    var status = await Permission.photos.status;

    if (permission) {
      if (Platform.isIOS) {
        debugPrint("status1 $status");

        if (status.isGranted) {
          await ImageGallerySaver.saveImage(list, quality: 100, name: name);
          EasyLoading.showToast("保存成功");
        }
        if (status.isDenied) {
          print("IOS拒绝");
        }
      } else {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        int sdk = androidInfo.version.sdkInt;

        if (sdk <= 32) {
          status = await Permission.storage.status;
        }

        //安卓
        if (status.isGranted) {
          final result = await ImageGallerySaver.saveImage(list, quality: 100);
          if (result != null) {
            EasyLoading.showToast("保存成功");
          } else {
            print('error');
            // toast("保存失败");
          }
        }
      }
    } else {
      //重新请求--第一次请求权限时，保存方法不会走，需要重新调一次
      savePhoto(list, name: name);
    }
  }

  //申请摄像头权限
  static Future<bool> getCameraPermission() async {

    if (Platform.isIOS) {
      var status = await Permission.camera.status;
      if (status.isDenied) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.camera,
        ].request();
        // saveImage(globalKey);
      }
      return status.isGranted;
    } else {
      // 安卓
      PermissionStatus status = await Permission.camera.status;
      debugPrint("status2 $status ");
      if (status == PermissionStatus.denied) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.camera
        ].request();
      }
      return status == PermissionStatus.granted;
    }
  }

}
