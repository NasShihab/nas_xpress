import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nas_xpress/core/theme/text_theme.dart';

class FormFieldWidget extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;
  final Function(String) onChanged;
  final bool readOnly;
  final Widget prefixIcon;
  final TextInputFormatter? textInputFormatter;

  const FormFieldWidget({
    super.key,
    required this.labelText,
    this.obscureText = false,
    required this.controller,
    required this.onChanged,
    this.readOnly = false,
    this.prefixIcon = const Icon(Icons.account_box_rounded),
    this.textInputFormatter,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: TextFormField(
        inputFormatters:
            textInputFormatter != null ? [textInputFormatter!] : null,
        readOnly: readOnly,
        onChanged: onChanged,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: labelText,
          labelStyle: bodySmall(context),
          hintStyle: bodySmall(context),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2.w,
            ),
            borderRadius: BorderRadius.circular(50.r),
          ),
        ),
        style: bodySmall(context),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String text;
  final Color fillColor;
  final Color textColor;
  final VoidCallback onPressed;
  final double fontSize;
  final double textPadding;

  const RoundedButton({
    super.key,
    required this.text,
    required this.fillColor,
    required this.textColor,
    required this.onPressed,
    this.fontSize = 20,
    this.textPadding = 16,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: fillColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.h),
        child: Text(
          text,
          style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSize.sp),
        ),
      ),
    );
  }
}
