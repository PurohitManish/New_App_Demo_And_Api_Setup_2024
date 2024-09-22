import 'package:EasyLocker/utils/app_text.dart';
import 'package:EasyLocker/utils/text_size.dart';
import 'package:flutter/material.dart';

class CommonButtonnWidget extends StatelessWidget {
  final Function() onTap;
  final Color borderColors;
  final Color textColors;
  final Color? backgroundColors;
  final String text;
  const CommonButtonnWidget(
      {super.key,
      required this.onTap,
      required this.borderColors,
      required this.textColors,
      required this.text,
      this.backgroundColors});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(60),
              vertical: getProportionateScreenWidth(12)),
          decoration: BoxDecoration(
              color: backgroundColors,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: borderColors)),
          child: PrimaryText(
              text: text,
              fontWeight: FontWeight.w500,
              size: 14,
              color: textColors)),
    );
  }
}
