import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:live/app/core/enum/common_alert_enum.dart';
import 'package:live/app/core/utils/toast_util.dart';
import 'package:live/app/routes/app_routes.dart';
import 'package:live/app/ui/components/alert/common_alert_model.dart';
import 'package:live/app/ui/pages/game/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class WebViewWidget extends StatefulWidget {
  const WebViewWidget({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;
  @override
  State<WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  late WebViewController webViewController;
  late WebViewPlusController plusController;
  GameController gameController = Get.find<GameController>();
  // final CookieManager _cookieManager = CookieManager();
  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      // WebView.platform = WebWebViewPlatform();
      print("webView");
    } else {
      if (GetPlatform.isAndroid) {
        // WebView.platform = SurfaceAndroidWebView();
      } else {
        // WebView.platform = AndroidWebView();
      }
    }
  }


  JavascriptChannel getJSChannel(BuildContext context) {
    GameController controller = Get.find<GameController>();
    return JavascriptChannel(
        name: 'messageHandler',
        onMessageReceived: (JavascriptMessage message) {
          try {
            String js = message.message;
            var dict = json.decode(js);
            debugPrint('dict: $dict');
            debugPrint((dict['message_type'] == 1).toString());
            if (dict['message_type'] == 1) {
              if (dict['data'] == "game_finish") {
              } else if (dict['data'] == "game_quit") {
                CommonAlertModel alertModel = CommonAlertModel(
                  icon: "ic_alert_1",
                  title: "结束评测",
                  alertEnum: CommonAlertEnum.alertFinish,
                );
                Get.toNamed(Routes.Alert, arguments: alertModel);
              } else if (dict['data'] == "game_ready") {
                /// 游戏准备好
                debugPrint('游戏准备好');
                debugPrint((dict['data'] == "game_ready").toString());

                gameController.hideLoading();
              }
            } else if (dict['message_type'] == 2) {
              /// 游戏向APP发送的游戏数据 请求接口
              if (dict['data'] != null) {
                String js = json.encode(dict['data']);
                controller.uploadGameData(js);
              }
            } else if (dict['message_type'] == 3) {
              /// 重新开始
            }
            print(dict);
          } catch (e) {
            ToastUtil.show(e.toString());
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return WebViewPlus(
      serverPort: 5353,
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: <JavascriptChannel>{
        getJSChannel(context),
      },
      initialUrl: widget.url,
      onWebViewCreated: (controller) {
        plusController = controller;
        webViewController = controller.webViewController;
        try {
          gameController.webViewController = webViewController;
        } catch (e) {
          ToastUtil.show("GameController初始化失败");
        }
      },
      onWebResourceError: ((error) {
        print(error);
      }),
      onPageFinished: (url) {
        plusController.getHeight().then((double height) {
          gameController.resetWebViewFrame();
        });
        print("游戏页面加载完成\n");
        print("url:$url");
      },
    );
    // _createWebView();
  }
}
