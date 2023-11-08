import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';

class ToastUtil {
  static show(String msg,
          {Duration? duration = const Duration(milliseconds: 1500),
          EasyLoadingToastPosition position = EasyLoadingToastPosition.center,
          bool isDismiss = false,
          EasyLoadingMaskType maskType = EasyLoadingMaskType.clear}) =>
      EasyLoading.showToast(msg,
          duration: duration,
          toastPosition: position,
          dismissOnTap: isDismiss,
          maskType: maskType);

  static Future<void> showStatus(String msg,
      {bool isSuccess = true, int duration = 2}) async {
    if (isSuccess) {
      EasyLoading.showSuccess(msg, duration: Duration(seconds: duration));
    } else {
      EasyLoading.showError(msg, duration: Duration(seconds: duration));
    }
    sleep(Duration(seconds: duration));
  }
}
