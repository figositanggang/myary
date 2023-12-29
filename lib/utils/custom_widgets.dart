// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myary/features/diary/page/diary_detail_page.dart';
import 'package:myary/features/diary/models/diary_model.dart';
import 'package:myary/utils/custom_methods.dart';
import 'package:intl/intl.dart';

// Stateless Widgets
// @ TextFormField
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  bool obscureText;
  Function(String value)? onChanged;
  AutovalidateMode autovalidateMode;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  Iterable<String>? autofillHints;
  List<TextInputFormatter>? inputFormatters;
  String? Function(String? value)? validator;
  InputBorder? border;
  Widget? suffixIcon;
  int? maxLines;
  String? initialValue;

  MyTextField(
      {super.key,
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
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
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
  EdgeInsetsGeometry? padding;

  MyButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.isPrimary = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
        padding: padding,
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

// @ Myary Card
class MyaryCard extends StatelessWidget {
  final String diaryId;
  final DiaryModel diaryModel;
  MyaryCard({super.key, required this.diaryModel, required this.diaryId});

  int r = Random().nextInt(150);
  int g = Random().nextInt(150);
  int b = Random().nextInt(150);

  @override
  Widget build(BuildContext context) {
    Color color = Color.fromRGBO(r, g, b, 1);
    final Color textColor = darkOrlight(Color.fromRGBO(r, g, b, 1));

    final format = DateFormat("EEEE, d/M/y");
    final date = DateTime.parse(diaryModel.createdAt);
    final createdAt = format.format(DateTime.parse(diaryModel.createdAt));

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: MediaQuery.sizeOf(context).height / 3.5,
      child: Ink(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MyRoute(DiaryDetailPage(
                diaryId: diaryId,
                diaryModel: diaryModel,
                bgColor: color,
                textColor: darkOrlight(color),
              )),
            );
          },
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // @ Title Diary
                Text(
                  diaryModel.title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),

                // @ Isi Diary
                Expanded(
                  child: Text(
                    diaryModel.isiDiary,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                      color: darkOrlight(color),
                      fontSize: 20,
                    ),
                  ),
                ),

                // @ CreatedAt Diary
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    createdAt,
                    style: TextStyle(color: darkOrlight(color).withOpacity(.5)),
                  ),
                ),

                // @ CreatedAt Diary
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "${date.hour}:${date.minute} ${date.timeZoneName}",
                    style: TextStyle(color: darkOrlight(color).withOpacity(.5)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Non Stateless Widgets
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
