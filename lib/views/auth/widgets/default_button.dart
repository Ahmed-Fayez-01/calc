import 'package:flutter/material.dart';

import '../../../utils/custom_style.dart';



class DefaultButton extends StatelessWidget {
  void Function()? onPress;
  String text;
  Widget? icon;
  double? borderRadius;
  double? height;
  double? fontSize;
  String? fontFamily;
  Color? backgroundColor;
  Color? textColor;
  bool hasBorder;

  DefaultButton({
    Key? key,
    required this.onPress,
    required this.text,
    this.icon,
    this.borderRadius,
    this.height,
    this.fontFamily,
    this.fontSize,
    this.backgroundColor,
    this.textColor,
    this.hasBorder = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.red,
          padding: EdgeInsets.symmetric(vertical: height??15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 40,),
          )),
      onPressed: onPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            SizedBox(
              width: 5,
            ),
            icon!,
            SizedBox(
              width: 3,
            ),
          ],
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: CustomStyle.textStyle
                  .copyWith(color: textColor ?? Colors.white,fontWeight: FontWeight.bold,fontSize: fontSize??14,fontFamily: fontFamily),
            ),
          ),
        ],
      ),
    );
  }
}
