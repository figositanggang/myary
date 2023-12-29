import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myary/features/diary/get_controllers/diary_detail_controller.dart';
import 'package:myary/features/diary/models/diary_model.dart';
import 'package:myary/utils/custom_methods.dart';
import 'package:myary/utils/custom_widgets.dart';

class DiaryDetailPage extends StatelessWidget {
  final DiaryModel diaryModel;
  final Color bgColor;
  final Color textColor;
  DiaryDetailPage({
    super.key,
    required this.diaryModel,
    required this.bgColor,
    required this.textColor,
  });

  final DiaryDetailController detailController =
      Get.put(DiaryDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: textColor,
        title: Text(diaryModel.title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit),
            tooltip: "Edit diary",
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Obx(
                () => Text(
                  diaryModel.isiDiary,
                  style: TextStyle(
                    fontSize: detailController.fontSize,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showMyModalBottomSheet(
            context,
            [
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).textTheme.bodySmall!.color,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Font Size"),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              double size = detailController.fontSize;
                              if (size < 35) {
                                size += 1;
                                detailController.setFontSize(size);
                              }
                            },
                            icon: Icon(Icons.text_increase_outlined),
                          ),
                          Obx(() => Text(detailController.fontSize.toString())),
                          IconButton(
                            onPressed: () {
                              double size = detailController.fontSize;
                              if (size > 7) {
                                size -= 1;
                                detailController.setFontSize(size);
                              }
                            },
                            icon: Icon(Icons.text_decrease_outlined),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(height: 0),
            ],
          );
        },
        child: Icon(Icons.text_format),
      ),
    );
  }
}
