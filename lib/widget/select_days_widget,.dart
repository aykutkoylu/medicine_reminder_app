import 'package:flutter/material.dart';

class SelectDaysWidget extends StatelessWidget {
  final String dayName;
  final Function onPress;
  final Color pressedColor;
  final Color pressedTextColor;
  const SelectDaysWidget({
    Key? key,
    required this.dayName,
    required this.onPress,
    required this.pressedColor,
    required this.pressedTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress.call();
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(color: pressedColor, borderRadius: BorderRadius.all(Radius.circular(8))),
        alignment: Alignment.center,
        child: Text(dayName, style: TextStyle(fontSize: 12, color: pressedTextColor)),
      ),
    );
  }
}
