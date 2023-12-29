import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myary/features/user/models/user_model.dart';
import 'package:myary/helpers/supabase_helper.dart';
import 'package:myary/utils/custom_widgets.dart';

class UserDetailPage extends StatelessWidget {
  final UserModel userModel;
  final String avatarUrl;
  const UserDetailPage(
      {super.key, required this.userModel, required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("EEE, d M y");

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height:
                MediaQuery.sizeOf(context).height - kBottomNavigationBarHeight,
            child: Column(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    SizedBox(height: 20),

                    // @ Avatar
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(avatarUrl),
                        radius: 100,
                      ),
                    ),
                    SizedBox(height: 20),

                    // @ User Name
                    Text(
                      userModel.fullName,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 5),

                    // @ User Username
                    Text(userModel.username),
                    SizedBox(height: 5),

                    // @ User Email
                    Text(userModel.email),
                    SizedBox(height: 5),

                    // @ User Email
                    Text(
                        "Bergabung pada ${format.format(DateTime.parse(userModel.createdAt))}"),
                    SizedBox(height: 5),
                  ],
                )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width - 100,
                    child: MyButton(
                      onPressed: () {
                        SupabaseHelper.signOut(context);
                      },
                      backgroundColor: Colors.red,
                      child: Text("Logout"),
                    ),
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
