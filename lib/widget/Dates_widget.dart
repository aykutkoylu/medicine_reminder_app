import 'package:flutter/material.dart';

class DatesWidget extends StatelessWidget {
  final String day;
  final String weekName;
  final Function onPress;
  final Color pressedColor;
  final Color pressedTextColor;
  DatesWidget(
      {Key? key,
      required this.day,
      required this.onPress,
      required this.pressedColor,
      required this.weekName,
      required this.pressedTextColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress.call();
      },
      child: Container(
        height: 64,
        width: 40,
        decoration: BoxDecoration(color: pressedColor, borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          children: [
            SizedBox(height: 4),
            Text(weekName, style: TextStyle(fontSize: 16, color: pressedTextColor)),
            SizedBox(height: 8),
            Text(
              day,
              style: TextStyle(fontSize: 20, color: pressedTextColor),
            )
          ],
        ),
      ),
    );
  }
}
