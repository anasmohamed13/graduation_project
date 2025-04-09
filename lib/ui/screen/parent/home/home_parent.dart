import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:garduationproject/ui/screen/parent/profile/profile_parent.dart';

class HomeParent extends StatefulWidget {
  static const String routeName = 'parentHome';
  const HomeParent({super.key});

  @override
  State<HomeParent> createState() => _HomeParentState();
}

class _HomeParentState extends State<HomeParent> {
  bool isChildProgressSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade200, Colors.purple.shade200],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAppBarHomeParent(),
                const SizedBox(height: 20),
                buildServicesRow(),
                const SizedBox(height: 20),
                buildNotifications(),
                const SizedBox(height: 20),
                buildRecentChats(),
                const Spacer(),
                buildBottomButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBarHomeParent() {
    return AppBar(
      toolbarHeight: 80,
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good Morning!',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Alex Willson',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: CircleAvatar(
            radius: 30,
            backgroundImage:
                AssetImage('assets/avatar.png'), // Adjust image path
          ),
        ),
      ],
    );
  }

  Widget buildServicesRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildServiceButton('Child Progress',
            isSelected: isChildProgressSelected, onTap: () {
          setState(() {
            isChildProgressSelected = !isChildProgressSelected;
          });
        }),
        buildServiceButton('GATO Chat', onTap: () {}),
        buildServiceButton('Ask Doctor', onTap: () {}),
      ],
    );
  }

  Widget buildServiceButton(String text,
      {required VoidCallback onTap, bool isSelected = false}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildNotifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Notifications',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        notificationCard('🎉 Congratulation',
            'Your son has achieved high marks in mathematics.', 'View More'),
        const SizedBox(height: 10),
        notificationCard('⚠️ Alert !!',
            'Your child has changed his daily routine.', 'Connect'),
      ],
    );
  }

  Widget notificationCard(String title, String message, String buttonText) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 5),
          Text(message,
              style: const TextStyle(fontSize: 14, color: Colors.black87)),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child:
                  Text(buttonText, style: const TextStyle(color: Colors.blue)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRecentChats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Recent Chats',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        chatBubble('How are you? I’m here to check up on you.'),
        const SizedBox(height: 10),
        chatBubble('Any Questions? Ask GATO...'),
      ],
    );
  }

  Widget chatBubble(String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child:
          Text(text, style: const TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Widget buildBottomButtons() {
    return Column(
      children: [
        TextButton(
          onPressed: () {},
          child: const Text('View All', style: TextStyle(color: Colors.blue)),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: const Text('New Chat', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
