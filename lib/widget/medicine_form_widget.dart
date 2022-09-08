import 'package:flutter/material.dart';

class MedicineFormWidget extends StatelessWidget {
  final IconData icon;
  final String name;
  final Function onPress;
  final Color pressedColor;
  final Color pressedTextColor;
  const MedicineFormWidget(
      {Key? key,
      required this.icon,
      required this.onPress,
      required this.pressedColor,
      required this.name,
      required this.pressedTextColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress.call();
      },
      child: Container(
        width: 96,
        decoration: BoxDecoration(color: pressedColor, borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 4),
            Icon(
              icon,
              color: pressedTextColor,
            ),
            SizedBox(height: 8),
            Text(name, style: TextStyle(fontSize: 16, color: pressedTextColor)),
          ],
        ),
      ),
    );
  }
}
