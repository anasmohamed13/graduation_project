import 'package:flutter/material.dart';

class AnswerOptions extends StatelessWidget {
  final List<int> options;
  final bool isAnswered;
  final void Function(int) onSelected;

  const AnswerOptions({
    required this.options,
    required this.isAnswered,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorList = [Colors.blue, Colors.pink, Colors.red, Colors.teal];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(options.length, (i) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: colorList[i % colorList.length],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            minimumSize: const Size(64, 64),
            elevation: 6,
          ),
          onPressed: isAnswered ? null : () => onSelected(options[i]),
          child: Text(
            options[i].toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: colorList[i % colorList.length],
            ),
          ),
        );
      }),
    );
  }
}
