import 'package:get/get.dart';

class NewDiaryController extends GetxController {
  RxString _isi = "".obs;

  String get isi => _isi.value;

  void setIsi(String value) {
    _isi.value = value;
  }
}
