import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medicine_reminder_app/add_new_medicine_pages/add_new_medicine_page3.dart';
import 'package:medicine_reminder_app/widget/how_to_take_widget.dart';

enum EatingTimeStatus { before, whileEating, after }

class AddNewMedicinePage2 extends StatefulWidget {
  final IconData medicineForm;
  final String medicineName;
  const AddNewMedicinePage2({Key? key, required this.medicineForm, required this.medicineName}) : super(key: key);

  @override
  State<AddNewMedicinePage2> createState() => _AddNewMedicinePage2State();
}

class _AddNewMedicinePage2State extends State<AddNewMedicinePage2> {
  EatingTimeStatus? eatingTimeStatus;
  TextEditingController controller = TextEditingController();
  List position = [14, 48, 82];
  List times = [];
  int? selectedIndex;
  Map<EatingTimeStatus, String> eatingTimeMap = {
    EatingTimeStatus.before: '30 min before meal',
    EatingTimeStatus.whileEating: 'while eating',
    EatingTimeStatus.after: '30 min after meal',
  };

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
                width: MediaQuery.of(context).size.width / 3 * 2,
                height: 5,
                color: Colors.cyan,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 3,
                height: 5,
                color: Colors.cyan[100],
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
                'How many caps do you need to take at once?',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[700]),
              ),
              SizedBox(height: 12),
              Container(
                height: 56,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade500),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Center(
                    child: TextField(
                      cursorHeight: 24,
                      cursorColor: Colors.black,
                      controller: controller,
                      decoration: InputDecoration.collapsed(hintText: ''),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                'Add time when you need to take the medicine',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[700]),
              ),
              IconButton(
                  onPressed: () async {
                    final pickedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );
                    if (pickedTime != null) {
                      times.add(pickedTime.format(context));
                      setState(() {});
                    } else {
                      print("Time is not selected");
                    }
                  },
                  icon: Icon(
                    Icons.add,
                  )),
              SizedBox(
                height: 32,
              ),
              Text(
                'How to take your medicine?',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[700]),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                      3,
                      (i) => HowTheTakeWidget(
                            onPressed: () {
                              eatingTimeStatus = EatingTimeStatus.values[i];
                              selectedIndex = i;
                              setState(() {});
                            },
                            colorPlate: selectedIndex == i ? Colors.cyan : Colors.grey.shade400,
                            colorMedicine: selectedIndex == i ? Colors.redAccent : Colors.black,
                            left: position[i],
                          ))),
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
                'Next >',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            onTap: () {
              if (controller.text.isNotEmpty) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddNewMedicinePage3(
                              medicineForm: widget.medicineForm,
                              medicineName: widget.medicineName,
                              medicineInfo:
                                  '${controller.text} ${selectedIndex != null ? '|' : ''} ${eatingTimeMap[eatingTimeStatus]}',
                              eatingTime: '1',
                            )));
              }
            },
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
