// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// @ TextFormField
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  bool obscureText;
  Function(String)? onChanged;
  AutovalidateMode autovalidateMode;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  Iterable<String>? autofillHints;
  List<TextInputFormatter>? inputFormatters;
  String? Function(String? value)? validator;
  InputBorder? border;
  Widget? suffixIcon;
  int? maxLines;

  MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.onChanged,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.autofillHints,
    this.inputFormatters,
    this.validator,
    this.border,
    this.suffixIcon,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: obscureText ? 1 : maxLines ?? null,
      onChanged: onChanged,
      autovalidateMode: autovalidateMode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      autofillHints: autofillHints,
      inputFormatters: inputFormatters,
      validator: validator ??
          (value) {
            if (value!.isEmpty) {
              return "Masih kosong...";
            }

            return null;
          },
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        hintText: hintText,
        border: border ??
            OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(.25)),
              borderRadius: BorderRadius.circular(30),
            ),
        focusedBorder: border ??
            OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2),
              borderRadius: BorderRadius.circular(30),
            ),
        enabledBorder: border ??
            OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(.25)),
              borderRadius: BorderRadius.circular(30),
            ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}

// @ Button
class MyButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  bool isPrimary;
  Color? backgroundColor;

  MyButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isPrimary = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        backgroundColor: isPrimary
            ? backgroundColor ?? Theme.of(context).colorScheme.primary
            : Theme.of(context).buttonTheme.colorScheme!.background,
        foregroundColor: isPrimary ? Colors.white : Colors.black,
        shape: !isPrimary
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: Colors.black.withOpacity(.25)),
              )
            : null,
      ),
    );
  }
}

// @ Full Screen Loading
Material FullScreenLoading() {
  return Material(
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

// @ My Route
PageRouteBuilder MyRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return page;
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

// @ Size Text
Text MyText(
  String text, {
  double? fontSize,
  FontWeight? fontWeight,
  double? letterSpacing,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
    ),
  );
}

// @ MySnackBar
SnackBar MySnackBar(String content, {bool isDanger = false}) {
  return SnackBar(
    content: Text(content),
    behavior: SnackBarBehavior.floating,
    backgroundColor: isDanger ? Colors.red : Colors.black,
    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
  );
}
