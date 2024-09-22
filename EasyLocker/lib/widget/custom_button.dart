import 'package:EasyLocker/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final List<Widget> children;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final EdgeInsets? padding;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.children,
    this.borderRadius,
    this.width,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        padding: padding,
        //   padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(

            // border: Border.all(),
            color: AppColors.icontextColor,
            borderRadius: borderRadius),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children),
      ),
    );
  }
}
