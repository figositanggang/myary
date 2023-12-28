import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myary/get_controllers/user_controller.dart';
import 'package:myary/helpers/firebase_helper.dart';
import 'package:myary/main.dart';
import 'package:myary/models/user_model.dart';
import 'package:myary/pages/new_diary_page.dart';
import 'package:myary/utils/custom_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserController userController;
  late UserController userFinder;
  late Future<dio.Response> getCurrentUser;

  final _currentUser = supabase.auth.currentUser!;

  @override
  void initState() {
    super.initState();

    userController = Get.put(UserController());
    userFinder = Get.find<UserController>();
    getCurrentUser = FirebaseHelper.getCurrentUser(_currentUser.id);
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
            title:
                Text("Halo ${userFinder.currentUser.fullName.split(" ")[0]}"),
            actions: [
              SizedBox(width: 10),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.edit),
            tooltip: "Tambah diary",
            onPressed: () {
              Navigator.push(
                  context,
                  MyRoute(NewDiaryPage(
                    currentUser: userFinder.currentUser,
                  )));
            },
          ),
        );
      },
    );
  }
}
