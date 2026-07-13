import 'package:flutter/material.dart';

// ==========================================
// 1. Data Model (نموذج بيانات الاختبارات)
// ==========================================
class TestItem {
  final String nameAr;
  final String nameEn;
  final int academyTarget; // الرقم المطلوب للدرجة النهائية
  final String unit;       // التكرار أو الدقائق
  final IconData icon;
  final Color color;
  int currentScore;

  TestItem({
    required this.nameAr,
    required this.nameEn,
    required this.academyTarget,
    required this.unit,
    required this.icon,
    required this.color,
    this.currentScore = 0,
  });

  // حساب النسبة المئوية للجاهزية البدنية في هذا الاختبار
  double get progressPercentage {
    if (nameEn == "1500m Running") {
      // في الجري كل ما الوقت قل كان أفضل (المستهدف 6 دقائق مثلاً)
      if (currentScore == 0) return 0.0;
      // حساب تقديري للركض
      double ratio = academyTarget / currentScore;
      return ratio > 1.0 ? 1.0 : ratio;
    }
    double ratio = currentScore / academyTarget;
    return ratio > 1.0 ? 1.0 : ratio;
  }

  // تحديد التقييم البدني بناءً على الأداء
  String get evaluation {
    double progress = progressPercentage;
    if (progress >= 0.9) return "ممتاز (جاهزية كاملة) 💪";
    if (progress >= 0.75) return "جيد جداً (قريب من الهدف) 👍";
    if (progress >= 0.5) return "مقبول (تحتاج جهد إضافي) ⚡";
    return "تحتاج إلى تطوير مكثف 🔴";
  }
}

// ==========================================
// 2. واجهة الاختبارات التفاعلية
// ==========================================
class ZabetTestsScreen extends StatefulWidget {
  const ZabetTestsScreen({super.key});

  @override
  State<ZabetTestsScreen> createState() => _ZabetTestsScreenState();
}

class _ZabetTestsScreenState extends State<ZabetTestsScreen> {
  // القائمة الأساسية لاختبارات الكليات العسكرية والشرطة
  final List<TestItem> militaryTests = [
    TestItem(
      nameAr: "اختبار العقلة",
      nameEn: "Pull-ups Test",
      academyTarget: 10,
      unit: "تكرار",
      icon: Icons.fitness_center,
      color: Colors.blue,
      currentScore: 5,
    ),
    TestItem(
      nameAr: "اختبار الضغط",
      nameEn: "Push-ups Test",
      academyTarget: 40,
      unit: "تكرار",
      icon: Icons.accessibility_new,
      color: Colors.orange,
      currentScore: 20,
    ),
    TestItem(
      nameAr: "اختبار البطن",
      nameEn: "Sit-ups Test",
      academyTarget: 40,
      unit: "تكرار",
      icon: Icons.gavel,
      color: Colors.purple,
      currentScore: 25,
    ),
    TestItem(
      nameAr: "اختبار الجري (1500 متر)",
      nameEn: "1500m Running",
      academyTarget: 360, // 6 دقائق بالثواني
      unit: "ثانية",
      icon: Icons.directions_run,
      color: Colors.green,
      currentScore: 420, // 7 دقائق بالثواني كمثال بدائي
    ),
  ];

  // حساب الجاهزية العامة الكلية لجميع الاختبارات
  double get totalAcademyReadiness {
    double total = 0;
    for (var test in militaryTests) {
      total += test.progressPercentage;
    }
    return total / militaryTests.length;
  }

  @override
  Widget build(BuildContext context) {
    double overallProgress = totalAcademyReadiness;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Zabet Tests", style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- لوحة الجاهزية العامة (Header Card) ---
            Card(
              margin: const EdgeInsets.all(15),
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: Colors.blueGrey[900],
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "معدل الجاهزية البدنية للأكاديمية",
                      style: TextStyle(fontFamily: 'Cairo', color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    CircularProgressIndicator(
                      value: overallProgress,
                      strokeWidth: 10,
                      backgroundColor: Colors.white24,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        overallProgress >= 0.8 ? Colors.green : (overallProgress >= 0.5 ? Colors.orange : Colors.red),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "${(overallProgress * 100).toStringAsFixed(0)}%",
                      style: const TextStyle(fontFamily: 'Cairo', color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      overallProgress >= 0.8 ? "أنت جاهز تماماً للاختبار البدني!" : "استمر في التطوير، النجم يقترب!",
                      style: const TextStyle(fontFamily: 'Cairo', color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "تتبع وقم بتحديث أرقامك اليومية:",
                  style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),

            // --- قائمة الاختبارات التفاعلية ---
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: militaryTests.length,
              itemBuilder: (context, index) {
                final test = militaryTests[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // العنوان والأيقونة
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: test.color.withOpacity(0.1),
                              child: Icon(test.icon, color: test.color),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(test.nameAr, style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 16)),
                                Text(test.nameEn, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                              ],
                            ),
                            const Spacer(),
                            // زر التحكم في التقدم (إنقاص / زيادة)
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                                  onPressed: () {
                                    if (test.currentScore > 0) {
                                      setState(() {
                                        test.currentScore -= (test.nameEn == "1500m Running" ? 5 : 1);
                                      });
                                    }
                                  },
                                ),
                                Text(
                                  "${test.currentScore}",
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                                  onPressed: () {
                                    setState(() {
                                      test.currentScore += (test.nameEn == "1500m Running" ? 5 : 1);
                                    });
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        // المستهدف والتقييم الحالي
                        Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "مستهدف الكلية: ${test.academyTarget} ${test.unit}",
                              style: const TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.blueGrey),
                            ),
                            Text(
                              test.evaluation,
                              style: TextStyle(fontFamily: 'Cairo', fontSize: 12, fontWeight: FontWeight.bold, color: test.color),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // شريط تقدم مرئي لكل تمرين بشكل منفصل
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: test.progressPercentage,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(test.color),
                            minHeight: 6,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}