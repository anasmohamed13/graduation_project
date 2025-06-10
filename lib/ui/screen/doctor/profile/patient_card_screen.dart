import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PatientCardScreen extends StatefulWidget {
  static const String routeName = 'PatientCardScreen';

  const PatientCardScreen({super.key});

  @override
  State<PatientCardScreen> createState() => _PatientCardScreenState();
}

class _PatientCardScreenState extends State<PatientCardScreen> {
  int selectedIndex = 0;
  double percent = 0.64;

  @override
  Widget build(BuildContext context) {
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
                  Container(
                    height: 82,
                    width: 82,
                    decoration: const ShapeDecoration(
                      shape: CircleBorder(),
                      color: Color(0xffF1F1F1),
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
                    ),
                  ),
                  const Text(
                    "Patient card",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  const SizedBox(height: 82, width: 82)
                ],
              ),
              const SizedBox(height: 30),
              Container(
                height: 185,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 29),
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
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Patient #21", style: TextStyle(color: Colors.white, fontSize: 14)),
                          SizedBox(height: 5),
                          Text("Teresa Wilier 's\ndaughter",
                              style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Text("12 y.o.", style: TextStyle(color: Colors.white, fontSize: 18)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset('assets/image/parentcat.png', fit: BoxFit.contain),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xffF6F6F6),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: Row(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Problem research", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
                        Text("start date: 10 Nov,2024", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey)),
                        Text("Doctor: Tom Nelson", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black)),
                      ],
                    ),
                    const SizedBox(width: 5),
                    CircularPercentIndicator(
                      radius: 40,
                      lineWidth: 8.0,
                      animation: true,
                      percent: percent,
                      center: Text(
                        "${(percent * 100).toInt()}%",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: const Color(0xFFE74C3C),
                      backgroundColor: const Color(0xFFEDEDED),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 33),
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
                          color: selectedIndex == index ? Colors.red : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          problems[index].imagePath,
                          color: selectedIndex == index ? Colors.red : Colors.grey,
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 30),
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
                      style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      problems[selectedIndex].description,
                      style: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w500),
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

  ProblemDetail({required this.title, required this.description, required this.imagePath});
}

final List<ProblemDetail> problems = [
  ProblemDetail(
    title: "Physical Problem",
    description:
        "Current situation: He has a speech delay and difficulty forming sentences correctly. "
        "Problem: He does not pronounce words clearly and has difficulty pronouncing difficult letters. "
        "Impact of the problem: He has low self-confidence and avoids speaking in front of others ",
    imagePath: 'assets/image/brain.png',
  ),
  ProblemDetail(
    title: "Communicational Problem",
    description:
        "Current situation: The patient has difficulty expressing his thoughts clearly, especially in social situations. "
        "Problem: He has difficulty understanding the intentions of others or interpreting their expressions correctly. "
        "Effect of the problem: This sometimes leads to embarrassing situations or misunderstandings by others, which increases his isolation. ",
    imagePath: 'assets/image/faces.png',
  ),
  ProblemDetail(
    title: "Emotional Problem",
    description:
        "Current situation: He suffers from frequent mood swings and a constant feeling of insecurity."
        "Problem: He finds it difficult to talk about his feelings or express what is bothering him, which leads to an accumulation of stress. "
        "Impact of the problem: He shows symptoms of anxiety such as tension or sudden crying in unexpected situations ",
    imagePath: 'assets/image/Ellipse7.png',
  ),
  ProblemDetail(
    title: "Learning Problem",
    description:
        "Current situation: He struggles with concentration during lessons and forgets learned material quickly. "
        "Problem: He finds it difficult to follow instructions and complete assignments on time. "
        "Effect of the problem: This impacts his academic performance and confidence in class.",
    imagePath: 'assets/image/Ellipse55.png',
  ),
];
