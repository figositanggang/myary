import 'package:flutter/material.dart';
import 'package:myary/main.dart';
import 'package:myary/pages/auth_state_page.dart';
import 'package:myary/utils/custom_methods.dart';
import 'package:myary/utils/custom_widgets.dart';

class SupabaseHelper {
  static final _auth = supabase.auth;

  // ! Sign Up
  static Future signUp(
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
      Navigator.pop(context);
    }
  }
}
