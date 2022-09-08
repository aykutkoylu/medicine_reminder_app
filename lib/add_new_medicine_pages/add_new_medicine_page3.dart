import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_reminder_app/classes/medicine.dart';
import 'package:medicine_reminder_app/medicine_data.dart';
import 'package:medicine_reminder_app/widget/select_days_widget,.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNewMedicinePage3 extends StatefulWidget {
  final IconData medicineForm;
  final String medicineName;
  final String medicineInfo;
  final String eatingTime;
  const AddNewMedicinePage3(
      {Key? key,
      required this.medicineForm,
      required this.medicineName,
      required this.medicineInfo,
      required this.eatingTime})
      : super(key: key);

  @override
  State<AddNewMedicinePage3> createState() => _AddNewMedicinePage3State();
}

class _AddNewMedicinePage3State extends State<AddNewMedicinePage3> {
  late final SharedPreferences preferences;

  List dayName = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  List selectedDays = [];
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  initSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();

    var addedMedicine = preferences.getStringList("medicine") ?? [];

    for (int i = 0; i < addedMedicine.length; i++) {
      medicineData.add(Medicine.fromString(addedMedicine[i]));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 12),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 72,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.grey[400],
                      size: 28,
                    )),
                Text('Add New Medicine',
                    style: GoogleFonts.abel(
                      textStyle: TextStyle(fontSize: 24, color: Colors.black87, fontWeight: FontWeight.w600),
                    )),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.xmark,
                      color: Colors.grey[400],
                      size: 28,
                    )),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 5,
                color: Colors.cyan,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 32,
              ),
              Text(
                'Enter treatment duration',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[700]),
              ),
              SizedBox(height: 12),
              SizedBox(
                height: 32,
              ),
              Text(
                'How often will you take your medication?',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  for (int i = 0; i < dayName.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(4.5),
                      child: SelectDaysWidget(
                          dayName: dayName[i],
                          onPress: () {
                            selectedDays.contains(dayName[i])
                                ? selectedDays.remove(dayName[i])
                                : selectedDays.add(dayName[i]);
                            setState(() {});
                          },
                          pressedColor: selectedDays.contains(dayName[i]) ? Colors.redAccent : Colors.grey.shade300,
                          pressedTextColor: selectedDays.contains(dayName[i]) ? Colors.white : Colors.grey.shade600),
                    )
                ],
              ),
            ]),
          ),
          Spacer(),
          InkWell(
            child: Container(
              width: 240,
              height: 40,
              decoration: BoxDecoration(color: Colors.cyan, borderRadius: BorderRadius.all(Radius.circular(40))),
              alignment: Alignment.center,
              child: Text(
                'Done',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              addMedicine();
            },
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  void addMedicine() {
    Medicine medicine = Medicine(widget.medicineForm, widget.medicineName, widget.medicineInfo, '1');
    medicineData.add(medicine);
    setState(() {});
    var addedMedicine = preferences.getStringList("medicine");
    preferences.setStringList("medicine", [if (addedMedicine != null) ...addedMedicine, medicine.toString()]);
  }
}
