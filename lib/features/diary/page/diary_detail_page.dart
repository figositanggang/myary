import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:myary/features/diary/get_controllers/diary_detail_controller.dart';
import 'package:myary/features/diary/models/diary_model.dart';
import 'package:myary/features/diary/page/edit_diary_page.dart';
import 'package:myary/features/user/get_controllers/user_controller.dart';
import 'package:myary/helpers/firebase_helper.dart';
import 'package:myary/utils/custom_methods.dart';
import 'package:myary/utils/custom_widgets.dart';

class DiaryDetailPage extends StatefulWidget {
  final String diaryId;
  final DiaryModel diaryModel;
  final Color bgColor;
  final Color textColor;
  DiaryDetailPage({
    super.key,
    required this.diaryModel,
    required this.bgColor,
    required this.textColor,
    required this.diaryId,
  });

  @override
  State<DiaryDetailPage> createState() => _DiaryDetailPageState();
}

class _DiaryDetailPageState extends State<DiaryDetailPage> {
  final DiaryDetailController detailController =
      Get.put(DiaryDetailController());
  final UserController userController = Get.put(UserController());

  late FlutterTts flutterTts;
  List<Map> _voices = [];
  Map? _currentVoice;

  @override
  void initState() {
    super.initState();

    flutterTts = FlutterTts();

    initTTS();
  }

  @override
  void dispose() {
    try {
      flutterTts.stop();
    } catch (e) {}
    super.dispose();
  }

  void initTTS() {
    flutterTts.getVoices.then((data) {
      try {
        List<Map> voices = List<Map>.from(data);
        setState(() {
          _voices =
              voices.where((voice) => voice["name"].contains("id")).toList();
          _currentVoice = _voices[2];
          setVoice(_currentVoice!);
        });
      } catch (e) {
        print(e);
      }
    });
  }

  void setVoice(Map voice) {
    flutterTts.setVoice({"name": voice["name"], "locale": voice["locale"]});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.bgColor,

      // @ App Bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: widget.textColor,
        title: Text(widget.diaryModel.title),
        actions: [
          // @ Edit Diary Button
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MyRoute(EditDiaryPage(
                  diaryId: widget.diaryId,
                  diaryModel: widget.diaryModel,
                )),
              );
            },
            icon: Icon(Icons.edit),
            tooltip: "Edit diary",
          ),

          // @ Delete Diary Button
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Hapus Diary?"),
                  content: SizedBox(height: 0),
                  actions: [
                    // @ On Yes
                    MyButton(
                      onPressed: () {
                        FirebaseHelper.deleteDiary(context, widget.diaryId,
                            userController.currentUser.userId);
                      },
                      child: Text("Ya"),
                    ),
                    MyButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Batal"),
                      isPrimary: false,
                    ),
                  ],
                ),
              );
            },
            color: Colors.red,
            icon: Icon(Icons.delete),
            tooltip: "Edit diary",
          ),

          SizedBox(width: 10),
        ],
      ),

      // @ Body
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Obx(
                () => Text(
                  widget.diaryModel.isiDiary,
                  style: TextStyle(
                    fontSize: detailController.fontSize,
                    color: widget.textColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // @ Edit Text Button
          ElevatedButton(
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
                              Obx(() => Text(detailController.fontSize
                                  .toInt()
                                  .toString())),
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

          SizedBox(width: 10),

          // @ Speech Button
          ElevatedButton(
            onPressed: () {
              speak(widget.diaryModel.isiDiary);
            },
            child: Icon(Icons.spatial_audio_off_rounded),
          ),
        ],
      ),
    );
  }

  Future<void> speak(String text) async {
    try {
      // print(_currentVoice);
      flutterTts.speak(text);
    } catch (e) {
      debugPrint("ERRRRRROOOOOR: $e");
    }
  }
}
