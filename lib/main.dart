import 'dart:io';

import 'package:live/app/core/constants/app_constants.dart';
import 'package:live/app/core/controller/user_controller.dart';
import 'app/core/controller/app_controller.dart';

import 'package:live/app/core/utils/my_http_overrides.dart';
import 'package:live/app/routes/app_routes.dart';
import 'package:live/app/ui/components/custom_animation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'app/routes/app_pages.dart';
import 'app/transition/transition.dart';

void main() async {
  await setup();
  if (GetPlatform.isAndroid) {
    SystemUiOverlayStyle style = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    SystemChrome.setSystemUIOverlayStyle(style);
  }
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    GetPlatform.isAndroid
        ? DeviceOrientation.landscapeLeft
        : DeviceOrientation.landscapeRight
  ]).then((_) {
    HttpOverrides.global = MyHttpOverrides();
  });


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize:
        GetPlatform.isAndroid ? const Size(600, 375) : const Size(590, 410),
        builder: (context, child) {
          return GetMaterialApp(
            title: '体感镜',
            debugShowCheckedModeBanner: false,
            routingCallback: (routing) {
              print(routing);
            },
            // initialRoute: Routes.Inital,
            initialRoute: Routes.Game,
            getPages: AppPages.pages,
            translations: Messages(),
            fallbackLocale: const Locale("en", "US"), // error default language

            localeResolutionCallback: (deviceLocale, supportedLocales) {
              /// listen locale state
              // if (deviceLocale != null) {
              //   GetStorage().write(AppConstants.LocaleKey,
              //       deviceLocale.languageCode);
              // }
            },
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('zh', 'CN'),
              Locale('en', 'US'),
            ],
            // locale: localViewModel.currentLocale,
            // theme: themeViewModel.themeData,
            builder: EasyLoading.init(
              builder: (context, widget) {
                ResponsiveWrapper.builder(widget,
                    maxWidth: 1200,
                    minWidth: 410,
                    defaultScale: true,
                    breakpoints: const [
                      ResponsiveBreakpoint.resize(480, name: MOBILE),
                      ResponsiveBreakpoint.autoScale(590, name: TABLET),
                      ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                    ]);
                DevicePreview.appBuilder(context, widget);
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!,
                );
              },
            ),
            home: child,
          );
        });
  }
}

Future<void> setup() async {
  await GetStorage.init();

  // if (!GetStorage().hasData(AppConstants.LixiuTabChangeKey)) {
  //   GetStorage().write(AppConstants.LixiuTabChangeKey, 1);
  // }

  configLoading();

  Get.put(AppController());
  Get.put(UserController());
  // Get.put(LocationController());

  // CommonUtil.removeToken();
  // CommonUtil.removeUser();
  // CommonUtil.removeSlug();

  // await pangle.init(
  //   iOS: IOSConfig(appId: "5157972", logLevel: PangleLogLevel.debug),
  // );
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.wave
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 25.0
    ..radius = 5.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.black
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.3)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}
