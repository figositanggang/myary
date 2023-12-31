import 'package:flutter/material.dart';
import 'package:myary/helpers/firebase_helper.dart';
import 'package:myary/main.dart';
import 'package:myary/features/user/models/user_model.dart';
import 'package:myary/features/auth/auth_state_page.dart';
import 'package:myary/features/auth/signIn_page.dart';
import 'package:myary/utils/custom_methods.dart';
import 'package:myary/utils/custom_widgets.dart';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelper {
  static final _auth = supabase.auth;
  static final _dio = Dio();

  // ! Sign In
  static Future signIn(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      showLoading(context);

      await _auth.signInWithPassword(
        email: email,
        password: password,
      );

      Navigator.pushAndRemoveUntil(
          context, MyRoute(AuthStatePage()), (route) => false);
    } catch (e) {
      showSnackBar(context, "Email atau password salah", isDanger: true);
      Navigator.pop(context);
    }
  }

  // ! Sign Up
  static Future signUp(
    BuildContext context, {
    required String email,
    required String username,
    required String fullName,
    required String password,
  }) async {
    try {
      showLoading(context);

      AuthResponse authResponse = await _auth.signUp(
        email: email,
        password: password,
        data: {
          "username": username,
          "full_name": fullName,
        },
      );

      await _dio.put(
        "${FirebaseHelper.databaseUrl}/users/${authResponse.user!.id}.json",
        data: UserModel(
          userId: authResponse.user!.id,
          username: username,
          email: email,
          fullName: fullName,
          createdAt: DateTime.now().toString(),
        ).toJson(),
      );

      Navigator.pushReplacement(context, MyRoute(SignInPage()));
    } catch (e) {
      Navigator.pop(context);

      print("KESALAHAN: $e");
    }
  }

  // ! Sign Out
  static Future signOut(BuildContext context) async {
    showLoading(context);

    try {
      await _auth.signOut();

      Navigator.pushAndRemoveUntil(
          context, MyRoute(AuthStatePage()), (route) => false);
    } catch (e) {
      Navigator.pop(context);
    }
  }
}
