
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:live/app/data/model/report_list_model.dart';
import 'package:live/app/core/utils/my_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live/app/core/constants/color_constants.dart';

import '../root_controller.dart';

class RootRecordWidget extends StatelessWidget {
  const RootRecordWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootController>(builder: (controller) {
      return SizedBox(
        height: 200.w,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            ReportModel model = controller.list[index];
            bool isSelect = model.isSelected;
            return InkWell(
              onTap: () {
                controller.selectRecord(model);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: MyImage(model.coverUrl,
                        width: isSelect ? 186.w : 148.w,
                        height: isSelect ? 166.w : 132.w),
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  Text(
                    model.name,
                    style: TextStyle(
                      color:
                      isSelect ? Colors.black : ColorConstants.text363636,
                      fontSize: isSelect ? 16.sp : 13.sp,
                      fontWeight: isSelect ? FontWeight.w600 : FontWeight.w500,
                    ),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 10.w,
            );
          },
          itemCount: controller.list.length,
        ),
      );
    });
  }
}