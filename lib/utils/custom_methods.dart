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

// ! Menentukan sebuah warna terang atau gelap
Color darkOrlight(Color color) {
  HSLColor hslColor = HSLColor.fromColor(color);

  if (hslColor.lightness > .5) {
    "light";

    return Colors.black;
  }

  return Colors.white;
}

Future<void> showMyModalBottomSheet(
  BuildContext context,
  List<Widget> children,
) async {
  showModalBottomSheet(
    barrierColor: Colors.transparent,
    context: context,
    showDragHandle: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    useSafeArea: true,
    builder: (context) {
      return Container(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: children,
        ),
      );
    },
  );
}
