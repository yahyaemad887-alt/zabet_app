import 'package:flutter/material.dart';

// ==========================================
// 1. Data Models (هيكلية البيانات)
// ==========================================

class Exercise {
  final String nameAr;
  final String nameEn;
  final int sets;
  final String reps;
  final String? note; // لإضافة ملاحظات زي "أوزان انفجارية" أو "Drop Set"
  List<bool> completedSets;

  Exercise({
    required this.nameAr,
    required this.nameEn,
    required this.sets,
    required this.reps,
    this.note,
  }) : completedSets = List.generate(sets, (index) => false); // إنشاء مصفوفة لكل مجموعة
}

class WorkoutDay {
  final String dayNameAr;
  final String dayNameEn;
  final List<Exercise> exercises;

  WorkoutDay({
    required this.dayNameAr,
    required this.dayNameEn,
    required this.exercises,
  });
}

class WorkoutSystem {
  final String systemName;
  final List<WorkoutDay> days;

  WorkoutSystem({
    required this.systemName,
    required this.days,
  });
}

// ==========================================
// 2. Data Repository (بيانات الأنظمة كاملة)
// ==========================================

class WorkoutData {
  static List<WorkoutSystem> getSystems() {
    return [
      // ---------------- النظام الأول: Yahya Split ----------------
      WorkoutSystem(
        systemName: "Yahya Split",
        days: [
          WorkoutDay(
            dayNameAr: "اليوم الأول: باي، تراي، ساعد",
            dayNameEn: "Day 1: Biceps, Triceps, Forearms",
            exercises: [
              Exercise(nameAr: "بايسبس (تجميع)", nameEn: "Biceps Curl", sets: 10, reps: "حتى الفشل العضلي", note: "نزول تكتيكي بالوزن (Drop Set) في نفس المجموعة"),
              Exercise(nameAr: "ترايسبس (تجميع)", nameEn: "Triceps Extension", sets: 10, reps: "حتى الفشل العضلي", note: "نزول تكتيكي بالوزن (Drop Set)"),
              Exercise(nameAr: "ساعد", nameEn: "Forearms", sets: 5, reps: "حتى الفشل العضلي"),
            ],
          ),
          WorkoutDay(
            dayNameAr: "اليوم الثاني: بنش وكتف",
            dayNameEn: "Day 2: Chest & Shoulders",
            exercises: [
              Exercise(nameAr: "بنش عالي", nameEn: "Incline Bench Press", sets: 5, reps: "حتى الفشل العضلي", note: "نزول تكتيكي بالوزن (Drop Set)"),
              Exercise(nameAr: "بنش مستوي", nameEn: "Flat Bench Press", sets: 5, reps: "حتى الفشل العضلي", note: "نزول تكتيكي بالوزن (Drop Set)"),
              Exercise(nameAr: "بنش سفلي", nameEn: "Decline Bench Press", sets: 5, reps: "حتى الفشل العضلي", note: "نزول تكتيكي بالوزن (Drop Set)"),
              Exercise(nameAr: "كتف (تجميع)", nameEn: "Shoulders Press/Raises", sets: 5, reps: "حتى الفشل العضلي", note: "نزول تكتيكي بالوزن (Drop Set)"),
            ],
          ),
          WorkoutDay(
            dayNameAr: "اليوم الثالث: ظهر",
            dayNameEn: "Day 3: Back",
            exercises: [
              Exercise(nameAr: "سحب أمامي واسع", nameEn: "Wide Lat Pulldown", sets: 4, reps: "8-12"),
              Exercise(nameAr: "تجديف بالبار", nameEn: "Barbell Row", sets: 4, reps: "8-12"),
              Exercise(nameAr: "سحب أرضي", nameEn: "Seated Cable Row", sets: 4, reps: "8-12"),
            ],
          ),
          WorkoutDay(
            dayNameAr: "اليوم الرابع: رجل (انفجاري)",
            dayNameEn: "Day 4: Legs",
            exercises: [
              Exercise(nameAr: "سكوات بالبار", nameEn: "Barbell Squat", sets: 5, reps: "8-10", note: "أوزان انفجارية - أداء صحيح بنسبة 120%"),
              Exercise(nameAr: "مكبس رجل", nameEn: "Leg Press", sets: 4, reps: "10-12", note: "أوزان انفجارية"),
              Exercise(nameAr: "رفرفة أمامي", nameEn: "Leg Extension", sets: 4, reps: "12-15"),
            ],
          ),
        ],
      ),

      // ---------------- النظام الثاني: Arnold Split ----------------
      WorkoutSystem(
        systemName: "Arnold Split (5 Days)",
        days: [
          WorkoutDay(
            dayNameAr: "اليوم 1: أرجل",
            dayNameEn: "Day 1: Legs",
            exercises: [
              Exercise(nameAr: "قرفصاء بالبار", nameEn: "Barbell Squat", sets: 4, reps: "16"),
              Exercise(nameAr: "مكبس رجل", nameEn: "Leg Press", sets: 4, reps: "15"),
              Exercise(nameAr: "سمانة على المكبس", nameEn: "Calf Press", sets: 4, reps: "20"),
            ],
          ),
          WorkoutDay(
            dayNameAr: "اليوم 2: صدر",
            dayNameEn: "Day 2: Chest",
            exercises: [
              Exercise(nameAr: "ضغط صدر بار مستوي", nameEn: "Barbell Bench Press", sets: 4, reps: "20"),
              Exercise(nameAr: "ضغط صدر بار عالي", nameEn: "Incline Bench Press", sets: 4, reps: "20"),
              Exercise(nameAr: "تجميع كيبل صدر", nameEn: "Cable Crossover", sets: 4, reps: "16"),
            ],
          ),
          WorkoutDay(
            dayNameAr: "اليوم 3: ظهر",
            dayNameEn: "Day 3: Back",
            exercises: [
              Exercise(nameAr: "رفعة ميتة", nameEn: "Deadlift", sets: 3, reps: "8"),
              Exercise(nameAr: "تجديف بالبار", nameEn: "Barbell Bent Over Row", sets: 3, reps: "12"),
              Exercise(nameAr: "سحب أمامي واسع", nameEn: "Wide Grip Lat Pulldown", sets: 3, reps: "12"),
            ],
          ),
        ],
      ),

      // ---------------- النظام الثالث: Push/Pull/Legs ----------------
      WorkoutSystem(
        systemName: "Push/Pull/Legs (PPL)",
        days: [
          WorkoutDay(
            dayNameAr: "يوم الدفع (بنش، كتف، تراي)",
            dayNameEn: "Push Day",
            exercises: [
              Exercise(nameAr: "ضغط كتف بار", nameEn: "Military Press", sets: 5, reps: "5", note: "راحة 1-2 دقيقة"),
              Exercise(nameAr: "ضغط صدر دامبل", nameEn: "Dumbbell Bench Press", sets: 3, reps: "5"),
              Exercise(nameAr: "غطس تراي", nameEn: "Tricep Dip", sets: 3, reps: "8"),
            ],
          ),
          WorkoutDay(
            dayNameAr: "يوم السحب (ظهر، باي)",
            dayNameEn: "Pull Day",
            exercises: [
              Exercise(nameAr: "عقلة", nameEn: "Pull Up", sets: 5, reps: "5"),
              Exercise(nameAr: "تجديف بالبار", nameEn: "Bent-Over Row", sets: 3, reps: "5"),
              Exercise(nameAr: "مرجحة باي", nameEn: "Barbell Curl", sets: 3, reps: "8"),
            ],
          ),
          WorkoutDay(
            dayNameAr: "يوم الأرجل",
            dayNameEn: "Leg Day",
            exercises: [
              Exercise(nameAr: "سكوات", nameEn: "Barbell Squat", sets: 5, reps: "5"),
              Exercise(nameAr: "رفعة ميتة", nameEn: "Deadlift", sets: 3, reps: "5"),
              Exercise(nameAr: "مكبس", nameEn: "Leg Press", sets: 3, reps: "8"),
            ],
          ),
        ],
      ),

      // يمكنك إضافة باقي الأنظمة (Upper/Lower, Full Body, الخ) بنفس النمط...
    ];
  }
}

// ==========================================
// 3. الشاشة الأولى: قائمة الأنظمة
// ==========================================

class ZabetWorkoutsScreen extends StatelessWidget {
  const ZabetWorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final systems = WorkoutData.getSystems();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Zabet Workouts", style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: systems.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              title: Text(systems[index].systemName, style: const TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.blue),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SystemDaysScreen(system: systems[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ==========================================
// 4. الشاشة الثانية: أيام النظام المحدد
// ==========================================

class SystemDaysScreen extends StatelessWidget {
  final WorkoutSystem system;
  const SystemDaysScreen({super.key, required this.system});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(system.systemName, style: const TextStyle(fontFamily: 'Cairo', fontSize: 18)),
      ),
      body: ListView.builder(
        itemCount: system.days.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(system.days[index].dayNameAr, style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
              subtitle: Text(system.days[index].dayNameEn, style: const TextStyle(color: Colors.grey)),
              trailing: const Icon(Icons.fitness_center),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExercisesScreen(day: system.days[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ==========================================
// 5. الشاشة الثالثة: التمارين التفاعلية (Checkboxes)
// ==========================================

class ExercisesScreen extends StatefulWidget {
  final WorkoutDay day;
  const ExercisesScreen({super.key, required this.day});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.day.dayNameAr, style: const TextStyle(fontFamily: 'Cairo', fontSize: 18)),
      ),
      body: ListView.builder(
        itemCount: widget.day.exercises.length,
        itemBuilder: (context, index) {
          final exercise = widget.day.exercises[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: ExpansionTile(
              title: Text(exercise.nameAr, style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 16)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(exercise.nameEn, style: const TextStyle(color: Colors.grey)),
                  if (exercise.note != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      exercise.note!,
                      style: const TextStyle(fontFamily: 'Cairo', color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ]
                ],
              ),
              children: List.generate(exercise.sets, (setIndex) {
                return CheckboxListTile(
                  activeColor: Colors.green,
                  title: Text(
                    "المجموعة ${setIndex + 1}  •  ${exercise.reps}",
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      decoration: exercise.completedSets[setIndex] ? TextDecoration.lineThrough : null, // شطب النص عند الاكتمال
                      color: exercise.completedSets[setIndex] ? Colors.grey : Colors.black,
                    ),
                  ),
                  value: exercise.completedSets[setIndex],
                  onChanged: (bool? value) {
                    setState(() {
                      exercise.completedSets[setIndex] = value ?? false;
                    });
                  },
                );
              }),
            ),
          );
        },
      ),
    );
  }
}