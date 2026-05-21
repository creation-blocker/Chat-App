import 'package:chat_tutorial/controllers/auth_controller.dart';
import 'package:chat_tutorial/firebase_options.dart';
import 'package:chat_tutorial/routes/app_pages.dart';
import 'package:chat_tutorial/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController(), permanent: true); 
        // 'permanent: true' keeps the AuthController alive even when switching screens
      }),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}