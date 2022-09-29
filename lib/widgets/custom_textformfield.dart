import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:ogule/values/colors.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    Key? key,
    this.hint,
    this.textInputType = TextInputType.emailAddress,
    this.onTextChange,
    this.obscureText = false,
    this.fieldType = 2,
    this.icon,
    this.hasIcon = true,
    this.isRounded = true,
    this.label,
    this.validator,
    this.controller,
    this.onEditComplete,
    // this.enabled, //Not clickable and not editable
    // this.readOnly=false  //Clickable and not editable
  }) : super(key: key);
  final String? hint;
  final TextInputType textInputType;
  final Function(String)? onTextChange;
  bool obscureText;
  final int fieldType;
  final validator;
  final IconData? icon;
  final bool hasIcon;
  final String? label;
  final bool isRounded;
  final TextEditingController? controller;
  final Function(String)? onEditComplete;

  // final bool? enabled;
  // final bool readOnly;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: () {
        if (widget.controller != null) {
          //creating issue when field is empty
          widget.onEditComplete!(widget.controller!.text);
        }
      },
      // enabled: widget.enabled, //Not clickable and not editable
      // readOnly: widget.readOnly, //Clickable and not editable
      obscuringCharacter: "*",
      controller: widget.controller,
      decoration: InputDecoration(
          suffixIcon: widget.fieldType == 1
              ? GestureDetector(
                  child: Icon(
                    // Based on passwordVisible state choose the icon
                    widget.obscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: widget.obscureText
                        ? Colors.grey
                        : Theme.of(context).primaryColorDark,
                  ),
                  onTap: () {
                    setState(() {
                      widget.obscureText = !widget.obscureText;
                    });
                  },
                )
              : null,
          prefixIcon: widget.hasIcon
              ? Icon(
                  widget.icon,
                  color: AppColors.blueColor,
                  size: 25,
                )
              : null,
          contentPadding: const EdgeInsets.only(left: 15),
          border: _inputBorder(widget.isRounded),
          disabledBorder: _inputBorder(widget.isRounded),
          enabledBorder:
              widget.isRounded ? _inputBorder(widget.isRounded) : null,
          errorBorder: _inputBorder(widget.isRounded),
          focusedBorder: _inputBorder(widget.isRounded),
          focusedErrorBorder: _inputBorder(widget.isRounded),
          filled: true,
          labelText: widget.label,
          hintText: widget.hint,hintStyle: TextStyle(color: AppColors.blueColor),
          fillColor: Colors.white),
      keyboardType: widget.textInputType,
      obscureText: widget.obscureText,
      onFieldSubmitted: (text) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      // validator: (PassCurrentValue){
      //   RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
      //   var passNonNullValue=PassCurrentValue??"";
      //   if(passNonNullValue.isEmpty){
      //     return ("Password is required");
      //   }
      //   else if(passNonNullValue.length<=6){
      //     return ("Password contain at least min 6 or max 8 characters");
      //   }
      //   else if(!regex.hasMatch(passNonNullValue)){
      //     return ("Password should contain upper,lower,digit and Special character ");
      //   }
      //   return null;
      // },


      validator: (val,) {
        switch (widget.fieldType) {
          case 2:

            RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
            var passNonNullValue=val??"";
            if(passNonNullValue.isEmpty){
              return ("Please enter password");
            }
            else if(passNonNullValue.length<6){
              return ("Password contain at least min 6 or max 8 characters");
            }
            else if(!regex.hasMatch(passNonNullValue)){
              return ("Password should contain upper,lower,digit and Special character ");
            }
            return null;
          case 0:  {
              if (val!.isEmpty) {
                return "Please enter email";
              } else if (!GetUtils.isEmail(val)) {
                return "Please enter valid email";
              } else {
                return null;
              }
            }


          default:
            {
              if (val!.isEmpty) {
                return "Please enter valid data";
              } else {
                return null;
              }
            }
        }
      },
      onChanged: (text) {
        if (widget.onTextChange != null) {
          widget.onTextChange!(text);
        }
      },
      onSaved: (val) {},
    );
  }

  InputBorder _inputBorder(isRounded) {
    return OutlineInputBorder(
      borderSide:
          BorderSide(width: isRounded ? 0.5 : 1.2, color: AppColors.blueColor),
      borderRadius: BorderRadius.circular(isRounded ? 30.0 : 30.0),
    );
  }
}
class PasswordTextFormField extends StatefulWidget {
  PasswordTextFormField({
    Key? key,
    this.hint,
    this.textInputType = TextInputType.emailAddress,
    this.onTextChange,
    this.obscureText = false,
    this.fieldType = 2,
    this.icon,
    this.hasIcon = true,
    this.isRounded = true,
    this.label,
    this.controller,
    this.onEditComplete,
    // this.enabled, //Not clickable and not editable
    // this.readOnly=false  //Clickable and not editable
  }) : super(key: key);
  final String? hint;
  final TextInputType textInputType;
  final Function(String)? onTextChange;
  bool obscureText;
  final int fieldType;
  final IconData? icon;
  final bool hasIcon;
  final String? label;
  final bool isRounded;
  final TextEditingController? controller;
  final Function(String)? onEditComplete;

  // final bool? enabled;
  // final bool readOnly;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: () {
        if (widget.controller != null) {
          //creating issue when field is empty
          widget.onEditComplete!(widget.controller!.text);
        }
      },
      // enabled: widget.enabled, //Not clickable and not editable
      // readOnly: widget.readOnly, //Clickable and not editable
      obscuringCharacter: "*",
      controller: widget.controller,
      decoration: InputDecoration(
          suffixIcon: widget.fieldType == 1
              ? GestureDetector(
            child: Icon(
              // Based on passwordVisible state choose the icon
              widget.obscureText
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: widget.obscureText
                  ? Colors.grey
                  : Theme.of(context).primaryColorDark,
            ),
            onTap: () {
              setState(() {
                widget.obscureText = !widget.obscureText;
              });
            },
          )
              : null,
          prefixIcon: widget.hasIcon
              ? Icon(
            widget.icon,
            color: AppColors.blueColor,
            size: 25,
          )
              : null,
          contentPadding: const EdgeInsets.only(left: 15),
          border: _inputBorder(widget.isRounded),
          disabledBorder: _inputBorder(widget.isRounded),
          enabledBorder:
          widget.isRounded ? _inputBorder(widget.isRounded) : null,
          errorBorder: _inputBorder(widget.isRounded),
          focusedBorder: _inputBorder(widget.isRounded),
          focusedErrorBorder: _inputBorder(widget.isRounded),
          filled: true,
          labelText: widget.label,
          hintText: widget.hint,
          fillColor: Colors.white),
      keyboardType: widget.textInputType,
      obscureText: widget.obscureText,
      onFieldSubmitted: (text) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      validator: (PassCurrentValue){
        RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
        var passNonNullValue=PassCurrentValue??"";
        if(passNonNullValue.isEmpty){
          return ("Please enter Password");
        }
        else if(passNonNullValue.length<=6){
          return ("Password contain at least min 6 or max 8 characters");
        }
        else if(!regex.hasMatch(passNonNullValue)){
          return ("Password should contain upper,lower,digit and Special character ");
        }
        return null;
      },
    );

  }

  InputBorder _inputBorder(isRounded) {
    return OutlineInputBorder(
      borderSide:
      BorderSide(width: isRounded ? 0.5 : 1.2, color: AppColors.blueColor),
      borderRadius: BorderRadius.circular(isRounded ? 30.0 : 30.0),
    );
  }
}
