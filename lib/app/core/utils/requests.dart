import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';

import 'package:live/app/routes/app_routes.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';

import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide FormData, Response;

import 'package:package_info_plus/package_info_plus.dart';
import 'package:live/app/core/base/response_model.dart';
import 'package:live/app/core/constants/app_constants.dart';
import 'package:live/app/core/controller/user_controller.dart';
import 'package:live/app/core/utils/toast_util.dart';
// import 'package:sentry_dio/sentry_dio.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';

import 'common_util.dart';

// import 'package:permission_handler/permission_handler.dart';

enum HttpMethod { GET, POST, PUT, DELETE }

// ignore: constant_identifier_names
const HttpMethodValues = {
  HttpMethod.GET: "get",
  HttpMethod.POST: "post",
  HttpMethod.DELETE: "delete",
  HttpMethod.PUT: "put"
};

class RequestTool {
  factory RequestTool() => _getInstance()!;
  static RequestTool get instance => _getInstance()!;
  static RequestTool? _instance;
  // late ISentrySpan transaction;
  Dio? dio;
  RequestTool._init() {
    if (dio == null) {
      dio = Dio()
        ..options.method = HttpMethodValues[HttpMethod.POST]!
        ..options.connectTimeout = const Duration(seconds: 20)
        ..options.contentType = Headers.jsonContentType
        // ..options.responseType = ResponseType.json
        // ..options.baseUrl = Apis.BASEURL
        ..options.receiveTimeout = const Duration(seconds: 20);

      // if (kIsWeb) {
      //   dio!.httpClientAdapter = BrowserHttpClientAdapter();
      // }
      // dio!.addSentry();
      // transaction = Sentry.startTransaction(
      //   'dio-web-request',
      //   'request',
      //   bindToScope: true,
      // );
      if (kDebugMode) {
        dio!.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
      }
      dio!.interceptors
        ..add(DioLogInterceptor())
        ..add(InterceptorsWrapper(
            onRequest: (RequestOptions options, handler) async {
          String auth = CommonUtil.getToken().isEmpty
              ? ""
              : AppConstants.tokenPre + CommonUtil.getToken();
          PackageInfo packageInfo = await PackageInfo.fromPlatform();
          if (auth.isEmpty) {
            options.headers = {
              "Authorization": auth,
              // "userId": Get.find<UserController>().getUserId(),
              "Version": packageInfo.version,
              "Content-Type": Headers.jsonContentType,
            };
            options.contentType = Headers.jsonContentType;
          } else {
            options.headers = {
              "Authorization": auth,
              // "userId": Get.find<UserController>().getUserId(),
              "Version": packageInfo.version,
              "Content-Type": Headers.jsonContentType,
            };
            options.contentType = Headers.jsonContentType;
          }
          // 拦截请求
          return handler.next(options);
        }, onResponse: (Response response, handler) async {
          return handler.next(response);
        }, onError: (DioError error, handler) {
          // 报错
          return handler.next(error);
        }));

    }
  }

  static RequestTool? _getInstance() {
    _instance ??= RequestTool._init();
    return _instance;
  }

  ResponseModel? _throwError(DioError? error) {
    switch (error!.type) {
      case DioErrorType.cancel:
        {
          ToastUtil.show("cancel_request".tr);
          return null;
          // throw ({"code": AppConstants.CANCEL, "message": "请求取消"});
        }
      case DioErrorType.connectionTimeout:
        {
          ToastUtil.show("connection_timeout".tr);
          return null;
          // throw ({"code": AppConstants.CONNECT_TIMEOUT, "message": "连接超时"});
        }
      case DioErrorType.sendTimeout:
        {
          ToastUtil.show("request_timeout".tr);
          return null;
          // throw ({"code": AppConstants.SEND_TIMEOUT, "message": "请求超时"});
        }
      case DioErrorType.receiveTimeout:
        {
          ToastUtil.show("response_timeout".tr);
          return null;
          // throw ({"code": AppConstants.RECEIVE_TIMEOUT, "message": "响应超时"});
        }
      case DioErrorType.badResponse:
        {
          try {
            int? errCode = error.response!.statusCode!;
            if (error.response != null && error.response!.data != null) {
              ErrorModel errorModel;
              if (error.response!.data is Map) {
                errorModel = ErrorModel.fromMap(error.response!.data['error']);
              } else {
                Map map = json.decode(error.response!.data);
                errorModel = ErrorModel.fromMap(map['error']);
              }
              if (errorModel.code == 10005 ||
                  errorModel.code == 10011 ||
                  errorModel.code == 10021) {
                UserController userController = Get.find();
                userController.clearUserInfo();
                Get.offAllNamed(Routes.Login);
              }

              ResponseModel responseModel =
                  ResponseModel(success: false, error: errorModel, data: null);
              ToastUtil.show(errorModel.details ?? errorModel.message);
              return responseModel;
            }

            ToastUtil.show("unknown_error");
            return null;
            // throw ({"code": errCode, "message": errMsg});
          } on Exception catch (e) {
            ToastUtil.show("unknown_error".tr);
            return null;
            // throw ({"code": -1, "message": "未知错误"});
          }
        }
      default:
        {
          ToastUtil.show(error.message ?? "unknown_error".tr);
          return null;
          // throw ({"code": -1, "message": error.message});
        }
    }
  }

  Future<ResponseModel?> request<T>(
    String url, {
    HttpMethod method = HttpMethod.POST,
    bool isJson = true,
    String? path,
    dynamic data,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? params,
    bool isAes = false,
    bool isUpload = false,
  }) async {
    params ??= {};
    queryParams ??= {};
    bool isWeb = false;
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        Map<String, dynamic>? deviceMap;
        if (Platform.isAndroid) {
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          deviceMap = {
            "device_name": androidInfo.model,
            "device_system_name": androidInfo.device,
          };
        } else if (Platform.isIOS) {
          IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
          deviceMap = {
            "device_name": iosInfo.name,
            "device_system_name": iosInfo.systemName,
            "device_system_version": iosInfo.systemVersion
          };
        }
        String version = packageInfo.version;
        Map<String, dynamic> additionMap = {
          "mtype": Platform.isAndroid ? 'android' : 'ios',
          "version": version,
        };

        params.addAll(additionMap);
        params.addAll(deviceMap!);
      }
    } catch (e) {
      isWeb = true;
    }
    if (isWeb) {
      params.addAll({"mType": "web"});
    }

    // if (isAes) {
    //   var encrypter =
    //       Encrypter(AES(Key.fromUtf8(AppConstants.AES_KEY), mode: AESMode.cbc));
    //   var encrypted = encrypter.encrypt(convert.json.encode(params),
    //       iv: IV.fromUtf8(AppConstants.AES_IV));
    //   var aseData = encrypted.base64;
    //   var content = convert.utf8.encode(AppConstants.AES_IV);
    //   var iv = convert.base64Encode(content);
    //   // String t = "iv=" + iv + "&" + "udata=" + aseData;
    //   params = {"iv": iv, "udata": aseData};
    // }
    late String urlStr;
    if (url.contains("http")) {
      urlStr = url;
    } else {
      urlStr = AppConstants.BASEURL + url;
    }
    // queryParams.addAll({"lang": Get.locale!.languageCode});
    var formData = FormData.fromMap(params);

    late dynamic d;
    if (data != null) {
      d = data;
    } else {
      d = isUpload ? formData : params;
    }
    try {
      Response res = await dio!.request(urlStr,
          data: d,
          queryParameters: params,
          options: Options(
            method: HttpMethodValues[method],
            contentType: isJson
                ? Headers.jsonContentType
                : Headers.formUrlEncodedContentType,
          ));
      // transaction.status = SpanStatus.fromHttpStatusCode(res.statusCode ?? -1);
      Map<String, dynamic>? map;
      if (res.data is Map) {
        map = res.data;
      } else {
        map = convert.json.decode(res.data);
      }
      ResponseModel? resModel = ResponseModel.fromMap<T>(map);
      if (resModel!.success) {
        // if (resModel.code == 401) {
        //   /// 重新登录
        //   // await Get.find<UserController>().removeLoginData();
        //   // Get.toNamed(Routes.Login);
        //   // CommonUtil.showLoginAlert(Get.context!);
        //   // NavigatorUtil.push(Application.homeContext, Routes.loginIndex, replace: true);
        // }
        if (resModel.error != null && resModel.error!.code != 200) {
          // if (resModel.code == 555) {
          //   GetStorage().remove(AppConstants.UserDataKey);
          //   Get.find<UserController>().clearUserData();
          //   EasyLoading.dismiss();
          // } else {
          //   ToastUtil.show(resModel.message!);
          // }
          if (resModel.error!.details != null) {
            ToastUtil.show(resModel.error!.details!);
          } else {
            ToastUtil.show(resModel.error!.message);
          }
        }
        return resModel;
      }
      return resModel;
    } catch (e) {
      // transaction.throwable = e;
      // transaction.status = const SpanStatus.internalError();
      return _throwError(e as DioError);
    } finally {
      // await transaction.finish();
    }
  }

  // Future<Response> downLoadRequest(String url) async {
  //   return await dio!
  //       .get(url, options: Options(responseType: ResponseType.bytes));
  // }

  // void downloadRequest(String url, {ProgressCallback? progressCallback}) async {
  //   if (await checkPermissFunction()) {
  //     ///手机储存目录
  //     Directory directory = await getApplicationDocumentsDirectory();
  //     String savePath = directory.path;
  //     String appName = "kt.apk";
  //     await dio?.download(url, savePath + appName,
  //         onReceiveProgress: progressCallback,
  //         options: Options(receiveTimeout: 300000, method: "get"));
  //     openApk(savePath + appName);
  //   }
  // }

  //PermissionGroup.storage 对应的是
  //android 的外部存储 （External Storage）
  //ios 的Documents` or `Downloads`
  // checkPermissFunction() async {
  //   if (Platform.isAndroid) {
  //     ///安卓平台中 checkPermissionStatus方法校验是否有储存卡的读写权限
  //     PermissionStatus status = await Permission.storage.request();
  //     // .checkPermissionStatus(PermissionGroup.storage);
  //     if (status == PermissionStatus.granted) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  // Future<void> openApk(path) async {
  //   OpenResult result = await OpenFile.open(path);
  //   if (result.type == ResultType.done) {}
  //   print(result);
  // }
}
