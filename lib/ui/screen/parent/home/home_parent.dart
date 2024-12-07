import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/parent/profile/profile_parent.dart';

class HomeParent extends StatefulWidget {
  static const String routeName = 'parentHome';
  const HomeParent({super.key});

  @override
  State<HomeParent> createState() => _HomeParentState();
}

class _HomeParentState extends State<HomeParent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarHomeParent(),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * .04),
              const Text(
                'services',
                style: TextStyle(
                    fontFamily: 'inter',
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * .55),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(
                      fontFamily: 'inter',
                      fontSize: 13,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildServices(text: 'Child Progress'),
              buildServices(text: 'GATO Chat'),
              buildServices(text: 'Ask Doctor'),
            ],
          )
        ],
      ),
    );
  }

  AppBar buildAppBarHomeParent() {
    return AppBar(
      toolbarHeight: 80,
      title: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good Morning !',
            style: TextStyle(
              fontSize: 35,
              fontFamily: 'inter',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Alex wellson',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'inter',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: buildCircleAvatar(
              borderRadius: BorderRadius.circular(35),
              radius: 35,
              elevation: 4),
        )
      ],
    );
  }

  Widget buildServices({
    required String text,
  }) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return InkWell(
      child: Container(
        height: height * 0.05,
        width: width * 0.3,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontFamily: 'inter',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
