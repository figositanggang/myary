import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myary/models/diary_model.dart';
import 'package:myary/utils/custom_methods.dart';

class FirebaseHelper {
  static final String databaseUrl =
      "https://myary-a7438-default-rtdb.asia-southeast1.firebasedatabase.app/";
  static final _dio = Dio();

  // ! Get Data Current User
  static Future<Response> getCurrentUser(String currentUserId) {
    return _dio.get("$databaseUrl/users/$currentUserId.json");
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

      await _dio.patch(
        "$databaseUrl/diaries/${response.data["name"]}.json",
        data: DiaryModel(
          id: response.data["name"],
          createdBy: userId,
          title: title,
          isiDiary: isiDiary,
          createdAt: data["createdAt"],
        ).toMap(),
      );

      print("DONEEEE");

      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);

      showSnackBar(context, "Ada Kesalahan: $e");
    }
  }
}
