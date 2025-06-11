import 'dart:math';
import 'package:fl_chart_flutter/fl_chart_flutter.dart';
import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/parent/gato_timer/gato_timer.dart';
import 'package:garduationproject/ui/screen/parent/home/home_parent.dart';
import 'package:garduationproject/ui/util/app_assets.dart';

class ChildProgressScreen extends StatefulWidget {
  const ChildProgressScreen({super.key});
  static const String routeName = "child progress";

  @override
  State<ChildProgressScreen> createState() => _ChildProgressScreenState();
}

class _ChildProgressScreenState extends State<ChildProgressScreen> {
  final Random _rnd = Random();
  late List<double> _barValues;
  late Map<String, double> _indicatorValues;

  @override
  void initState() {
    super.initState();
    _barValues = List.generate(
      12,
      (_) => (_rnd.nextDouble() * 0.99 + 0.01) * 100,
    );

    _indicatorValues = {
      'Education': _rnd.nextDouble(),
      'Activity': _rnd.nextDouble(),
      'Social Skills': _rnd.nextDouble(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        elevation: 0,
        title: const Text(
          'Child Progress',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(AppAssets.girlMoji),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAchievementSection(),
            const SizedBox(height: 20),
            buildDailyProgressChart(),
            const SizedBox(height: 20),
            buildProgressIndicators(),
            const Spacer(),
            buildBottomNavBar(),
          ],
        ),
      ),
    );
  }

  Widget buildAchievementSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        achievementCard('77%\nAchievement', Icons.emoji_events),
        achievementCard('32%\nEmotions', Icons.favorite_border),
      ],
    );
  }

  Widget achievementCard(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black54, size: 24),
          const SizedBox(width: 8),
          Text(text,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }

  Widget buildDailyProgressChart() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Daily Progress',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: BarChart(
              BarChartData(
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const months = [
                          'J',
                          'F',
                          'M',
                          'A',
                          'M',
                          'J',
                          'J',
                          'A',
                          'S',
                          'O',
                          'N',
                          'D'
                        ];
                        return Text(months[value.toInt()],
                            style: const TextStyle(fontSize: 12));
                      },
                      reservedSize: 22,
                    ),
                  ),
                ),
                barGroups: List.generate(
                  12,
                  (i) => BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: _barValues[i],
                        width: 10,
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProgressIndicators() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Overall Skills',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          for (var entry in _indicatorValues.entries)
            progressBar(entry.key, entry.value, _iconFor(entry.key)),
        ],
      ),
    );
  }

  IconData _iconFor(String title) {
    switch (title) {
      case 'Education':
        return Icons.book;
      case 'Activity':
        return Icons.directions_run;
      case 'Social Skills':
        return Icons.star;
      default:
        return Icons.circle;
    }
  }

  Widget progressBar(String title, double value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: value,
                  backgroundColor: Colors.grey[300],
                  color: Colors.blue,
                  minHeight: 8,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text('${(value * 100).toInt()}%',
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget buildBottomNavBar() {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Center(
      child: Container(
        width: 250,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                if (currentRoute != HomeParent.routeName) {
                  Navigator.pushNamed(context, HomeParent.routeName);
                }
              },
              child: Icon(
                Icons.home,
                size: 30,
                color: currentRoute == HomeParent.routeName
                    ? Colors.blue
                    : Colors.black,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (currentRoute != GatoTimer.routeName) {
                  Navigator.pushNamed(context, GatoTimer.routeName);
                }
              },
              child: Icon(
                Icons.history,
                size: 30,
                color: currentRoute == GatoTimer.routeName
                    ? Colors.blue
                    : Colors.black,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (currentRoute != ChildProgressScreen.routeName) {
                  Navigator.pushNamed(context, ChildProgressScreen.routeName);
                }
              },
              child: Icon(
                Icons.settings,
                size: 30,
                color: currentRoute == ChildProgressScreen.routeName
                    ? Colors.blue
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
