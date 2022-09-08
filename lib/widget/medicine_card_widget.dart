import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicine_reminder_app/classes/medicine.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicineCardWidget extends StatefulWidget {
  final Medicine medicine;
  MedicineCardWidget({Key? key, required this.medicine}) : super(key: key);

  @override
  State<MedicineCardWidget> createState() => _MedicineCardWidgetState();
}

class _MedicineCardWidgetState extends State<MedicineCardWidget> {
  List<String>? selected;
  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  initSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
    selected = preferences.getStringList("selected");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        elevation: 8,
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
              color: selected != null
                  ? !selected!.contains(widget.medicine.name)
                      ? Colors.white
                      : Colors.blue.shade700
                  : Color(0xff),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(
            children: [
              SizedBox(width: 8),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.cyan.withOpacity(0.2),
                ),
                alignment: Alignment.center,
                child: Icon(
                  widget.medicine.icon,
                  color: Colors.cyan,
                  size: 20,
                ),
              ),
              SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.medicine.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.medicine.info,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                child: FaIcon(
                  FontAwesomeIcons.circleCheck,
                  size: 20,
                ),
                onTap: () {
                  preferences.setStringList("selected", []);
                  selected!.add(widget.medicine.name);
                  setState(() {});
                },
              ),
              SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}
