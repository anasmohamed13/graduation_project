import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:garduationproject/model/doctor_model/doctor_model.dart';
import 'package:garduationproject/ui/screen/chat/chat_page.dart';
import 'package:garduationproject/ui/screen/doctor/home/calendar_screen.dart';
import 'package:garduationproject/ui/screen/doctor/patient_queue/patient_queue.dart';
import 'package:garduationproject/ui/util/app_assets.dart';
import 'package:intl/intl.dart';

class DoctorHomeScreen extends StatefulWidget {
  static const String routeName = 'doctorHome';

  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  Map<String, dynamic>? parentData;
  String? parentId;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? parentImageUrl;
  String? doctorName;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadDoctorName();
    fetchLinkedParent();
  }

  Future<void> fetchLinkedParent() async {
    final currentUser = auth.currentUser;
    if (currentUser == null) return;

    final snapshot = await firestore
        .collection("Parent")
        .where("doctorEmail", isEqualTo: currentUser.email)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      setState(() {
        parentData = snapshot.docs.first.data();
        parentId = snapshot.docs.first.id;
        parentImageUrl = parentData?['profileImage'];
      });
    }
  }

  Future<DoctorModel?> fetchDoctorData() async {
    final uid = FirebaseAuth.instance.currentUser?.email;
    if (uid == null) return null;

    final doc =
        await FirebaseFirestore.instance.collection('Doctor').doc(uid).get();
    if (!doc.exists || doc.data() == null) return null;

    return DoctorModel.fromJson(doc.data()!);
  }

  Future<void> loadDoctorName() async {
    final DoctorModel? userData = await fetchDoctorData();

    if (userData != null) {
      setState(() {
        doctorName = userData.fullName;
        isLoading = false;
      });
    } else {
      setState(() {
        doctorName = "Doctor";
        isLoading = false;
      });
      if (kDebugMode) {
        print("⚠️ No doctor data found for the current UID.");
      }
    }
  }

  String _getFormattedDate(int daysToAdd) {
    final date = DateTime.now().add(Duration(days: daysToAdd));
    final day = date.day;
    final weekday = DateFormat('E').format(date); // e.g., Mon, Tue
    return '$day\n$weekday';
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
                      Text(
                        DateFormat('d MMMM yyyy').format(DateTime.now()),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_none),
                        onPressed: () {},
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

            // Stats Card
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
                      Navigator.pushNamed(
                          context, PatientQueueScreen.routeName);
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

            // Timetable Header
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

            // Horizontal Day Scroll
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  for (int i = 0; i < 6; i++)
                    Container(
                      width: 48,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: i == 0
                            ? Colors.red
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _getFormattedDate(i),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight:
                              i == 0 ? FontWeight.bold : FontWeight.normal,
                          color: i == 0 ? Colors.white : Colors.black87,
                        ),
                      ),
                    )
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Parent Info Card
            if (parentData != null)
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.09,
                margin: const EdgeInsets.symmetric(vertical: 15),
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 4)
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundImage: parentImageUrl != null
                          ? NetworkImage(parentImageUrl!)
                          : const AssetImage(AppAssets.girlMoji)
                              as ImageProvider,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            parentData?['fullName'] ?? 'Parent',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          ChatPage.routeName,
                          arguments: {
                            'doctorEmail':
                                FirebaseAuth.instance.currentUser!.email!,
                            'parentEmail': parentId,
                          },
                        );
                      },
                      icon: Image.asset(
                        color: Colors.orange,
                        AppAssets.message,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
