import 'package:flutter/material.dart';

class Medicine {
  IconData icon;
  String name;
  String info;
  String time;

  @override
  String toString() {
    return "$icon;$name;$info;$time";
  }

  factory Medicine.fromString(String data) {
    List split = data.split(";");
    return Medicine(split[0], split[1], split[2], split[3]);
  }

  Medicine(this.icon, this.name, this.info, this.time);
}
