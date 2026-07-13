import 'package:flutter/material.dart';

// ==========================================
// 1. موديل بيانات الجسم ومحرك الحسابات الديناميكي
// ==========================================
class UserMetrics {
  final double weightKg;
  final double heightCm;
  final int age;
  final double activityMultiplier;
  final bool? isRapidLoss; // أضفناها هنا عشان تقبلها الـ Home Screen من غير إيرور

  const UserMetrics({
    required this.weightKg,
    required this.heightCm,
    required this.age,
    this.activityMultiplier = 1.2,
    this.isRapidLoss,
  });
}

class ZabetCalculationEngine {
  final UserMetrics metrics;
  ZabetCalculationEngine(this.metrics);

  // حساب السعرات المستهدفة (متغيرة حسب الوزن، الطول، العمر)
  double calculateTargetCalories() {
    double bmr = (10 * metrics.weightKg) + (6.25 * metrics.heightCm) - (5 * metrics.age) + 5;
    return bmr * metrics.activityMultiplier;
  }

  // حساب هدف الترطيب باللتر حسب الوزن
  double calculateWaterGoalLiters() {
    return (metrics.weightKg * 0.035).clamp(2.0, 5.0);
  }
}

// ==========================================
// 2. الشاشة الأولى: إدخال بيانات الجسم
// ==========================================
class ZabetDietScreen extends StatefulWidget {
  const ZabetDietScreen({super.key});

  @override
  State<ZabetDietScreen> createState() => _ZabetDietScreenState();
}

class _ZabetDietScreenState extends State<ZabetDietScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _calculateAndNavigate(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final double weight = double.parse(_weightController.text);
      final double height = double.parse(_heightController.text);
      final int age = int.parse(_ageController.text);

      final userMetrics = UserMetrics(
        weightKg: weight,
        heightCm: height,
        age: age,
        activityMultiplier: 1.2,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ZabetDashboardScreen(userMetrics: userMetrics),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('بيانات جسمك', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'الوزن (كجم)',
                  hintText: 'أدخل الوزن كجم',
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF6A1B9A))),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null) {
                    return 'يرجى إدخال وزن صحيح';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'الطول (سم)',
                  hintText: 'أدخل الطول سم',
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF6A1B9A))),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null) {
                    return 'يرجى إدخال طول صحيح';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'العمر',
                  hintText: 'أدخل العمر',
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF6A1B9A))),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'يرجى إدخال عمر صحيح';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 56),
              ElevatedButton(
                onPressed: () => _calculateAndNavigate(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF3E5F5),
                  foregroundColor: const Color(0xFF4A148C),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'احسب وجباتي',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 3. الشاشة الثانية: الداشبورد التفاعلي المربوط بالسعرات
// ==========================================
class ZabetDashboardScreen extends StatefulWidget {
  final UserMetrics userMetrics;
  const ZabetDashboardScreen({super.key, required this.userMetrics});

  @override
  State<ZabetDashboardScreen> createState() => _ZabetDashboardScreenState();
}

class _ZabetDashboardScreenState extends State<ZabetDashboardScreen> {
  final Map<int, bool> _mealStatus = {0: false, 1: false, 2: false, 3: false};

  @override
  Widget build(BuildContext context) {
    final engine = ZabetCalculationEngine(widget.userMetrics);
    final targetCalories = engine.calculateTargetCalories();
    final waterGoal = engine.calculateWaterGoalLiters();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      appBar: AppBar(
        title: const Text('Zabet - Dashboard', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildCircularMetricCard(
                    title: 'Target Calories',
                    value: targetCalories.toStringAsFixed(0),
                    unit: 'Kcal',
                    progress: 0.85,
                    progressColor: const Color(0xFF334411),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildCircularMetricCard(
                    title: 'Hydration Goal',
                    value: waterGoal.toStringAsFixed(1),
                    unit: 'Liters',
                    progress: 0.70,
                    progressColor: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Egyptian Military Fuel Plan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            _buildMealCard(
              index: 0,
              title: 'الإفطار (وجبة 1)',
              calories: '${(targetCalories * 0.25).toStringAsFixed(0)} Kcal',
              description: 'بيض مقلي أو بوش + جبن قريش + خبز أسمر',
            ),
            const SizedBox(height: 12),
            _buildMealCard(
              index: 1,
              title: 'الغداء (وجبة 2)',
              calories: '${(targetCalories * 0.35).toStringAsFixed(0)} Kcal',
              description: 'أرز مصري + صدور دجاج مشوية + سلطة خضراء',
            ),
            const SizedBox(height: 12),
            _buildMealCard(
              index: 2,
              title: 'السناك (وجبة 3)',
              calories: '${(targetCalories * 0.15).toStringAsFixed(0)} Kcal',
              description: 'موز + مكسرات أو زبادي يوناني',
            ),
            const SizedBox(height: 12),
            _buildMealCard(
              index: 3,
              title: 'العشاء (وجبة 4)',
              calories: '${(targetCalories * 0.25).toStringAsFixed(0)} Kcal',
              description: 'مكرونة مسلوقة + تونة أو صدور دجاج',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularMetricCard({
    required String title,
    required String value,
    required String unit,
    required double progress,
    required Color progressColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.06), blurRadius: 8, spreadRadius: 2),
        ],
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500)),
          const SizedBox(height: 12),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 75,
                height: 75,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 7,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Text(unit, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMealCard({
    required int index,
    required String title,
    required String calories,
    required String description,
  }) {
    final bool isChecked = _mealStatus[index] ?? false;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isChecked ? const Color(0xFF334411).withOpacity(0.04) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isChecked ? const Color(0xFF334411) : Colors.transparent,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 6, spreadRadius: 2),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: isChecked,
            activeColor: const Color(0xFF334411),
            onChanged: (bool? value) {
              setState(() {
                _mealStatus[index] = value ?? false;
              });
            },
          ),
          const SizedBox(width: 0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        decoration: isChecked ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    Text(calories, style: const TextStyle(fontSize: 13, color: Colors.deepOrange, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(description, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}