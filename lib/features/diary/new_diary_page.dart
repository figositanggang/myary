import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:myary/features/diary/get_controllers/new_diary_controller.dart';
import 'package:myary/features/user/get_controllers/user_controller.dart';
import 'package:myary/helpers/firebase_helper.dart';
import 'package:myary/features/user/models/user_model.dart';
import 'package:myary/utils/custom_methods.dart';
import 'package:myary/utils/custom_widgets.dart';

var regex = RegExp(r"[\w-]+");

class NewDiaryPage extends StatefulWidget {
  final UserModel currentUser;
  const NewDiaryPage({super.key, required this.currentUser});

  @override
  State<NewDiaryPage> createState() => _NewDiaryPageState();
}

class _NewDiaryPageState extends State<NewDiaryPage> {
  late TextEditingController title;
  late TextEditingController isi;

  final NewDiaryController newDiaryController = Get.put(NewDiaryController());
  final UserController userController = Get.put(UserController());
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    title = TextEditingController();
    isi = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Diary"),
        actions: [
          // @ Post Button
          MyButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                FirebaseHelper.postDiary(
                  context,
                  userId: userController.currentUser.userId,
                  title: title.text.trim(),
                  isiDiary: isi.text.trim(),
                );
              }
            },
            child: Text("Post"),
            padding: EdgeInsets.all(10),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // @ Title Diary
                MyTextField(
                  controller: title,
                  hintText: "Judul Diary",
                  keyboardType: TextInputType.name,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide:
                        BorderSide(color: Colors.black.withOpacity(.25)),
                  ),
                ),
                SizedBox(height: 20),

                // @ Isi Diary
                Align(
                  alignment: Alignment.centerRight,
                  child: Obx(() => Text(
                      "${regex.allMatches(newDiaryController.isi).length}")),
                ),
                Container(
                  constraints: BoxConstraints(minHeight: 200),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(.25)),
                  ),
                  child: MyTextField(
                    controller: isi,
                    hintText: "Diary...",
                    border: InputBorder.none,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    onChanged: (value) {
                      newDiaryController.setIsi(value);
                    },
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
