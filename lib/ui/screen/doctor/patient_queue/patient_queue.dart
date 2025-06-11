import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/doctor/patient_card/patient_card_screen.dart';

class PatientQueueScreen extends StatefulWidget {
  static const String routeName = 'patientQueue';

  const PatientQueueScreen({super.key});

  @override
  State<PatientQueueScreen> createState() => _PatientQueueScreenState();
}

class _PatientQueueScreenState extends State<PatientQueueScreen> {
  List<Map<String, dynamic>> patients = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPatients();
  }

  Future<void> fetchPatients() async {
    try {
      final doctorEmail = FirebaseAuth.instance.currentUser?.email;
      if (doctorEmail == null) return;

      final snapshot = await FirebaseFirestore.instance
          .collection('Parent')
          .where('doctorEmail', isEqualTo: doctorEmail)
          .get();

      final List<Map<String, dynamic>> loadedPatients = [];

      for (var parentDoc in snapshot.docs) {
        final parentData = parentDoc.data();
        final parentName = parentData['fullName'] ?? 'No Name';
        final parentImage = parentData['image'] ?? 'assets/image/default.png';

        final childrenSnapshot = await FirebaseFirestore.instance
            .collection('Parent')
            .doc(parentDoc.id)
            .collection('Children')
            .get();

        for (var childDoc in childrenSnapshot.docs) {
          final childData = childDoc.data();

          final childGender = childData['gender'] ?? 'Unknown';
          final age = childData['age'] ?? 'No entry age';

          loadedPatients.add({
            'parentId': parentDoc.id,
            'childId': childDoc.id,
            'parentName': parentName,
            'parentImage': parentImage,
            'childGender': childGender,
            'age': age
          });
        }
      }

      setState(() {
        patients = loadedPatients;
        isLoading = false;
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching patients: $e');
      setState(() {
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Patient Queue',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: patients.length,
                      itemBuilder: (context, index) {
                        final patient = patients[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundImage:
                                    AssetImage(patient['image'] ?? ''),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      patient['parentName']!,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, PatientCardScreen.routeName,
                                      arguments: {
                                        'parentId': patient['parentId'],
                                        'childId': patient['childId'],
                                        'parentName': patient['parentName'],
                                        'parentImage': patient['parentImage'],
                                        'childName': patient['childName'],
                                        'childGender': patient['childGender'],
                                        'age': patient['age'],
                                      });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFF8C8C),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                ),
                                child: const Text(
                                  'View Patient Card',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
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
