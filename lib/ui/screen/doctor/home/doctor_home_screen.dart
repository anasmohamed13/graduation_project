import 'package:flutter/material.dart';
import 'package:garduationproject/model/doctor_model/doctor_model.dart';
import 'package:garduationproject/model/firebase/firebase_service.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; // 🔹 Uncomment if using Firebase
// import 'package:table_calendar/table_calendar.dart'; // 🔹 Optional calendar package
import 'package:garduationproject/ui/screen/doctor/home/calendar_screen.dart';
import 'package:garduationproject/ui/screen/doctor/patient_queue/patient_queue.dart';

class DoctorHomeScreen extends StatefulWidget {
  static const String routeName = 'doctorHome';

  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  // Replace this static list later with real-time Firebase data
  List<Map<String, String>> timetable = [
    {
      'time': '2 p.m.',
      'name': 'Teresa Wilier',
      'image': 'assets/image/Ellipse 9.png',
    },
    {
      'time': '4 p.m.',
      'name': 'Ivan Wilier',
      'image': 'assets/image/Ellipse 10.png',
    },
    {
      'time': '6 p.m.',
      'name': 'Anna Wilier',
      'image': 'assets/image/Ellipse 11.png',
    },
  ];

  String? doctorName;
  bool isLoading = true;

  /*
  // 🔹 Sample Firebase Firestore integration (Replace timetable above)
  Future<void> fetchTimetableFromFirestore() async {
    final snapshot = await FirebaseFirestore.instance.collection('appointments').get();
    setState(() {
      timetable = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'time': data['time'] ?? '',
          'name': data['name'] ?? '',
          'image': data['image'] ?? 'assets/image/default_avatar.png',
        };
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTimetableFromFirestore(); // 🔹 Uncomment when Firebase is configured
  }
  */

  @override
  void initState() {
    super.initState();
    loadDoctorName();
  }

  Future<void> loadDoctorName() async {
    final firebaseService = FirebaseService();
    final userData = await firebaseService.fetchUserData();
    if (userData is DoctorModel) {
      setState(() {
        doctorName = userData.fullName;
        isLoading = false;
      });
    } else {
      setState(() {
        "Doctor";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage('assets/image/Ellipse 1.png'),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, $doctorName',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        '11 November 2024',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_none),
                        onPressed: () {
                          // Add notification logic
                        },
                      ),
                      const Positioned(
                        top: 10,
                        right: 10,
                        child: CircleAvatar(
                            radius: 5, backgroundColor: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Patient count card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 10)
                ],
              ),
              child: Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Number of patient (+30)',
                          style: TextStyle(fontSize: 20)),
                      SizedBox(height: 4),
                      Text('130',
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)),
                      Text('24 not active',
                          style: TextStyle(fontSize: 18, color: Colors.grey)),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const PatientQueueScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCCCCCC),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('View Queue',
                        style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Timetable heading
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Text(
                    'Your timetable',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.tune, size: 30),
                    onPressed: () {
                      // Open calendar page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CalendarScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Horizontal Days Row
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  for (final day in [
                    '10\nSun',
                    '11\nMon',
                    '12\nTue',
                    '13\nWed',
                    '14\nThr',
                    '15\nFri'
                  ])
                    Container(
                      width: 48,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: day.contains('Mon')
                            ? Colors.red
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        day,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: day.contains('Mon')
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    )
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Timetable List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: timetable.length,
                itemBuilder: (context, index) {
                  final entry = timetable[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 4)
                      ],
                    ),
                    child: Row(
                      children: [
                        Text(
                          entry['time']!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 16),
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(entry['image']!),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry['name']!,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              const Text(
                                'Attached file',
                                style:
                                    TextStyle(fontSize: 13, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Start chat with patient
                          },
                          icon: const Icon(Icons.chat_bubble_outline,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
