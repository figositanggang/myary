import 'package:get/get.dart';

class DiaryDetailController extends GetxController {
  RxDouble _fontSize = 18.0.obs;

  double get fontSize => _fontSize.value;

  void setFontSize(double value) {
    _fontSize.value = value;
  }
}
