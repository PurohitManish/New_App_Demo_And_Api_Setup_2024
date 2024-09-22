import 'package:EasyLocker/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Icon? icon;
  final String hint;
  final Function onvalidate;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    this.controller,
    this.icon,
    required this.hint,
    required this.onvalidate,
    this.keyboardType,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextFormField(
        keyboardType: keyboardType,
        validator: ((value) => onvalidate(value)),
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 15,
          ),
          icon: icon,
          hintText: hint,
        ),
      ),
    );
  }
}

///////////////////////////////////

class CustomTextField2 extends StatelessWidget {
  final TextEditingController? controller;
  final Icon? icon;
  final String hint;
  final Function onvalidate;
  final Function onChange;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  // final double radius;
  // final TextCapitalization textCapitalization;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const CustomTextField2({
    super.key,
    this.controller,
    this.icon,
    required this.hint,
    required this.onvalidate,
    // required this.radius,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.focusNode,
    this.maxLength,
    required this.onChange,
    //required this.textCapitalization
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      focusNode: focusNode,
      maxLength: maxLength,
      //textCapitalization: textCapitalization, //TextCapitalization.words,
      keyboardType: keyboardType,
      validator: ((value) => onvalidate(value)),
      onChanged: ((value) => onChange(value)),
      controller: controller,
      style: GoogleFonts.urbanist(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        prefixIcon: icon,
        hintText: hint,
        hintStyle: GoogleFonts.urbanist(color: Colors.white),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                BorderSide(color: AppColors.buttomsheettextfildeColors)),

        fillColor: AppColors.buttomsheettextfildeColors,
        filled: true,
        // border: InputBorder.none
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                BorderSide(color: AppColors.buttomsheettextfildeColors)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                BorderSide(color: AppColors.buttomsheettextfildeColors)),
      ),
    );
  }
}
