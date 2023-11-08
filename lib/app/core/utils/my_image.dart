import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live/app/core/constants/app_constants.dart';

// ignore: non_constant_identifier_names
Widget MyImage(String filePath,
    {BoxFit fit = BoxFit.cover,
    double? width,
    double? height,
    String? placeholder,
    Color? color,
    BlendMode? blendMode}) {
  if (filePath.contains("http")) {
    return CachedNetworkImage(
        imageUrl: filePath,
        // httpHeaders: {
        //   "referer": "https://m.mzitu.com/",
        //   "content-type": "image/jpeg",
        //   "user-agent":
        //       "Mozilla/5.0 (Linux; Android 5.0; SM-G900P Build/LRX21T) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Mobile Safari/537.36"
        // },
        colorBlendMode: blendMode,
        width: width,
        height: height,
        color: color,
        fit: fit,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            const CupertinoActivityIndicator()
        //     RefreshProgressIndicator(
        //   value: downloadProgress.progress,
        // ),
        // LinearProgressIndicator(
        //   value: downloadProgress.progress,
        // )
        // CircularProgressIndicator(value: downloadProgress.progress),
        // placeholder: (context, str) {
        //   return placeholder != null
        //       ? MyImage(placeholder, width: width, height: height, fit: fit)
        //       : MyImage("ic_p");
        // },
        );
  } else if (filePath.isEmpty && placeholder!.isNotEmpty) {
    return Image.asset(
      "${AppConstants.imageAsset}$placeholder.png",
      fit: fit,
      width: width,
      height: height,
    );
  } else if (filePath == AppConstants.netImagePrefix) {
    return Image.asset(
      "${AppConstants.imageAsset}ic_p.png",
      fit: fit,
      width: width,
      height: height,
    );
  } else {
    if (filePath.contains(".gif")) {
      return Image.asset(
        "${AppConstants.imageAsset}$filePath",
        fit: fit,
        width: width,
        height: height,
      );
    } else {
      return Image.asset(
        "${AppConstants.imageAsset}$filePath.png",
        fit: fit,
        width: width,
        height: height,
      );
    }
  }
}
