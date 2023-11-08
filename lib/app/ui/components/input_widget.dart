import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:live/app/core/constants/app_constants.dart';
import 'package:live/app/core/constants/color_constants.dart';
import 'package:live/app/core/utils/my_color.dart';
import 'package:live/app/core/utils/my_image.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({
    Key? key,
    this.width,
    this.height,
    this.radius,
    this.isShowLeftIcon = true,
    this.leftIconName,
    required this.placeHolder,
    this.placeHolderStyle,
    required this.text,
    this.textStyle,
    this.maxLength = 30,
    this.enable = true,
    this.keyboardType,
    this.rightWidget,
    this.obscureText = false,
    this.inputAction = TextInputAction.done,
    required this.textChangeAction,
    this.submitAction,
  }) : super(key: key);
  final double? width;
  final double? height;
  final double? radius;
  final bool isShowLeftIcon;
  final String? leftIconName;
  final String placeHolder;
  final TextStyle? placeHolderStyle;
  final String text;
  final TextStyle? textStyle;
  final int maxLength;
  final bool enable;
  final TextInputType? keyboardType;
  final Widget? rightWidget;
  final bool obscureText;
  final TextInputAction? inputAction;
  final ValueChanged<String> textChangeAction;
  final ValueChanged<String>? submitAction;
  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  late TextEditingController _textEditingController;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController.fromValue(TextEditingValue(
        // 设置内容
        text: widget.text,
        // 保持光标在最后
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: widget.text.length))));
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _textEditingController = TextEditingController.fromValue(TextEditingValue(
        // 设置内容
        text: widget.text,
        // 保持光标在最后
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: widget.text.length))));
    return Stack(
      children: [
        SizedBox(
          width: widget.width ?? 165.5.w,
          height: widget.height ?? 24.w,
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: widget.width ?? 165.5.w,
          height: widget.height ?? 24.w,
          padding: EdgeInsets.only(left: 12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              widget.radius ?? 12.w,
            ),
            boxShadow: AppConstants.cardShadow,
          ),
          child: Row(children: [
            (widget.isShowLeftIcon && widget.leftIconName != null)
                ? Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: MyImage(
                      widget.leftIconName!,
                      width: 10.w,
                      height: 10.w,
                      fit: BoxFit.contain,
                    ),
                  )
                : const SizedBox(),
            Expanded(
              child: TextField(
                controller: _textEditingController,
                enabled: widget.enable,
                maxLength: widget.maxLength,
                keyboardType: widget.keyboardType,
                textInputAction: widget.inputAction,
                obscureText: widget.obscureText,
                cursorColor: ColorConstants.primaryColor,
                onChanged: (String text) {
                  if (_textEditingController.value.isComposingRangeValid) {
                    return;
                  }
                  widget.textChangeAction(text);
                },
                onSubmitted: ((value) {
                  if (widget.submitAction != null) {
                    widget.submitAction!(value);
                  }
                }),
                style: widget.textStyle ??
                    TextStyle(
                      color: Colors.black,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w600,
                    ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                    top: 0.w,
                    bottom: GetPlatform.isAndroid ? 4.w : 0,
                  ),
                  hintText: widget.placeHolder,
                  hintStyle: widget.placeHolderStyle ??
                      TextStyle(
                        color: MyColor("#888888"),
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w400,
                      ),
                  counterText: "",
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: widget.rightWidget ?? const SizedBox(),
            ),
          ]),
        ),
      ],
    );
  }
}
