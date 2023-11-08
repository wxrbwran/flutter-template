import 'package:live/app/core/utils/toast_util.dart';
import 'package:live/app/data/model/evaluation_list_model.dart';
import 'package:live/app/data/model/report_list_model.dart';
import 'package:live/app/data/model/report_practices_model.dart';
import 'package:live/app/data/model/report_record_model.dart';
import 'package:live/app/data/model/user_model.dart';

class ModelFactory {
  static T? generateObj<T>(json) {
    if (json == null) {
      return null;
    } else if (T.toString() == "List<Map<String, dynamic>>") {
      List<Map<String, dynamic>> list = [];
      for (var item in json) {
        list.add(item);
      }
      return list as T;
    } else if (T.toString() == "Map<String, dynamic>") {
      Map<String, dynamic> map = json;
      return map as T;
    } else if (T.toString() == "UserModel") {
      // try {
      //   UserModel userModel = UserModel.fromMap(json);
      // } catch (e) {
      //   ToastUtil.show("error");
      //   print(e);
      // }
      UserModel userModel = UserModel.fromMap(json);
      return userModel as T;
    } else if (T.toString() == "ReportListModel") {
      // try {
      //   UserModel userModel = UserModel.fromMap(json);
      // } catch (e) {
      //   ToastUtil.show("error");
      //   print(e);
      // }
      ReportListModel reportListModel = ReportListModel.fromMap(json);
      return reportListModel as T;
    } else if (T.toString() == "EvaluationListModel") {
      // try {
      //   UserModel userModel = UserModel.fromMap(json);
      // } catch (e) {
      //   ToastUtil.show("error");
      //   print(e);
      // }
      EvaluationListModel evaluationListModel =
          EvaluationListModel.fromMap(json);
      return evaluationListModel as T;
    } else if (T.toString() == "List<ReportRecordModel>") {
      List<ReportRecordModel> list = [];
      for (var item in json) {
        list.add(ReportRecordModel.fromMap(item));
      }
      return list as T;
    } else if (T.toString() == "ReportPracticesModel") {
      // try {
      //   UserModel userModel = UserModel.fromMap(json);
      // } catch (e) {
      //   ToastUtil.show("error");
      //   print(e);
      // }
      ReportPracticesModel reportModel = ReportPracticesModel.fromMap(json);
      return reportModel as T;
    }

    // else if (T.toString() == "List<ImagesModel>") {
    //   List<ImagesModel> list = [];
    //   for (var item in json) {
    //     list.add(ImagesModel.fromJson(item));
    //   }
    //   return list as T;
    // } else if (T.toString() == "List<ImageModel>") {
    //   List<ImageModel> list = [];
    //   for (var item in json) {
    //     list.add(ImageModel.fromJson(item));
    //   }
    //   return list as T;
    // } else if (T.toString() == "List<ImagesTagModel>") {
    //   List<ImagesTagModel> list = [];
    //   for (var item in json) {
    //     list.add(ImagesTagModel.fromJson(item));
    //   }
    //   return list as T;
    // } else if (T.toString() == "List<ImagesNameModel>") {
    //   List<ImagesNameModel> list = [];
    //   for (var item in json) {
    //     list.add(ImagesNameModel.fromJson(item));
    //   }
    //   return list as T;
    // } else if (T.toString() == "ImagesDetailModel") {
    //   ImagesDetailModel imagesDetailModel = ImagesDetailModel.fromJson(json);
    //   return imagesDetailModel as T;
    // }  else if (T.toString() == "UserViewsModel") {
    //   UserViewsModel userModel = UserViewsModel.fromJson(json);
    //   return userModel as T;
    // }
    // else if (T.toString() == "HomeModel") {
    //   return HomeModel.fromJson(json) as T;
    // } else if (T.toString() == "List<VideoModel>") {
    //   List<VideoModel> list = [];
    //   for (var item in json) {
    //     list.add(VideoModel.fromJson(item));
    //   }
    //   return list as T;
    // } else if (T.toString() == "List<PersonPointModel>") {
    //   List<PersonPointModel> list = [];
    //   for (var item in json) {
    //     list.add(PersonPointModel.fromJson(item));
    //   }
    //   return list as T;
    // } else if (T.toString() == "UpdateInfoModel") {
    //   return UpdateInfoModel.fromJson(json) as T;
    // } else if (T.toString() == "List<AnswerModel>") {
    //   List<AnswerModel> list = [];
    //   for (var item in json) {
    //     list.add(AnswerModel.fromJson(item));
    //   }
    //   return list as T;
    // } else if (T.toString() == "List<AnswerResultModel>") {
    //   List<AnswerResultModel> list = [];
    //   for (var item in json) {
    //     list.add(AnswerResultModel.fromJson(item));
    //   }
    //   return list as T;
    // } else if (T.toString() == "List<NotifyModel>") {
    //   List<NotifyModel> list = [];
    //   for (var item in json["result"]) {
    //     list.add(NotifyModel.fromJson(item));
    //   }
    //   return list as T;
    // } else if (T.toString() == "SxyModel") {
    //   return SxyModel.fromJson(json) as T;
    // }
  }
}
