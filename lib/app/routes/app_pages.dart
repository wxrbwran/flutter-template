import 'package:live/app/routes/app_routes.dart';
import 'package:live/app/ui/components/alert/common_alert.dart';
// import 'package:live/app/ui/pages/evaluation/evaluation_page.dart';
import 'package:live/app/ui/pages/game/game_page.dart';
// import 'package:live/app/ui/pages/login/login_page.dart';
// import 'package:live/app/ui/pages/login/person_info_submit_page.dart';
// import 'package:live/app/ui/pages/login/register_page.dart';
// import 'package:live/app/ui/pages/person/person_page.dart';
// import 'package:live/app/ui/pages/qr/qr_page.dart';
// import 'package:live/app/ui/pages/report/report_detail_page.dart';
// import 'package:live/app/ui/pages/report/report_page.dart';
import 'package:live/app/ui/pages/root/root_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.Inital,
      page: () => const RootPageView(),
      transition: Transition.fadeIn,
      popGesture: false,
    ),
    GetPage(
      name: Routes.Game,
      page: () => const GamePageView(),
      transition: Transition.fadeIn,
      popGesture: false,
    ),
    GetPage(
      name: Routes.Alert,
      opaque: false,
      page: () => const CommonAlert(),
      transition: Transition.fadeIn,
      popGesture: false,
    ),
    // GetPage(
    //   name: Routes.Login,
    //   page: () => const LoginPageView(),
    //   transition: Transition.fadeIn,
    //   popGesture: false,
    // ),
    // GetPage(
    //   name: Routes.Register,
    //   page: () => const RegisterPageView(),
    //   transition: Transition.fadeIn,
    //   popGesture: false,
    // ),

    // GetPage(
    //   name: Routes.RegisterInfo,
    //   page: () => const PersonInfoSubmitPageView(),
    //   transition: Transition.fadeIn,
    //   popGesture: false,
    // ),
    // GetPage(
    //   name: Routes.Evaluation,
    //   page: () => const EvaluationPageView(),
    //   transition: Transition.fadeIn,
    //   popGesture: false,
    // ),
    // GetPage(
    //   name: Routes.Person,
    //   page: () => const PersonPageView(),
    //   transition: Transition.fadeIn,
    //   popGesture: false,
    // ),
    // GetPage(
    //   name: Routes.Report,
    //   page: () => const ReportPageView(),
    //   transition: Transition.fadeIn,
    //   popGesture: false,
    // ),
    // GetPage(
    //   name: Routes.ReportDetail,
    //   page: () => const ReportDetailPageView(),
    //   transition: Transition.fadeIn,
    //   popGesture: false,
    // ),

    // GetPage(
    //   name: Routes.QR,
    //   page: () => const QrPageView(),
    //   transition: Transition.fadeIn,
    //   popGesture: false,
    // ),
  ];
}
