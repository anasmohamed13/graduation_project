import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:garduationproject/ui/screen/doctor/patient_queue/patient_queue.dart';

class PatientCardScreen extends StatefulWidget {
  static const String routeName = 'PatientCardScreen';

  const PatientCardScreen({super.key});

  @override
  State<PatientCardScreen> createState() => _PatientCardScreenState();
}

class _PatientCardScreenState extends State<PatientCardScreen> {
  int selectedIndex = 0;
  late double percent;
  Map<String, dynamic>? patientData;
  @override
  void initState() {
    super.initState();
    percent = generateRandomPercentage();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // استقبال البيانات المرسلة من الصفحة السابقة
    patientData ??=
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
  }

  double generateRandomPercentage() {
    final random = Random();
    return ((random.nextDouble() * 0.99) + 0.01);
  }

  @override
  Widget build(BuildContext context) {
    if (patientData == null) {
      return const Scaffold(
        body: Center(
          child: Text('No patient data available'),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 34, left: 25, right: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 34),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 48,
                    width: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: const CircleBorder(),
                        backgroundColor: const Color(0xffF1F1F1),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, PatientQueueScreen.routeName);
                      },
                      child: const Icon(Icons.arrow_back_rounded,
                          color: Colors.black),
                    ),
                  ),
                  const Text(
                    "Patient card",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 30),

              Container(
                height: 185,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 29),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0x59FF5B46), Color(0xEDE62F16)],
                    stops: [0.0, 0.83],
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Text(
                              "${patientData!['parentName']}'s\n${patientData!['childGender'] == 'male' ? 'son' : 'daughter'}",
                              style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text("Age: ${patientData!['age']}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontFamily: 'inter',
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset('assets/image/parentcat.png',
                          fit: BoxFit.contain),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xffF6F6F6),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Problem research",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black)),
                          SizedBox(height: 5),
                          Text("Dr. Tom Nelson",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    CircularPercentIndicator(
                      radius: 35,
                      lineWidth: 6.0,
                      animation: true,
                      percent: percent,
                      center: Text(
                        "${(percent * 100).toInt()}%",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: const Color(0xFFE74C3C),
                      backgroundColor: const Color(0xFFEDEDED),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 33),

              // 🔵 CIRCLE ICON SELECTORS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      height: 67,
                      width: 67,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              selectedIndex == index ? Colors.red : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          problems[index].imagePath,
                          color:
                              selectedIndex == index ? Colors.red : Colors.grey,
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 30),

              // 🟣 DESCRIPTION SECTION
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xffF6F6F6),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      problems[selectedIndex].title,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      problems[selectedIndex].description,
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProblemDetail {
  final String title;
  final String description;
  final String imagePath;

  ProblemDetail(
      {required this.title,
      required this.description,
      required this.imagePath});
}

final List<ProblemDetail> problems = [
  ProblemDetail(
    title: "Physical Problem",
    description:
        "Current situation: He has a speech delay and difficulty forming sentences correctly. "
        "Problem: He does not pronounce words clearly and has difficulty pronouncing difficult letters. "
        "Impact of the problem: He has low self-confidence and avoids speaking in front of others.",
    imagePath: 'assets/image/brain.png',
  ),
  ProblemDetail(
    title: "Communicational Problem",
    description:
        "Current situation: The patient has difficulty expressing his thoughts clearly, especially in social situations. "
        "Problem: He has difficulty understanding the intentions of others. "
        "Effect: Leads to isolation and misunderstandings.",
    imagePath: 'assets/image/icons8-family-50.png',
  ),
  ProblemDetail(
    title: "Emotional Problem",
    description: "Current situation: Frequent mood swings and insecurity. "
        "Problem: Difficulty expressing feelings causes stress buildup. "
        "Impact: Anxiety symptoms like tension and sudden crying.",
    imagePath: 'assets/image/icons8-anime-emoji-64.png',
  ),
  ProblemDetail(
    title: "Learning Problem",
    description: "Current situation: Struggles with concentration and memory. "
        "Problem: Difficulty following instructions and completing tasks. "
        "Impact: Affects academic performance and confidence.",
    imagePath: 'assets/image/icons8-book-shelf-50.png',
  ),
];
