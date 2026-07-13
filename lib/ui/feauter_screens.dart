import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:zabet_app/core/app_colors.dart';

// 1. شاشة التمارين
class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Zabet Workouts')),
      body: const Center(child: Text('صفحة التمارين والجدول قريباً', style: TextStyle(color: Colors.white, fontSize: 20))),
    );
  }
}

// 2. شاشة التايمر (العداد الخاص بيك)
class TimerScreen extends StatelessWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Zabet Timer')),
      body: const Center(child: Text('شاشة عداد الراحة بين المجموعات', style: TextStyle(color: Colors.white, fontSize: 20))),
    );
  }
}

// 3. شاشة الدايت والتغذية
class DietScreen extends StatelessWidget {
  const DietScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Zabet Diet')),
      body: const Center(child: Text('صفحة حساب السعرات والوجبات', style: TextStyle(color: Colors.white, fontSize: 20))),
    );
  }
}

// 4. شاشة الاختبارات البدنية
class TestsScreen extends StatelessWidget {
  const TestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Zabet Tests')),
      body: const Center(child: Text('متابعة أرقام الضغط، العقلة، والجري', style: TextStyle(color: Colors.white, fontSize: 20))),
    );
  }
}

// 5. شاشة تأهيل الكليات العسكرية
class AcademyPrepScreen extends StatelessWidget {
  const AcademyPrepScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Academy Prep')),
      body: const Center(child: Text('خطة التأهيل البدني والنفسي للكليات', style: TextStyle(color: Colors.white, fontSize: 20))),
    );
  }
}