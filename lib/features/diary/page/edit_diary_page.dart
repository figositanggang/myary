import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:myary/features/diary/get_controllers/new_diary_controller.dart';
import 'package:myary/features/diary/models/diary_model.dart';
import 'package:myary/features/user/get_controllers/user_controller.dart';
import 'package:myary/helpers/firebase_helper.dart';
import 'package:myary/utils/custom_widgets.dart';

var regex = RegExp(r"[\w-]+");

class EditDiaryPage extends StatefulWidget {
  final String diaryId;
  final DiaryModel diaryModel;
  const EditDiaryPage({
    super.key,
    required this.diaryId,
    required this.diaryModel,
  });

  @override
  State<EditDiaryPage> createState() => _EditDiaryPageState();
}

class _EditDiaryPageState extends State<EditDiaryPage> {
  late TextEditingController title;
  late TextEditingController isiDiary;

  final NewDiaryController newDiaryController = Get.put(NewDiaryController());
  final UserController userController = Get.put(UserController());
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    title = TextEditingController(text: widget.diaryModel.title);
    isiDiary = TextEditingController(text: widget.diaryModel.isiDiary);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Diary"),
        actions: [
          // @ Post Button
          MyButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                FirebaseHelper.editDiary(
                  context,
                  diaryId: widget.diaryId,
                  title: title.text.trim(),
                  isiDiary: isiDiary.text.trim(),
                );
              }
            },
            child: Text("Edit"),
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
                  hintText: "Judul Diary",
                  controller: title,
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
                    hintText: "Diary...",
                    controller: isiDiary,
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
