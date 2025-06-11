
import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/doctor/profile/patient_card_screen.dart';

class PatientQueueScreen extends StatefulWidget {
  static const String routeName = 'patientQueue';

  const PatientQueueScreen({super.key});

  @override
   State<PatientQueueScreen> createState() => _PatientQueueScreenState();
}

class _PatientQueueScreenState extends State<PatientQueueScreen> {
  
  final List<Map<String, String>> patients = [
    {
      'name': 'Teresa Wilier',  
      'date': '12 Oct 2024',
      'image': 'assets/image/Ellipse 9.png'
    },
    {
      'name': 'Anna Wilier',
      'date': '4 Jun 2024',
      'image': 'assets/image/Ellipse 11.png'
    },
    {
      'name': 'Ivan Wilier',
      'date': '19 Aug 2024',
      'image': 'assets/image/Ellipse 10.png'
    },
    {
      'name': 'John Wilier',
      'date': '10 Nov 2024',
      'image': 'assets/image/Ellipse 12.png'
    },
    {
      'name': 'Sarah Wilier',
      'date': '7 Jul 2024',
      'image': 'assets/image/Ellipse 16.png'
    },
    {
      'name': 'Tom Wilier',
      'date': '1 Feb 2024',
      'image': 'assets/image/Ellipse 17.png'
    },
  ];

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
                      Navigator.pushReplacementNamed(context,PatientCardScreen.routeName);
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

            
            Expanded(
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
                          backgroundImage: AssetImage(patient['image']!),
                        ),
                        const SizedBox(width: 12),

                        
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                patient['name']!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Joined in ${patient['date']}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        
                        ElevatedButton(
                          onPressed: () {
                            
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
                            style: TextStyle(color: Colors.white, fontSize: 12),
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