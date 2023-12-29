import 'package:flutter/material.dart';
import 'package:myary/main.dart';
import 'package:myary/features/diary/home_page.dart';
import 'package:myary/features/user/auth/signIn_page.dart';

class AuthStatePage extends StatelessWidget {
  const AuthStatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.session != null) {
            return HomePage();
          }
        }

        return SignInPage();
      },
    );
  }
}
