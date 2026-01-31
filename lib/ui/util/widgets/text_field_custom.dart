import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String label;
  final String hint;
  final bool isRequired;
  final bool? enabled;
  final bool readOnly;
  final TextInputType? keyboardType;
  final int? maxLine;
  final int? maxLength;
  final Widget? iconSuffix;
  final Widget? iconPrefix;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChange;
  final void Function()? onTap;
  final String? Function(String?)? validator;

  const TextFieldCustom({
    super.key,
    required this.controller,
    this.focusNode,
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.maxLine,
    this.maxLength,
    this.isRequired = false,
    this.enabled = true,
    this.readOnly = false,
    this.iconSuffix,
    this.iconPrefix,
    this.onFieldSubmitted,
    this.onChange,
    this.onTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, prov, _) {
        return TextFormField(
          controller: controller,
          onChanged: onChange,
          focusNode: focusNode,
          keyboardType: keyboardType,
          maxLines: maxLine,
          enabled: enabled,
          readOnly: readOnly,
          style: prov.isDarkTheme
              ? TextStyle(color: enabled == true ? Colors.white : Colors.grey, fontSize: 11.sp)
              : TextStyle(color: enabled == true ? Colors.black : Colors.grey, fontSize: 11.sp),
          decoration: InputDecoration(
            counterText: '',
            label: RichText(
              maxLines: 1,
              text: TextSpan(
                text: label,
                style: TextStyle(fontWeight: FontWeight.bold, color: prov.isDarkTheme ? Colors.white : Colors.black),
                children: isRequired
                    ? [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(color: Colors.red, fontSize: 16.sp),
                        ),
                      ]
                    : [],
              ),
            ),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 11.sp),
            filled: true,
            fillColor: prov.isDarkTheme ? Colors.black : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: prov.isDarkTheme ? ConstantColor.colorBlue : Colors.black), // aktif
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: prov.isDarkTheme ? ConstantColor.colorBlue : Colors.black, width: 2), // fokus
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.grey, width: 1), // disable
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            suffixIcon: iconSuffix,
            prefixIcon: iconPrefix,
          ),
          onTap: onTap,
          onFieldSubmitted: onFieldSubmitted,
          maxLength: maxLength,
          validator: isRequired
              ? (value) {
                  if (value!.isEmpty) {
                    return "$label is Empty";
                  }

                  return null;
                }
              : null,
        );
      },
    );
  }
}
