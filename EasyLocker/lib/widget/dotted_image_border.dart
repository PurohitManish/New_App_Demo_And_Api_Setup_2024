import 'dart:io';

import 'package:EasyLocker/utils/app_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Dottedborderimage extends StatelessWidget {
  final Widget child;

  const Dottedborderimage({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: DottedBorder(
      dashPattern: [12, 4],
      color: AppColors.dottedborderColor,
      //  color: AppColors.dottedborder,
      borderType: BorderType.RRect,
      radius: Radius.circular(4),
      padding: EdgeInsets.all(6),
      child: child,
    ));
  }
}
//////////
///
