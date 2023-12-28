import 'package:flutter/material.dart';
import 'package:myary/utils/custom_widgets.dart';

void showLoading(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => FullScreenLoading(),
  );
}
