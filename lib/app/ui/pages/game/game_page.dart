import 'package:live/app/core/constants/color_constants.dart';
import 'package:live/app/core/utils/common_util.dart';
import 'package:live/app/core/utils/my_color.dart';
import 'package:live/app/core/utils/my_image.dart';
// import 'package:live/app/data/mock/loading_tip_mock.dart';
import 'package:live/app/ui/components/webview_widget.dart';
import 'package:live/app/ui/pages/game/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

class GamePageView extends StatelessWidget {
  const GamePageView({super.key});

  @override
  Widget build(BuildContext context) {
    GameController controller = Get.put(GameController());
    String url = "https://cdn-mirror-games.wjbrain.com/e_tu_quan_ji/v1.0.2/index.html";
    // String url =
    //     "https://cdn-yupp-games.wjbrain.com/snapshots/e_tu_quan_ji/2022-06-27/index.html?stage=1&firstplay=1&maxScore=1&practiceStageStart=11&userPracticeId=1698804310724&v=1698804310724&";
    print("url链接：$url");
    // final game = Game1();
    return RepaintBoundary(
      child: LoaderOverlay(
        useDefaultLoading: false,
        overlayWholeScreen: true,
        overlayOpacity: 1,
        overlayColor: MyColor("#F0F2F8", alpha: 1),
        overlayWidget: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyImage(
                "ic_game_loading.gif",
                width: 70.w,
                height: 94.5.w,
              ),
              SizedBox(
                height: 10.w,
              ),
              Text(
                "拳击🥊",
                // getRandomTip(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12.sp, color: ColorConstants.textColor6262),
              )
            ],
          ).paddingSymmetric(horizontal: 80.w),
        ),
        child: WebViewWidget(
          url: url,
        ),
      ),
    );

  }
}
