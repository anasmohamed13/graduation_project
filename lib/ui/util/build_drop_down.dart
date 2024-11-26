import 'package:flutter/material.dart';

Widget buildDropDown({
  required String? text,
  required Color? color,
  required Widget? icon,
  required double fontsize,
  required double height,
  required double width,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text ?? '',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'inter',
              fontSize: fontsize,
              fontWeight: FontWeight.w700),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          height: height,
          width: width,
          child: DropdownButtonFormField(
            iconSize: 4,

            icon: icon,
            dropdownColor: Colors.grey.shade100,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(40),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(40),
              ),
              filled: true,
              fillColor: color,
            ),
            isExpanded: true,
            //this items is display numbers 1-10
            items: List.generate(
              5,
              (index) {
                int value = index + 1;
                return DropdownMenuItem(
                  value: value.toString(),
                  child: Text(value.toString()),
                );
              },
            ),
            onChanged: (value) {},
          ),
        ),
      ],
    );
