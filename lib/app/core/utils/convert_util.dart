import 'dart:convert' as convert;

/// 类型转换工具
class ConvertUtil {
  static double doubleConvertWithString(String str) {
    return double.parse(str);
  }

  /// uri 编码
  static String uriEncode(String str) {
    return Uri.encodeComponent(str);
  }

  /// uri 解码
  static String uriDecode(String uri) {
    return Uri.decodeComponent(uri);
  }
}

class ModelParmaUtil {
  static String mapToString(Map map) {
    return ConvertUtil.uriEncode(convert.jsonEncode(map));
  }
  // static String videoModel(VideoModel vm) {
  //   return ConvertUtil.uriEncode(convert.jsonEncode(vm.toJson()));
  // }

  // static String answerModel(AnswerModel am) {
  //   return ConvertUtil.uriEncode(convert.jsonEncode(am.toJson()));
  // }
}
