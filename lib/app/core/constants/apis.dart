// ignore_for_file: slash_for_doc_comments, constant_identifier_names, non_constant_identifier_names
import 'package:sprintf/sprintf.dart';

class Apis {
  /**------------------------------------------- 用户相关 -------------------------------------------*/
  /**
   * "mobileCountryCode": "86",
   *  "mobile": "13087916286",
   */
  static const String I_User_Send_Code = "/api/users/send_code";
  /**
   * {
    "mobileCountryCode": "86",
    "mobile": "13087916286",
    "verificationCode": "000999"
    }
   */
  static const String I_User_Verify_Code = "/api/users/verify_code";

  /**
   * 
    "mobile": "13087916287",
    "verificationCode": "000999",
    "password": "Ab123456"
   */
  static const String I_User_Register = "/api/users/register";

  /**
   * "mobile": "13087916286",
    "verificationCode": "000999",
    "password": "Ab123456"
   */
  static const String I_User_Login = "/api/users/login";

  /**
   * "mobile": "13087916287",
    "verificationCode": "000999",
    "password": "Abc123456"
   */
  static const String I_User_Forget_PW = "/api/users/forget_password";
  /**
   * "password": "Abc123456",
    "newPassword": "Abc123456"
   */
  static String I_User_Edit_PW(uid) {
    return sprintf("/api/users/%s/reset_password", [uid]);
  }

  static String I_Refresh_Token(uid) {
    return sprintf("/api/users/%s/refresh_token", [uid]);
  }

  static String I_Get_UserInfo(uid) {
    return sprintf("/api/users/%s", [uid]);
  }

  static String I_Put_UserInfo(uid) {
    return sprintf("/api/users/%s", [uid]);
  }

  static String I_Join_Programs(uid) {
    return sprintf("/api/users/%s/user_programs", [uid]);
  }

  static String I_Programs_List(uid) {
    return sprintf("/api/users/%s/user_programs?pageNo=1&pageSize=20", [uid]);
  }

  static String I_Program_Detail(String uid, String pid) {
    return sprintf("/api/users/%s/user_programs/%s", [uid, pid]);
  }

  static String I_Program_Data_Upload(String uid, String pid, String gid) {
    return sprintf(
        "/api/users/%s/user_programs/%s/organization_program_practices/%s/user_practices",
        [uid, pid, gid]);
  }

  static String I_Program_Game_Next(String pid, String gid) {
    return sprintf(
        "/api/user_programs/%s/organization_program_practices/%s/next_practice",
        [pid, gid]);
  }

  /// 报告列表 get
  static String I_Report_List(String oid) {
    return sprintf("/api/report/%s/list", [oid]);
  }

  /// 生成报告
  /// {
  //   "organizationProgramId": 0,
  //   "userId": 0
  // }
  static String I_Report_Create = "/api/report/create";

  /// 刷新测评
  /// {
  //   "organizationProgramId": 0,
  //   "userId": 0
  // }
  static String I_Report_Flush = "/api/report/flush";

  /// 报告详情
  /// id 报告id
  static String I_Report_Detail = "/api/report/info";

  /// 删除测评
  /// 报告id
  /// "ids": [
  //   0
  // ]
  static String I_Report_Delete = "/api/report/remove";

  /**------------------------------------------- 用户相关 -------------------------------------------*/

/**------------------------------------------- 文件上传 -------------------------------------------*/
}
