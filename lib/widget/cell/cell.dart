import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Cell extends StatelessWidget {
  final String? suffixIcon;
  final Widget? suffixIconWidget;
  final String label;
  final Widget? content;
  final Function? onTap;
  final bool isLink;
  final bool border;
  final int height;
  const Cell(
      {Key? key,
      this.suffixIcon,
      this.suffixIconWidget,
      required this.label,
      this.height = 120,
      this.content,
      this.isLink = true,
      this.onTap,
      this.border = true})
      : super(key: key);

  Cell copyWith({
    final String? suffixIcon,
    final Widget? suffixIconWidget,
    final Widget? content,
    final Function? onTap,
    final int? height,
  }) {
    return Cell(
      isLink: isLink,
      border: border,
      height: height ?? this.height,
      label: label,
      suffixIcon: suffixIcon ?? this.suffixIcon,
      suffixIconWidget: suffixIconWidget ?? this.suffixIconWidget,
      content: content ?? this.content,
      onTap: onTap ?? this.onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
        color: Colors.white,
        child: InkWell(
          onTap: onTap != null ? () => onTap!() : null,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              suffixIcon != null
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Image.asset(
                        suffixIcon!,
                        width: 31.w,
                      ),
                    )
                  : Container(),
              Offstage(
                offstage: suffixIcon != null || suffixIconWidget == null,
                child: suffixIconWidget,
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height.w,
                        child: Row(children: [
                          Text(
                            label,
                            style: TextStyle(
                                color: const Color(0xff262626), fontSize: 30.w),
                          ),
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Offstage(
                                          offstage: content == null,
                                          child: content,
                                        ),
                                      )),
                                  Offstage(
                                    offstage: !isLink,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.w, right: 30.w),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 30.w,
                                        color: const Color(0xff999999),
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                        ]),
                      ),
                      Offstage(
                        offstage: !border,
                        child: const Divider(
                          height: 1,
                          color: Color(0xffedeff2),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}
