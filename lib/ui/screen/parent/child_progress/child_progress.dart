// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:garduationproject/ui/util/app_assets.dart';

// class ChildProgressScreen extends StatelessWidget {
//   const ChildProgressScreen({super.key});
//   static const String routeName = "child progress";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue[50],
//       appBar: AppBar(
//         backgroundColor: Colors.blue[50],
//         elevation: 0,
//         title: const Text('Child Progress',
//             style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black)),
//         centerTitle: true,
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 16.0),
//             child: CircleAvatar(
//               backgroundImage: AssetImage(AppAssets.girlMoji),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             buildAchievementSection(),
//             const SizedBox(height: 20),
//             buildDailyProgressChart(),
//             const SizedBox(height: 20),
//             buildProgressIndicators(),
//             const Spacer(),
//             buildBottomNavBar(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildAchievementSection() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         achievementCard('77%\nAchievement', Icons.emoji_events),
//         achievementCard('32%\nEmotions', Icons.favorite_border),
//       ],
//     );
//   }

//   Widget achievementCard(String text, IconData icon) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: Colors.black54, size: 24),
//           const SizedBox(width: 8),
//           Text(
//             text,
//             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildDailyProgressChart() {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('Daily Progress',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 10),
//           SizedBox(
//             height: 150,
//             child: BarChart(
//               BarChartData(
//                 borderData: FlBorderData(show: false),
//                 titlesData: FlTitlesData(
//                   leftTitles: const AxisTitles(
//                       sideTitles: SideTitles(showTitles: false)),
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       getTitlesWidget: (double value, TitleMeta meta) {
//                         List<String> months = [
//                           'J',
//                           'F',
//                           'M',
//                           'A',
//                           'M',
//                           'J',
//                           'J',
//                           'A',
//                           'S',
//                           'O',
//                           'N',
//                           'D'
//                         ];
//                         return Text(months[value.toInt()],
//                             style: const TextStyle(fontSize: 12));
//                       },
//                       reservedSize: 22,
//                     ),
//                   ),
//                 ),
//                 barGroups: List.generate(12, (index) => barGroup(index)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   BarChartGroupData barGroup(int index) {
//     return BarChartGroupData(x: index, barRods: [
//       BarChartRodData(toY: (index % 4 + 3) * 10, color: Colors.blue, width: 10),
//     ]);
//   }

//   Widget buildProgressIndicators() {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('Daily Progress',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 10),
//           progressBar('Education', 0.44, Icons.book),
//           progressBar('Activity', 0.83, Icons.directions_run),
//           progressBar('social skills', 0.63, Icons.star),
//         ],
//       ),
//     );
//   }

//   Widget progressBar(String title, double value, IconData icon) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Icon(icon, color: Colors.blue),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title,
//                     style: const TextStyle(
//                         fontSize: 14, fontWeight: FontWeight.bold)),
//                 LinearProgressIndicator(
//                     value: value,
//                     backgroundColor: Colors.grey[300],
//                     color: Colors.blue),
//               ],
//             ),
//           ),
//           const SizedBox(width: 10),
//           Text('${(value * 100).toInt()}%',
//               style:
//                   const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }

//   Widget buildBottomNavBar() {
//     return Center(
//       child: Container(
//         width: 250,
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(30),
//           boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
//         ),
//         child: const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Icon(Icons.home, size: 30, color: Colors.blue),
//             Icon(Icons.history, size: 30, color: Colors.black),
//             Icon(Icons.settings, size: 30, color: Colors.black),
//           ],
//         ),
//       ),
//     );
//   }
// }
