import 'package:flutter/material.dart';
import 'package:zabet_app/core/app_colors.dart';
import 'package:zabet_app/ui/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ZabetApp()); // تشغيل مباشر وخفيف بدون أي تعقيد
}

class ZabetApp extends StatelessWidget {
  const ZabetApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zabet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const HomeScreen(),
    );
  }
}