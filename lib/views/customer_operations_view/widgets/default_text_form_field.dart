import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class DefaultTextFormField extends StatefulWidget {
  int? maxLength;
  int? maxLines;
  bool isEnabled;
  bool required;
  bool isPassword;
  bool isFilled;
  bool hasBorder;
  bool autoFocus;
  bool readOnly;
  double contentPaddingVertical;
  double contentPaddingHorizontal;
  double borderRadius;
  double borderSideWidth;
  Color enabledBorderRadiusColor;
  String? validationMsg;
  TextInputType textInputType;
  Widget? prefixIcon;
  Widget? suffixIcon;
  int? numberOfChars;
  Function? onPressSuffixIcon;
  Function(String)? onFilledSubmit;
  Function(String)? onChange;
  Function? validation;
  Function? onTap;
  String? labelText;
  String? hintText;
  TextEditingController controller;
  Color? fillColor;
  TextStyle? style;

  DefaultTextFormField({
    Key? key,
    this.isPassword = false,
    this.autoFocus = false,
    this.readOnly = false,
    this.isFilled = false,
    this.hasBorder = true,
    this.required = true,
    this.isEnabled = true,
    this.borderSideWidth = 1.0,
    this.contentPaddingHorizontal = 10.0,
    this.contentPaddingVertical = 10.0,
    this.borderRadius = 10,
    this.enabledBorderRadiusColor = Colors.grey,
    this.maxLength,
    this.maxLines,
    this.labelText,
    this.numberOfChars,
    this.hintText,
    required this.textInputType,
    required this.controller,
    this.onFilledSubmit,
    this.onChange,
    this.onTap,
    this.onPressSuffixIcon,
    this.validation,
    this.suffixIcon,
    this.prefixIcon,
    this.validationMsg,
    this.style,
    this.fillColor,
  }) : super(key: key);

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  late FocusNode myFocusNode;
  bool hidePassword = true;
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    myFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      style: widget.style ?? Theme.of(context).textTheme.bodyText1,
      readOnly: widget.readOnly,
      obscureText: widget.isPassword && hidePassword,
      focusNode: myFocusNode,
      autofocus: widget.autoFocus,
      enabled: widget.isEnabled,
      controller: widget.controller,
      cursorColor: Colors.black,
      inputFormatters: [
        LengthLimitingTextInputFormatter(widget.numberOfChars),
      ],
      keyboardType: widget.textInputType,
      onFieldSubmitted: (value) {
        if (widget.onFilledSubmit != null) {
          widget.onFilledSubmit!(value);
        }
      },
      onChanged: (value) {
        if (widget.onChange != null) {
          widget.onChange!(value);
        }
      },
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      validator: (String? value) {
        if (widget.validation != null) {
          return widget.validation!(value);
        }else {
          return null;
        }
      },
      decoration: InputDecoration(
        prefixIconColor: Colors.black,
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xff2b3396)),),
        contentPadding: EdgeInsets.symmetric(
          vertical: widget.contentPaddingVertical,
          horizontal: widget.contentPaddingHorizontal,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              widget.borderRadius,
            ),
          ),
          borderSide: (!widget.hasBorder)
              ? BorderSide.none
              : BorderSide(
            color: Color(0xff2b3396),
            width: widget.borderSideWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              widget.borderRadius,
            ),
          ),
          borderSide: (!widget.hasBorder)
              ? BorderSide.none
              : BorderSide(
            color: Colors.grey.shade300,
            width: widget.borderSideWidth,
          ),
        ),
        filled: widget.isFilled,
        fillColor: widget.fillColor ?? Colors.grey.shade100,
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontFamily: "Cairo"
        ),
        errorMaxLines: 2,
        labelStyle: TextStyle(
          color: myFocusNode.hasFocus ? Color(0xff2b3396) : Colors.grey,
        ),
        suffixIcon: widget.suffixIcon ?? (widget.isPassword
            ? IconButton(
          onPressed: () {
            setState(() {
              hidePassword = !hidePassword;
            });
          },
          icon: Icon(
            hidePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: myFocusNode.hasFocus
                ?Color(0xff2b3396)
                : Colors.grey,
          ),
        )
            : null),
        prefixIcon: widget.prefixIcon,
      ),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }
}
