import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myary/features/user/get_controllers/user_controller.dart';
import 'package:myary/helpers/firebase_helper.dart';
import 'package:myary/main.dart';
import 'package:myary/features/diary/models/diary_model.dart';
import 'package:myary/features/user/models/user_model.dart';
import 'package:myary/features/diary/page/new_diary_page.dart';
import 'package:myary/utils/custom_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserController userController;

  late Future<dio.Response> getCurrentUser;
  late Future<dio.Response> getAllDiaries;

  final _currentUser = supabase.auth.currentUser!;

  @override
  void initState() {
    super.initState();

    userController = Get.put(UserController());

    getCurrentUser = FirebaseHelper.getCurrentUser(_currentUser.id);
    getAllDiaries = FirebaseHelper.getAllDiaries(_currentUser.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCurrentUser,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return FullScreenLoading();
        }

        userController
            .setCurrentUser(UserModel.fromSnapshot(snapshot.data!.data!));
        return Scaffold(
          appBar: AppBar(
            title: Text(
                "Halo ${userController.currentUser.fullName.split(" ")[0]}"),
            actions: [
              SizedBox(width: 10),
            ],
          ),
          body: FutureBuilder(
            future: getAllDiaries,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!snapshot.hasData) {
                return Center(
                  child: Text("Belum ada diary"),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text("Ada kesalahan"),
                );
              }

              final data = snapshot.data!.data as Map<String, dynamic>;

              // var aw = data.map((key, value) {
              //   DiaryModel diaryModel = DiaryModel.fromSnapshot(value);

              //   return MapEntry(key, value).value;
              // });

              // var values = data.values.toList();

              // print(aw);

              return RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(Duration(milliseconds: 500));

                  setState(() {
                    getCurrentUser =
                        FirebaseHelper.getCurrentUser(_currentUser.id);
                    getAllDiaries =
                        FirebaseHelper.getAllDiaries(_currentUser.id);
                  });
                },
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final id = data.keys.elementAt(index);
                    DiaryModel diaryModel =
                        DiaryModel.fromSnapshot(data.values.elementAt(index));

                    return MyaryCard(
                      diaryId: id,
                      diaryModel: diaryModel,
                    );
                  },
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.edit),
            tooltip: "Tambah diary",
            onPressed: () {
              Navigator.push(
                  context,
                  MyRoute(NewDiaryPage(
                    currentUser: userController.currentUser,
                  )));
            },
          ),
        );
      },
    );
  }
}
