import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myary/firebase_options.dart';
import 'package:myary/features/user/auth/auth_state_page.dart';
import 'package:myary/utils/custom_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Supabase.initialize(
    url: "https://vcfbkiedxcfukgrytugs.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZjZmJraWVkeGNmdWtncnl0dWdzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDM3NjY0NDEsImV4cCI6MjAxOTM0MjQ0MX0.1JuHQX3VVCyq_VG_EkwaRCYIBGqyE54Xd8qdA12p58g",
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Myary',
      theme: lightTheme,
      home: AuthStatePage(),
    );
  }
}
