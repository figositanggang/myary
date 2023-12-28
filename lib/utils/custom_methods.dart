import 'package:flutter/material.dart';
import 'package:myary/utils/custom_widgets.dart';

void showLoading(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => FullScreenLoading(),
  );
}

void showSnackBar(
  BuildContext context,
  String content, {
  bool isDanger = false,
}) {
  ScaffoldMessenger.of(context)
      .showSnackBar(MySnackBar(content, isDanger: isDanger));
}
