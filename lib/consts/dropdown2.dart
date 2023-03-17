import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DropDown2 extends StatefulWidget {
  const DropDown2({super.key});

  @override
  State<DropDown2> createState() => _DropDown2State();
}

class _DropDown2State extends State<DropDown2> {
  final List<String> items = [
    'Month',
    'January,2023',
    'February,2023',
    'March,2023',
    'April,2023',
    'May,2023',
    'June,2023',
    'July,2023',
    'Auguest,2023',
    'September,2023',
    'October,2023',
    'November,2023',
    'December,2023',
  ];
  String ? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: const [
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Center(
                child: Text(
                  "Month",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF34B5FF),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,            
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
        },
        icon: const Icon(
          Icons.keyboard_arrow_down_outlined,
        ),
        iconSize: 20,
        iconEnabledColor: Colors.blue,
        iconDisabledColor: Colors.blue,
        buttonHeight: 40,
        buttonWidth: 160,
        buttonPadding: const EdgeInsets.only(left: 6, right: 6),
        buttonDecoration: BoxDecoration(
          color: Color(0XFFE8F6FF),//
          borderRadius: BorderRadius.circular(2),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 1,
              offset: Offset(0, 0),
            ),
          ],
        ),
        buttonElevation: 2,
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: 180,
        dropdownWidth: 160,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.white,
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(10),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: const Offset(0, 0),
      ),
    );
  }
}