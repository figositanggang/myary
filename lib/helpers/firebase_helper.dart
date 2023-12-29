import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myary/features/diary/models/diary_model.dart';
import 'package:myary/features/diary/home_page.dart';
import 'package:myary/features/diary/page/diary_detail_page.dart';
import 'package:myary/utils/custom_methods.dart';
import 'package:myary/utils/custom_widgets.dart';

class FirebaseHelper {
  static final String databaseUrl =
      "https://myary-a7438-default-rtdb.asia-southeast1.firebasedatabase.app";
  static final _dio = Dio();

  // ! Get Data Current User
  static Future<Response> getCurrentUser(String currentUserId) {
    return _dio.get("$databaseUrl/users/$currentUserId.json");
  }

  // ! Get All My Diary
  static Future<Response> getAllDiaries(String userId) async {
    return _dio.get("$databaseUrl/diaries.json");
  }

  // ! Post a Diary
  static Future postDiary(
    BuildContext context, {
    required String userId,
    required String title,
    required String isiDiary,
  }) async {
    showLoading(context);

    try {
      Response response = await _dio.post(
        "$databaseUrl/diaries.json",
        data: DiaryModel(
          id: "",
          createdBy: userId,
          title: title,
          isiDiary: isiDiary,
          createdAt: DateTime.now().toString(),
        ).toMap(),
      );

      var data = response.requestOptions.data;

      await _dio.put(
        "$databaseUrl/diaries/${response.data["name"]}.json",
        data: DiaryModel(
          id: response.data["name"],
          createdBy: userId,
          title: title,
          isiDiary: isiDiary,
          createdAt: data["createdAt"],
        ).toMap(),
      );

      Navigator.pushAndRemoveUntil(
          context, MyRoute(HomePage()), (route) => false);
    } catch (e) {
      Navigator.pop(context);

      showSnackBar(context, "Ada Kesalahan: $e");
    }
  }

  // ! Edit a Diary
  static Future editDiary(BuildContext context,
      {required String diaryId,
      required String title,
      required String isiDiary}) async {
    showLoading(context);

    try {
      await _dio.patch(
        "$databaseUrl/diaries/$diaryId.json",
        data: {
          "title": title,
          "isiDiary": isiDiary,
        },
      );

      showSnackBar(context, "Berhasil ubah diary");
      Navigator.pushAndRemoveUntil(
          context, MyRoute(HomePage()), (route) => false);
    } catch (e) {
      Navigator.pop(context);

      showSnackBar(context, "Ada Kesalahan: $e");
    }
  }

  // ? Delete a Diary
  static Future deleteDiary(BuildContext context, String diaryId) async {
    showLoading(context);

    try {
      await _dio.delete("$databaseUrl/diaries/$diaryId.json");

      Navigator.pushAndRemoveUntil(
          context, MyRoute(HomePage()), (route) => false);

      showSnackBar(context, "Berhasil hapus diary");
    } catch (e) {
      Navigator.pop(context);

      showSnackBar(context, "Ada Kesalahan: $e");
    }
  }
}
