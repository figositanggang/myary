import 'package:get/get.dart';
import 'package:myary/models/user_model.dart';

class UserController extends GetxController {
  var _currentUser = UserModel(
    userId: "",
    username: "",
    email: "",
    fullName: "",
    createdAt: "",
  ).obs;

  UserModel get currentUser => _currentUser.value;

  void setCurrentUser(UserModel value) {
    _currentUser.value = value;
  }
}
